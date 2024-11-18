<%-- 
    Document   : agregar
    Created on : 4/11/2024, 8:24:45 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        
        <title>Agregar usuario</title>
    </head>
    <body>
        <h1>Agregar usuario</h1>

        <%-- Mesaje de error o éxito --%>
        <%if (request.getAttribute("message") != null) {%>
            <p style="color: red;"><$=request.getAttribute("message")$></p>
            <% } %>

        <%-- Formulario de agregar usuario --%>
        <form action="<%= request.getContestPath() %>/Controllers/UserController.jsp?action=createUser" method="post">
            <label for="codigo">Código:</label>
            <input type="text" id="codigo" name="codigo" required> <br> <br>
            
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required> <br> <br>
            
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required> <br> <br>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required> <br> <br>
            
            <input type="submit" value="Agregar usuario">

        </form>

        <br>
        <a href="<%= request.getContextPath()%>/index.jsp">Volver a la página de inicio</a>
    </body>
</html>
