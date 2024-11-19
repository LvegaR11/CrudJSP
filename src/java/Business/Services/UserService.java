package Business.Services;

import Business.Exceptions.UserNotFoundException;
import Business.Exceptions.DuplicateUserException;
import Domain.Model.User;
import Infrastructure.Persistence.UserCRUD;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author LUIS VEGA
 */


public class UserService {

    private final UserCRUD userCrud;

    public UserService() {
        this.userCrud = new UserCRUD();
    }

    // Metodo para obtener los usuarios
    public List<User> getAllUser() throws SQLException {
        return userCrud.getAllUsers();
    }

    // Metodo para agregar un usuario nuevo
    public void createUser(String email, String password, String name, String last_name, String role, String phone,
            String status)
            throws DuplicateUserException, SQLException {
        User user = new User(email, password, name, last_name, role, phone, status);
        userCrud.addUser(user);
    }

    // Metodo para actualizar usuarios
    public void updateUser(String id, String password, String name, String lastName, String email, String role, String phone,
            String status)
            throws UserNotFoundException, SQLException {
        User user = new User(id,email, password, name, lastName ,  role, phone, status);
        userCrud.updateUser(user);
    }

    // Metodo para Eliminar usuario
    public void deleteUser(String codigo) throws UserNotFoundException, SQLException {
        userCrud.deleteUser(codigo);
    }

    // Metodo para obtener un usuario por su id
    public User getUserByCode(String id) throws UserNotFoundException, SQLException {
        return userCrud.getUserById(id);
    }

    // Metodo para autenticar usuarios (Login)
    public User loginUser(String email, String password) throws UserNotFoundException, SQLException {

        User user = userCrud.getUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        } else {
            throw new UserNotFoundException(
                    "Datos incorrectos. No se encontro el usuario o la contraseña es incorrecta.");

        }
    }

    // Metodo para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm) {
        return userCrud.searchUsers(searchTerm);
    }

}
