<%-- 
    Document   : list_all
    Created on : 19/11/2024, 11:14:24 p. m.
    Author     : LUIS VEGA
--%>
<%@ page import="java.util.List"%>
<%@page import="Domain.Model.Visit"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de visitas</title>
    </head>
    <body>
        <h1>Lista de visitas</h1>

        <%-- Mensaje de error o de éxito --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color:red"><%= request.getAttribute("errorMessage") %></p>
        <% } else if (request.getAttribute("successMessage") != null) { %>
            <p style="color:green"><%= request.getAttribute("successMessage") %></p>
        <% } %>


        <%-- Tabla para mostra la listade visitas --%>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Ubicación</th>
                <th>Duración</th>
                <th>Número de personas</th>
                <th>Fecha de visita</th>
                <th>Usuario</th>
                <th>Acciones</th>
            </tr>
            <%
                List<Visit> visits = (List<Visit>) request.getAttribute("visits");
                for (Visit visit : visits) {
            %>
            <tr>
                <td><%= visit.getId() %></td>
                <td><%= visit.getLocation() %></td>
                <td><%= visit.getDuration() %></td>
                <td><%= visit.getNumberOfPersons() %></td>
                <td><%= visit.getVisitDate() %></td>
                <td><%= visit.getUserId() %></td>
                <td>
                    <a href="<%= request.getContextPath() %>/Controllers/VisitController.jsp?action=showFindForm&id=<%= visit.getId() %>">Editar</a>
                    <a href="<%= request.getContextPath() %>/Controllers/VisitController.jsp?action=deletefl&id=<%= visit.getId() %>">Eliminar</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <br>
        <a href="<%= request.getContextPath() %>/Controllers/VisitController.jsp?action=showCreateForm ">Crear nueva visita</a>
    </body>
</html>
