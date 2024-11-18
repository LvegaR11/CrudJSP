<%-- 
    Document   : list_all
    Created on : 4/11/2024, 8:25:41 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Domain.Model.User"%>
<%@page import="java.util.List"%>
<html>
    <head>
        <title>Lista de Usuarios</title>
    </head>
    <body>
        <h1>Lisa de Todos los Usuarios</h1>

        <%-- Mesaje de error o éxito --%>
        <%if (request.getAttribute("errorMessage") != null) {%>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <%if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green;"><%= request.getAttribute("successMessage") %></p>
        <% }%>

        <%-- Tabla para mostar la lista de usuarios --%>
        <table border="1">
            <thead>
            <tr>
                <th>Código</th>
                <th>Nombre</th>
                <th>Email</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% List<User> users = (List<users>) session.getAttribute("users"); %>
            <% if (users != null && !users.isEmpty()) { %>
                <% for (User user : users) { %>
                    <tr>
                        <td><%= user.getCode() %></td>
                        <td><%= user.getNombre() %></td>
                        <td>
                            <%--Enlace mailto: para el cliente de correo--%>
                            <a href="mailto:?cc= user.getEmail() %>&subject=Sludos de Luis Fernando Vega Rodríguez&body=Cordial saludo mi estimado">
                                <%= user.getEmail() %>
                            </a>
                        </td>
                        <td>
                            <a href="UserController.jsp?action=search&code=<%= user.getCode() %>">Editar</a>
                            <a href="UserController.jsp?action=delete&code=<%= user.getCode() %>" onclick="return confirm('¿Estás seguro que quieres eliminar este usuario?')">Eliminar</a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="4">No hay usuarios registrados</td>
                </tr>
            <% } %>
            </tbody>
        </table>

        <br>
        <a href="<%= request.getConextPath() %>/Controllers/UserController.jsp?action=create">Agregar Nuevo Usuario</a>
    </body> 
</html>
