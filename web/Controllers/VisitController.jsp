<%-- 
    Document   : VisitController
    Created on : 19/11/2024, 10:50:37 p. m.
    Author     : LUIS VEGA
--%>
<%@ page import="java.util.List"%>
<%@page import="Domain.Model.Vist"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.io.IOException"%> <!-- IMPORTACION DE IOExecption -->
<%@page import ="jakarta.servlet.ServletException"%> <!-- IMPORTACION DE servletException -->
<%@page import ="jakarta.servlet.http.HttpServletRequest"%> <!-- IMPORTACION DE httpServletRequest -->
<%@page import ="jakarta.servlet.http.HttpServletResponse"%> <!-- IMPORTACION DE httpServletResponse -->
<%@page import ="jakarta.servlet.http.HttpSession"%> <!-- IMPORTACION DE httpSession -->
<%@page import ="Business.Services.VisitService"%>

<%
    VisitService visitService = new VisitService();
    String action = request.getParameter("action");

    if (action == null) {
        action = "list";
    }

    switch (action) {
        case "listAll":
            handleListVisit(request, response, session, visitService);
            break;
        case "showCreateForm":
            showCreateVisitForm(request, response);
            break;
        case "create":
            handleCreateVisit(request, response, session, visitService);
            break;
        case "showFindForm":
            showFindForm(request, response, session, userService);
            break;
        case "search":
            handleSearch(request, response, session, visitService);
            break;
        case "update":
            handleUpdateVisit(request, response, session, visitService);
            break;
        case "delete":
            handleDeleteVisit(request, response, session, visitService);
            break;
        case "deletefl":
            handleDeleteVisitFormList(request, response, session, visitService);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }
%>
<%!

    //metodo para mostrar todos las visitas
    private void handleListVisit(HttpServletRequest request, HttpServletResponse response, HttpSession session, VisitService visitService)
            throws ServletException, IOException {
        try {
            List<Visit> visit = visitService.getAllVisit();
            request.setAttribute("visits", visit); //Guardamos las visitas en la sesion
            request.getRequestDispatcher("/Views/Forms/Visits/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Visits/list_all.jsp").forward(request, response);
        }
    }
    //metodo para mostrar el formulario de creaci n de visita
    private void showCreateVisitForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Visits/create.jsp");
    }

    //metodo para crear una visita
    private void handleCreateVisit(HttpServletRequest request, HttpServletResponse response, HttpSession session, VisitService visitService)
            throws ServletException, IOException {
        String location = request.getParameter("location");
        float duration = Float.parseFloat(request.getParameter("duration"));
        int number_of_persons = Integer.parseInt(request.getParameter("number_of_persons"));
        String visit_date = request.getParameter("visit_date");
        String user_id = request.getParameter("user_id");

        try {
            visitService.addVisit(new Visit(location, duration, number_of_persons, visit_date, user_id));
            request.setAttribute("successMessage", "Visita creada correctamente");
            handleListVisit(request, response, session, visitService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Visits/create.jsp").forward(request, response);
        }
    }

    // metodo para mostrar el formulario para editar una visita
    private void showFindForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, VisitService visitService)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Visits/find_edit_delete.jsp");
    }

    //metodo para buscar una visita
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, VisitService visitService)
            throws ServletException, IOException {
        String id = request.getParameter("id");   

        try {
            Visit visit = visitService.getVisitById(id);
            session.setAttribute("searchedVisit", visit); //Guardamos la visita en la sesion
            request.getRequestDispatcher("/Views/Forms/Visits/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            session.removeAttribute("searchedVisit"); //Limpiamos la sesion si no se encuentra la visita
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Visits/find_edit_delete.jsp").forward(request, response);
        }
    }

    //Metodo para actualizar las visitas
    private void handleUpdateVisit(HttpServletRequest request, HttpServletResponse response, HttpSession session, VisitService visitService)
            throws ServletException, IOException {
        Visit searchedVisit = (Visit) session.getAttribute("searchedVisit");

        if (searchedVisit == null) {
            request.setAttribute("errorMessage", "Primero debes buscar una visita para editar.");
            request.getRequestDispatcher("/Views/Forms/Visits/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String id = searchedVisit.getId(); //Usamos el id de la visita buscada
        String location = request.getParameter("location") !=null && !request.getParameter("location").isEmpty() ? request.getParameter("location") : searchedVisit.getLocation();
        float duration = request.getParameter("duration") !=null && !request.getParameter("duration").isEmpty() ? Float.parseFloat(request.getParameter("duration")) : searchedVisit.getDuration();
        int number_of_persons = request.getParameter("number_of_persons") !=null && !request.getParameter("number_of_persons").isEmpty() ? Integer.parseInt(request.getParameter("number_of_persons")) : searchedVisit.getNumberOfPersons();
        String visit_date = request.getParameter("visit_date") !=null && !request.getParameter("visit_date").isEmpty() ? request.getParameter("visit_date") : searchedVisit.getVisitDate();
        String user_id = request.getParameter("user_id") !=null && !request.getParameter("user_id").isEmpty() ? request.getParameter("user_id") : searchedVisit.getUserId();

        try {
            visitService.updateVisit(id, location, duration, number_of_persons, visit_date, user_id);
            request.setAttribute("successMessage", "Visita actualizada correctamente");
            request.getRequestDispatcher("/Views/Forms/Visits/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Visits/find_edit_delete.jsp").forward(request, response);
        }
    }

    //Metodo para eliminar una visita
    private void handleDeleteVisit(HttpServletRequest request, HttpServletResponse response, HttpSession session, VisitService visitService)
            throws ServletException, IOException {
        Visit searchVisit = (Visit) session.getAttribute("searchedVisit");
        if (searchVisit == null) {
            request.setAttribute("errorMessage", "Primero debes buscar una visita para eliminar.");
            request.getRequestDispatcher("/Views/Forms/Visits/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String id = searchVisit.getId(); //Usamos el id de la visita buscada

        try {
            visitService.deleteVisit(id);
            session.removeAttribute("searchVisit");
            request.setAttribute("successMessage", "Visita eliminada");
            handleListVisit(request, response, session, visitService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error en la base de datos.");
            handleListVisit(request, response, session, visitService);
        }
    }

    

%>
