<%-- 
    Document   : agregar
    Created on : 4/11/2024, 8:24:45 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Usuario</title>
    </head>
    <body>
        <h1>Agregar Usuario</h1>

        <%-- Mensaje de error o de éxito --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color:red"><%= request.getAttribute("errorMessage") %></p>
        <% } else if (request.getAttribute("successMessage") != null) { %>
            <p style="color:green"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <%-- Formulario de creación de usuario --%>
        <form action="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=create" method="post">
           
            <label for="name">Nombre:</label>
            <input type="text" name="name" id="name" required>
            <br><br>
            <label for="last_name">Apellido:</label>
            <input type="text" name="last_name" id="last_name" required>
            <br><br>
            <label for="email">Email:</label>
            <input type="text" name="email" id="email" required>
            <br><br>
            <label for="password">Contraseña:</label>
            <input type="password" name="password" id="password" required>
            <br><br>
            <label for="role">Rol:</label>
            <input type="text" name="role" id="role" required>
            <br><br>
            <label for="phone">Teléfono:</label>
            <input type="text" name="phone" id="phone" required>
            <br><br>
            <label for="status">Estado:</label>
            <input type="text" name="status" id="status" required>
            <br><br>
            <input type="submit" value="Agregar Usuario">
        </form>

        <br>
        <a href="<%= request.getContextPath() %>/index.jsp">Menú Principal</a>
    </body>
</html>
