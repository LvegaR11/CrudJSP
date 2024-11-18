<%-- 
    Document   : login
    Created on : 4/11/2024, 8:25:54 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <h1>Iniciar sesión</h1>

        <%--Mesaje de error en casoa de que el usuario ingrese las credenciales incorrectas--%>
        <%if (request.getAttribute("errorMessage") != null) {%>
            <p style="color: red;"><%=request.getAttribute("errorMessage")%></p>
            <% }%>

            <%-- Formulario de login --%>
            <form action="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=authenticate" method="post">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required> <br> <br>
               
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required><br><br>
                
                <input type="submit" value="Ingresar">
            </form>

            <br>
            <a href="<%= request.getContextPath()%>/index.jsp">Volver a la página de inicio</a>
    </body>
</html>
