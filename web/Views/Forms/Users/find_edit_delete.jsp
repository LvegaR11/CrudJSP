<%-- 
    Document   : find_edit_delete
    Created on : 4/11/2024, 8:25:26 p. m.
    Author     : LUIS VEGA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Buscar, Editar o Eliminar Usuario</title>
        <script>
            //Funcion: Habilitar botones, Editar y eliminar
            function enablebuttons() {
                document.getElementById("editBtn").disabled = false;
                document.getElementById("deleteBtn").disabled = false;
            }

            //Funcion para desabilitar lo botones de Edita y Eliminar 
            function disablebuttons() {
                document.getElementById("editBtn").disabled = false;
                document.getElementById("deleteBtn").disabled = false;
            }

            //Funcion : Cmbiar acción del formulario y confirmar la eliminacion
            function setActionAndSubmit(action, confirmMessage) {
                if (confirmMessage) {
                    if (!confiirm(confirmMessage)) {
                        return;
                    }
                }
                document.getElementById("actionImput").value = action;
                document.getElementById("userForm").submit();
            }
        </script>

    </head>
    <body onload="<%= (session.getAttribute("searchedUser") != null) ? "enableButtons()" : "disableButtons()" %>">
        <h1>Buscar, Editar o Eliminar Usuario</h1>

        <%-- Mensaje de error o éxito --%>
        <%if (request.getAttribute("errorMessage") != null) {%>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>

        <%if (request.getAttribute("successMessage") != null) { %>
            <p style="color: green;"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <%-- Formulario pra buscar editar y eliminra --%>
        <from id="userForm" action = "<%= request.getContextPath() %>/Controllers/UserController.jsp" method="post">
              <!-- El valor cambiará dinamicamente  -->
              <input type="hidden" id="actionInput" name="action" value="search">
              
              <label for="searchCode">Código del usuario</label><br>
              <input type="text" id="code" name="code" required value="
                    <%= session.getAttribute("searchUser") != null ?
                            ((User) session.getAttribute("searchUser")).getCode() 
                    : "" %>">
              <br><br>

        <%-- Detalles del usuario (despues de la búsqueda) --%>
        <% User sessionUser = (User) session.getAttribute("searchedUser"); %>

        <%if (sessionUser != null) { %>
            <h3>Detalles del Usuario</h3>
            <p><strong>Codigo:</strong> <%= sessionUser.getCode() %></p>
            <p><strong>Nombre:</strong> <%= sessionUser.getNombre() %></p>
            <p><strong>email:</strong> <%= sessionUser.getEmail() %></p>

            <label for="name">Nuevo Nombre:</label><br>
            <input type="text" id="name" name="name" value="<%= sessionUser.getNombre() %>" required>
            <br>
            <br>

            <label for="email"> Nuevo Email</label><br>
            <input type="email" id="email" name="email" value="<%= sessionUser.getEmail() %>" required>
            <br>
            <br>

            <label for="password">Nueva Contraseña</label><br> 
            <input type="password" id="password" name="password" required>
        <% } elese { %>
            <p>No se ha buscado ningún usuario aun o el usuario buscado no existe</p>
        <% } %>

        <br>
        
        <%-- Botones en la misma fila --%>
        <button type="submit" onclick="setActionAndSubmit('search')"
                id="searchBtn">Buscar Usuario</button>
        <button type="button" id="editBtn" disabled
                 onclick="setActionAndSubmit('update', '¿Estás seguro de que quieres editar este usuario?')">
                 Editar Usuario
        </button>
        <button type="button" id="deleteBtn" disabled
                onabort="setActionAndSubmit('delete', '¿Estás seguro que quieres eliminar este usuario?')">
                Eliminar Usuario
        </button>

    </form>

    <br>
    <a href="<%= requert.getConextPath() %>/index.jsp">MENU PRINCIPAL</a>
    </body>
</html>
