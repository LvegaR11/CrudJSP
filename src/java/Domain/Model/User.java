package Domain.Model;

/**
 *
 * @author LUIS VEGA
 */
public class User {

    private String id;
    private String password;
    private String name;
    private String last_name;
    private String role;
    private String email;
    private String phone;
    private String status;
    private String created_at;

    public User() {
    }

    public User(String id, String password, String name, String last_name, String role, String email, String phone,
            String status, String created_at) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.last_name = last_name;
        this.role = role;
        this.email = email;
        this.phone = phone;
        this.status = status;
        this.created_at = created_at;
    }

    public User(String email, String password, String nombre, String last_name, String role, String phone,
            String status) {
        this.email = email;
        this.password = password;
        this.name = nombre;
        this.last_name = last_name;
        this.role = role;
        this.phone = phone;
        this.status = status;
    }

    public User(String id, String email, String password, String name, String last_name, String role, String phone,
            String status) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.name = name;
        this.last_name = last_name;
        this.role = role;
        this.phone = phone;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreated_at() {
        return created_at;
    }

}


    