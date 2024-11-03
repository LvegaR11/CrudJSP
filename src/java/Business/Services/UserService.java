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

    private UserCRUD userCrud;

    public UserService() {
        this.userCrud = new UserCRUD();
    }

    //Metodo para obtener los usuarios 
    public List<User> getAllUser() throws SQLException {
        return userCrud.getAllUsers();
    }

    //Metodo para agregar un usuario nuevo 
    public void createUser(String codigo, String password, String nombre, String email)
            throws DuplicateUserException, SQLException {
        User user = new User(codigo, password, nombre, email);
        userCrud.addUser(user);
    }

    //Metodo para actualizar usuarios 
    public void updateUser (String codigo, String password, String nombre, String email)
            throws UserNotFoundException, SQLException{
        User user = new User(codigo, password, nombre, email);
        userCrud.updateUser(user);
    }

    //Metodo para Eliminar usuario
    public void deleteUser(String codigo) throws UserNotFoundException, SQLException {
        userCrud.deleteUser(codigo);
    }

    //Metodo para obtener un usuario por su codigo
    public User getUserByCode(String codigo) throws UserNotFoundException, SQLException {
        return userCrud.getUserByCode(codigo);
    }

    //Metodo para autenticar usuarios (Login)
    public User loginUser(String codigo, String password) throws UserNotFoundException, SQLException {

        User user = userCrud.getUserByCode(codigo);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        } else {
            throw new UserNotFoundException("Datos incorrectos. No se encontro el usuario o la contraseña es incorrecta.");

        }
    }
    
    //Metodo para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm){
        return userCrud.searchUsers(searchTerm);
    }

}
