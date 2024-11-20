/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Domain.Model;

/**
 *
 * @author LUIS VEGA
 */
public class Visit {
    
    private int id;
    private String location;
    private float duration;
    private int number_of_persons;
    private String visit_date;
    private String user_id;

    public Visit() {
    }

    public Visit(int id, String location, float duration, int number_of_persons, String visit_date, String user_id) {
        this.id = id;
        this.location = location;
        this.duration = duration;
        this.number_of_persons = number_of_persons;
        this.visit_date = visit_date;
        this.user_id = user_id;
    }

    public Visit(String location, float duration, int number_of_persons, String visit_date, String user_id) {
        this.location = location;
        this.duration = duration;
        this.number_of_persons = number_of_persons;
        this.visit_date = visit_date;
        this.user_id = user_id;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public float getDuration() {
        return duration;
    }

    public void setDuration(float duration) {
        this.duration = duration;
    }

    public int getNumberOfPersons() {
        return number_of_persons;
    }

    public void setNumberofpersons(int number_of_persons) {
        this.number_of_persons = number_of_persons;
    }

    public String getVisitDate() {
        return visit_date;
    }

    public void setVisitDate(String visit_date) {
        this.visit_date = visit_date;
    }

    public String getUserId() {
        return user_id;
    }

    public void setUserId(String user_id) {
        this.user_id = user_id;
    }
    
    
}
