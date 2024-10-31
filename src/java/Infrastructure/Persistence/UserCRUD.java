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

    //Metodo para obener todos los usiarios
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
                                rs.getString("email"))
                );

            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return userList; 
    }

}
