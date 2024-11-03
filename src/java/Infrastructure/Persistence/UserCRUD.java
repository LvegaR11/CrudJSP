package Infrastructure.Persistence;

import Domain.Model.User;
import Infrastructure.Database.ConnectionDbMySql;
import Business.Exceptions.DuplicateUserException;
import Business.Exceptions.UserNotFoundException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LUIS VEGA
 */
public class UserCRUD {

    // Metodo para obener todos los usiarios
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM Users";
        try {
            Connection con = ConnectionDbMySql.getConnection();

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                userList.add(
                        new User(
                                rs.getString("codigo"),
                                rs.getString("password"),
                                rs.getString("nombre"),
                                rs.getString("email")));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    // metodo para agregar usuarios nuevos
    public void addUser(User user) throws SQLException, DuplicateUserException {
        String query = "INSERT INTO Users (codigo, password, nombre, email) VALUES (? , ?, ?, ?) ";
        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, user.getCodigo());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getNombre());
            stmt.setString(4, user.getEmail());

            stmt.executeUpdate();
        } catch (SQLException e) {
            // Excepcion para posibles claves deplicadas
            if (e.getErrorCode() == 1062) {
                throw new DuplicateUserException(
                        "EL usuarion con este codigo y/o email ya extiste en la base de datos");
            } else {
                throw e; // Propagamos la excepcion de SQLException
            }
        }
    }

    // Creamos el metodo para eliminar un usuario
    public void deleteUser(String codigo) throws SQLException, UserNotFoundException {
        String query = "DELETE FROM Users WHERE codigo = ?";

        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, codigo);

            int rowAffected = stmt.executeUpdate();
            if (rowAffected == 0) {
                throw new UserNotFoundException("El usuario con el codigo:" + codigo + "no existe en la base de datos");
            }
        } catch (SQLException e) {
            throw e;
        }
    }

    // Metodo para actualizar un usuario
    public void updateUser(User user) throws SQLException, UserNotFoundException {
        String query = "UPDATE Users SET codigo= ?, password = ?, nombre = ?, email = ?";

        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, user.getCodigo());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getNombre());
            stmt.setString(4, user.getEmail());

            int rowAffected = stmt.executeUpdate();
            if (rowAffected == 0) {
                throw new UserNotFoundException("El usuario con el codigo " + user.getCodigo() + "No existe");
            }
        } catch (SQLException e) {
            throw e;
        }
    }

    // Metodo para obtener un usuario por su codigo
    public User getUserByCode(String codigo) throws SQLException, UserNotFoundException {
        String query = "SELECT * FROM Users WHERE codigo = ?";
        User user = null;

        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, codigo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(rs.getString("codigo"), rs.getString("password"), rs.getString("nombre"),
                        rs.getString("email"));
            } else {
                throw new UserNotFoundException("El usuario con  el codigo: " + codigo + "no existe");
            }
        } catch (SQLException e) {
            throw e;

        }
        return user;
    }

    // Metodo para autenticar un usuario por email y contraseña (Login)
    public User getUserByEmailAndPassword(String email, String password) throws SQLException, UserNotFoundException {
        User user = null;
        String query = "SELECT * FROM Users WHERE email = ? AND password = ?";

        try {
            Connection con = ConnectionDbMySql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);

            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getString("codigo"),
                        rs.getString("password"),
                        rs.getString("nombre"),
                        rs.getString("email")

                );
            } else {
                var message = "Los datos ingresados son incorrecto. El usuario no existe";
                throw new UserNotFoundException(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            ;
        }
        return user;
    }

    // Metodo para Obtener un usuario por medio de su email
    public User getUserByEmail(String email) throws SQLException, UserNotFoundException {
        User user = null;
        String query = "SELECT * FROM Users WHERE email = ?";
        try (Connection con = ConnectionDbMySql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getString("codigo"),
                        rs.getString("password"),
                        rs.getString("nombre"),
                        rs.getString("email"));
            } else {
                throw new UserNotFoundException("El usuario con el email: " + email + " no existe");
            }
        }
        return user;
    }

    // Metodo para buscar un usuario por nombre o email
    public List<User> searchUsers(String searchtTerm) {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM Users "
                + "WHERE nombre LIKE ? OR email LIKE ?";
        try {
            Connection con = ConnectionDbMySql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);

            stmt.setString(1, "%" + searchtTerm + "%");
            stmt.setString(2, "%" + searchtTerm + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                userList.add(
                        new User(
                                rs.getString("codigo"),
                                rs.getString("password"),
                                rs.getString("nombre"),
                                rs.getString("email")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

}
