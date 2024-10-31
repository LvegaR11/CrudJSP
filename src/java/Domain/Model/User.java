package Domain.Model;

/**
 *
 * @author LUIS VEGA
 */
public class User {

    private String codigo;
    private String password;
    private String nombre;
    private String email;

    public User() {
    }

    public User(String codigo, String password, String nombre, String eamil) {
        this.codigo = codigo;
        this.password = password;
        this.nombre = nombre;
        this.email = email;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
