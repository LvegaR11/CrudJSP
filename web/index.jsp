<%-- 
    Document   : index
    Created on : 4/11/2024, 8:27:22 p. m.
    Author     : LUIS VEGA
--%>

<%@page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language= "java" %>
<%@ page import="Domain.Model.User"%>

<html>
    <head>
        <title>Pagina de inicio</title>
    </head>
    <body>
        <h1>Bienvenido a la aplicación de gestión de usuarios</h1>

        <%-- Verificamos que el usuario ha iniciado sesión --%>
        <%User loggedInUser = (User) session.getAttribute("loggedInUser"); %>
            
         <%if (loggedInUser == null) { %>
            <%-- Si ha iniciado sesión, mostramos la opción login --%>
            <h3>No has iniciado sesión</h3>
            <a href="<% request.getContextPaht() %>/Controllers/UserController.jsp?action=login">Iniciar sesión</a>
        <%} else { %>
            <%-- Si ha iniciado sesión, mostrar el meú de gestión de usuarios --%>
            <h3>Bienvenido, <%= loggedInUser.getNombre() %>(Has iniciado sesión)</h3>
            <ul>
                <li><a href="<% request.getContextPaht() %>/Controllers/UserController.jsp?action=showCreateForm">Agregar usuario</a></li>
                <li><a href="<% request.getContextPaht() %>/Controllers/UserController.jsp?action=showFindForm">Buscar usuario</a></li>
                <li><a href="<% request.getContextPaht()%> /Controllers/UserController.jsp?action=listAll">Listar todos los usuarios</a></li>
            </ul>
            <br>
            <a href="<%request.getContextPaht()%>/Controllers/UserController.jsp?action=logout">Cerrar sesión</a>
            <% } %>
    </body>
</html>
