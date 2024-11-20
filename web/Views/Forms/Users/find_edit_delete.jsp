<%-- 
    Document   : find_edit_delete
    Created on : 4/11/2024, 8:25:26 p. m.
    Author     : LUIS VEGA
--%>

<%@page import="Domain.Model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscar, Editar o Eliminar Usuario</title>
        <script>
            // funcion: habilitar  los botones de edición y eliminación
            function enableButtons() {
              document.getElementById("editBtn").disabled = false;
              document.getElementById("deleteBtn").disabled = false;
            }
            // funcion: deshabilitar los botones de edición y eliminación
            function disableButtons() {
              document.getElementById("editBtn").disabled = true;
              document.getElementById("deleteBtn").disabled = true;
            }

            // funcion: cambiar accion del formulario y confirmar la eliminación
            function setActionAndSubmit(action, confirmMessage) {
                if(confirmMessage){
                    if (!confirm(confirmMessage)) {
                        return;
                    }
                }
                document.getElementById("actionInput").value = action;
                document.getElementById("userForm").submit();
            }
        </script>
    </head>
    <body onload="<%= (session.getAttribute("searchedUser") != null) ? "enableButtons()" : "disableButtons()" %>">
        <h1>Buscar, Editar o Eliminar Usuario</h1>

        <%-- Mensaje de error o de éxito --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color:red"><%= request.getAttribute("errorMessage") %></p>
        <% } else if (request.getAttribute("successMessage") != null) { %>
            <p style="color:green"><%= request.getAttribute("successMessage") %></p>
        <% } %>

        <%-- Formulario de búsqueda de usuario --%>
        <form id="userForm" action="<%= request.getContextPath() %>/Controllers/UserController.jsp" method="post">
           <%-- el valor cambiará según la acción realizada --%>
            <input type="hidden" name="action" id="actionInput" value="search">

          

            <%-- Detalles del usuario (despues de la búsqueda) --%>
            <% User sessionUser = (User) session.getAttribute("searchedUser"); %>

            <% if (sessionUser != null) { %>
                <h3>Detalles del Usuario</h3>
                <p><strong>Código:</strong> <%= sessionUser.getId() %></p>
                <p><strong>Nombre:</strong> <%= sessionUser.getName() %></p>
                <p><strong>Apellido:</strong><%= sessionUser.getLast_name() %></p>
                <p><strong>Email:</strong> <%= sessionUser.getEmail() %></p>
                <p><strong>Teléfono:</strong> <%= sessionUser.getPhone() %></p>
                <p><strong>Estado:</strong> <%= sessionUser.getStatus() %></p>
                <p><strong>Creado en:</strong> <%= sessionUser.getCreated_at() %></p>

                <label for="name">Nuevo Nombre:</label>
                <input type="text" name="name" id="name" value="<%= sessionUser.getName() %>" required>
                <br><br>       
                  <label for="last_name">Nuevo Apellido:</label>
                <input type="text" name="last_name" id="last_name" value="<%= sessionUser.getLast_name()%>" required>
                <br><br>                    
                <label for="password">Nueva Contraseña:</label>
                <input type="password" name="password" id="password" required>
                <br><br>
                <label for="phone">Nuevo Teléfono:</label>
                <input type="text" name="phone" id="phone" value="<%= sessionUser.getPhone() %>" required>
                <br><br>
                <label for="status">Nuevo Estado:</label>
                <input type="text" name="status" id="status" value="<%= sessionUser.getStatus() %>" required>
                <br><br>
        
            <% } else { %>
                <p>No se ha encontrado ningún usuario con ese código.</p>
            <% } %>

            <br>
            <%-- Botones en la misma línea --%>
            <button type="submit" id="searchBtn"  onclick="setActionAndSubmit('search')">Buscar un Usuario</button>
            <button type="button" id="editBtn" disabled onclick="setActionAndSubmit('update', '¿Está seguro de que desea editar este usuario?')">Editar Usuario</button>
            <button type="button" id="deleteBtn" disabled onclick="setActionAndSubmit('delete', '¿Está seguro de que desea eliminar este usuario?')">Eliminar Usuario</button>
            <button type="button" id="lstiVisitBtn" onclick="setActionAndSubmit('listVisit')">Listar Visitas</button>
        </form>

        <br>

        <a href="<%= request.getContextPath() %>/index.jsp">Menú Principal</a>
       
    </body>
</html>
