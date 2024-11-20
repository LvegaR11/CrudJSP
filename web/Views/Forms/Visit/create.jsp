<%-- 
    Document   : create
    Created on : 19/11/2024, 11:14:03 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar visitas</title>
    </head>
    <body>
        <h1>Agregar visita</h1>
        <%-- Mensaje de error o de éxito --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color:red"><%= request.getAttribute("errorMessage") %></p>
        <% } else if (request.getAttribute("successMessage") != null) { %>
            <p style="color:green"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <%-- Formulario de creación de visita --%>
        <form action="<%= request.getContextPath() %>/Controllers/VisitController.jsp?action=create" method="post">
            <label for="location">Ubicación:</label>
            <input type="text" name="location" id="location" required>
            <br><br>
            <label for="duration">Duración:</label>
            <input type="number" name="duration" id="duration" required>
            <br><br>
            <label for="number_of_persons">Número de personas:</label>
            <input type="number" name="number_of_persons" id="number_of_persons" required>
            <br><br>
            <label for="visit_date">Fecha de visita:</label>
            <input type="date" name="visit_date" id="visit_date" required>
            <br><br>
            <label for="user_id">Usuario:</label>
            <input type="text" name="user_id" id="user_id" required>
            <br><br>
            <input type="submit" value="Agregar visita">
        </form>

        <br>
        <a href="<%= request.getContextPath() %>/index.jsp">Menú Principal</a>
    </body>
</html>
