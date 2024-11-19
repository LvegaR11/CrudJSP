<%-- 
    Document   : index
    Created on : 4/11/2024, 8:27:22 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Domain.Model.User"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina de Inicio</title>
    </head>
    <body>
        <h1>Bienvenido a la gestión de usuarios</h1>

        <%-- verificamos si el usuario está logueado --%>
        <% User loggedInUser = (User) session.getAttribute("loggedInUser"); %>
        <% if (loggedInUser == null) { %>
            <%-- si no está logueado, redirigimos al login --%>
            <h3> No has iniciado Sesión</h3>
            <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=login">Iniciar Sesión</a>
        <% } else { %>
            <%-- si está logueado, redirigimos al perfil del usuario --%>
            <h3> Bienvenido <%= loggedInUser.getName() %></h3>
            
            <ul>
                <%-- agregar usuarios --%>
                <li><a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=showCreateForm">Agregar Usuario</a></li>
                <%-- buscar usuarios --%>
                <li><a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=showFindForm">Buscar Usuario</a></li>
                <%-- listar usuarios --%>
                <li><a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=listAll">Listar Usuarios</a></li>
            </ul>
            <br>
            <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=logout">Cerrar Sesión</a>
        <% } %>
    </body>
</html>
