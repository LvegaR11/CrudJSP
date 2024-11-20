/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business.Services;

/**
 *
 * @author LUIS VEGA
 */

 import Domain.Model.Visit;
 import Infrastructure.Persistence.VisitCRUD;
 import java.sql.SQLException;
 import java.util.List;

public class VisitService {

    private final VisitCRUD visitCRUD;

    public VisitService() {
        this.visitCRUD = new VisitCRUD();
    }
    
    //Metodo para obtener todas las visita 
    public List<Visit> getAllVisit() throws SQLException{
        return visitCRUD.getAllVisit();
    }

    //Metodo para obtener una visita por id
    public Visit getVisitById(int id) throws SQLException{
        return visitCRUD.getVisitById(id);
    }

    //Metodo para obtener una visita por userId
    public List<Visit> getVisitByUserId(String userId) throws SQLException{
        return visitCRUD.getVisitByUserId(userId);
    }

    //Metodo para agregar una visita
    public void addVisit(Visit visit) throws SQLException{
        visitCRUD.addVisit(visit);
    }

    //Metodo para actualizar una visita
    public void updateVisit(Visit visit) throws SQLException{
        visitCRUD.updateVisit(visit);
    }

    //Metodo para eliminar una visita
    public void deleteVisit(int id) throws SQLException{
        visitCRUD.deleteVisit(id);
    }
}
