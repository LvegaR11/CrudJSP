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

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user";

        try {
            Connection conn = ConnectionDbMySql.getConnection();

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                users.add(new User(rs.getString("id"), rs.getString("password"), rs.getString("name"),
                        rs.getString("last_name"), rs.getString("role"), rs.getString("email"),
                        rs.getString("phone"), rs.getString("status"), rs.getString("created_at")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public void addUser(User user) throws SQLException, DuplicateUserException {
        String query = "INSERT INTO user ( password, name, last_name, role, email, phone, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getLast_name());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getStatus());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            if (e.getErrorCode() == 1062) {
                throw new DuplicateUserException("User already exists");
            }
            throw e;
        }
    }

    public void updateUser(User user) throws SQLException, UserNotFoundException {
        String query = "UPDATE user SET password = ?, name = ?, last_name = ?, role = ?, email = ?, phone = ?, status = ? WHERE id = ?";
        try (Connection conn = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getLast_name());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getStatus());
            stmt.setString(8, user.getId());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserNotFoundException("User not found with id: " + user.getId());
            }
        } catch (SQLException e) {
            throw e;
        }
    }

    public void deleteUser(String id) throws SQLException, UserNotFoundException {
        String query = "DELETE FROM user WHERE id = ?";
        try (Connection conn = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserNotFoundException("User not found with id: " + id);
            }
        } catch (SQLException e) {
            throw e;
        }
    }

    public User getUserById(String id) throws SQLException, UserNotFoundException {
        String query = "SELECT * FROM user WHERE id = ?";
        User user = null;
        try (Connection conn = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(rs.getString("id"), rs.getString("password"), rs.getString("name"),
                        rs.getString("last_name"), rs.getString("role"), rs.getString("email"),
                        rs.getString("phone"), rs.getString("status"), rs.getString("created_at"));
            } else {
                throw new UserNotFoundException("User not found with id: " + id);
            }
        } catch (SQLException e) {
            throw e;
        }
        return user;
    }

    public User getUserByEmailAndPassword(String email, String password) throws UserNotFoundException {
        String query = "SELECT * FROM user WHERE email = ? AND password = ?";
        User user = null;
        try (Connection conn = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(rs.getString("id"), rs.getString("password"), rs.getString("name"),
                        rs.getString("last_name"), rs.getString("role"), rs.getString("email"),
                        rs.getString("phone"), rs.getString("status"), rs.getString("created_at"));
            } else {
                throw new UserNotFoundException("User not found with email: " + email);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByEmail(String email) throws UserNotFoundException {
        String query = "SELECT * FROM user WHERE email = ?";
        User user = null;
        try (Connection conn = ConnectionDbMySql.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(rs.getString("id"), rs.getString("password"), rs.getString("name"),
                        rs.getString("last_name"), rs.getString("role"), rs.getString("email"),
                        rs.getString("phone"), rs.getString("status"), rs.getString("created_at"));
            } else {
                throw new UserNotFoundException("User not found with email: " + email);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> searchUsers(String search) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user WHERE name LIKE CONCAT('%',?,'%') OR last_name LIKE CONCAT('%',?,'%') OR email LIKE CONCAT('%',?,'%')";

        try {
            Connection conn = ConnectionDbMySql.getConnection();

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                users.add(new User(rs.getString("id"), rs.getString("password"), rs.getString("name"),
                        rs.getString("last_name"), rs.getString("role"), rs.getString("email"),
                        rs.getString("phone"), rs.getString("status"), rs.getString("created_at")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
}
