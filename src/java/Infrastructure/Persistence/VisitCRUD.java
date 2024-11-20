/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Infrastructure.Persistence;

/**
 *
 * @author LUIS VEGA
 */
import Domain.Model.Visit;
import Infrastructure.Database.ConnectionDbMySql;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VisitCRUD {
    
    public List<Visit> getAllVisit(){
        List<Visit> visitList = new ArrayList<>();
       String query = "SELECT * FROM visit";

       try{
           Connection connection = ConnectionDbMySql.getConnection();
           Statement stmt = connection.createStatement();
           ResultSet rs = stmt.executeQuery(query);
           while(rs.next()){
               visitList.add(new Visit(rs.getInt("id"),
               rs.getString("location"),
               rs.getFloat("duration"),
               rs.getInt("number_of_persons"),
               rs.getString("visit_date"),
               rs.getString("user_id")
               ));
           }
       }catch(Exception e){
           e.printStackTrace();
       }
       return visitList;

}

public void addVisit(Visit visit){
    String query = "INSERT INTO visit(location,duration,number_of_persons,visit_date,user_id) VALUES(?,?,?,?,?)";
    try{
        Connection connection = ConnectionDbMySql.getConnection();
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setString(1, visit.getLocation());
        stmt.setFloat(2, visit.getDuration());
        stmt.setInt(3, visit.getNumberOfPersons());
        stmt.setString(4, visit.getVisitDate());
        stmt.setString(5, visit.getUserId());
        stmt.executeUpdate();
    }catch(Exception e){
        e.printStackTrace();
    }
}

public void updateVisit(Visit visit){
    String query = "UPDATE visit SET location = ?, duration = ?, number_of_persons = ?, visit_date = ?, user_id = ? WHERE id = ?";
    try{
        Connection connection = ConnectionDbMySql.getConnection();
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setString(1, visit.getLocation());
        stmt.setFloat(2, visit.getDuration());
        stmt.setInt(3, visit.getNumberOfPersons());
        stmt.setString(4, visit.getVisitDate());
        stmt.setString(5, visit.getUserId());
        stmt.setInt(6, visit.getId());
        stmt.executeUpdate();
    }catch(Exception e){
        e.printStackTrace();
    }
}

public void deleteVisit(int id){
    String query = "DELETE FROM visit WHERE id = ?";
    try{
        Connection connection = ConnectionDbMySql.getConnection();
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }catch(Exception e){
        e.printStackTrace();
    }
}

public Visit getVisitById(int id){
    String query = "SELECT * FROM visit WHERE id = ?";
    Visit visit = null;
    try{
        Connection connection = ConnectionDbMySql.getConnection();
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            visit = new Visit(rs.getInt("id"),
            rs.getString("location"),
            rs.getFloat("duration"),
            rs.getInt("number_of_persons"),
            rs.getString("visit_date"),
            rs.getString("user_id")
            );
        }
    }catch(Exception e){
        e.printStackTrace();
    }
    return visit;
}

public List<Visit> getVisitByUserId(String userId){
    String query = "SELECT * FROM visit WHERE user_id = ?";
    List<Visit> visitList = new ArrayList<>();
    try{
        Connection connection = ConnectionDbMySql.getConnection();
        PreparedStatement stmt = connection.prepareStatement(query);
        stmt.setString(1, userId);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            visitList.add(new Visit(rs.getInt("id"),
            rs.getString("location"),
            rs.getFloat("duration"),
            rs.getInt("number_of_persons"),
            rs.getString("visit_date"),
            rs.getString("user_id")
            ));
        }
    }catch(Exception e){
        e.printStackTrace();
    }
    return visitList;
}




}

