<%-- 
    Document   : login
    Created on : 4/11/2024, 8:25:54 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Iniciar Sesión</h1>

        <%-- Mensaje de error en caso de que se haya producido un error --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color:red"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <%-- Formulario de inicio de sesión --%>
        <form action="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=authenticate" method="post">
            <label for="email">Email:</label>
            <input type="text" name="email" id="email" required>
            <br>
            <label for="password">Contraseña:</label>
            <input type="password" name="password" id="password" required>
            <br>
            <input type="submit" value="Iniciar Sesión">
        </form>

        <br>
        <a href="<%= request.getContextPath() %>/index.jsp">Volver a Inicio</a>
    </body>
</html>
