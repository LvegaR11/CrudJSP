<%-- 
    Document   : UserController
    Created on : 4/11/2024, 8:22:14 p.�m.
    Author     : LUIS VEGA
--%>

<%@ page import="java.util.List"%>
<%@page import="Domain.Model.User"%>
<%@page import="Domain.Model.Visit"%>
<%@page import="Business.Services.VisitService"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="Business.Exceptions.DuplicateUserException"%>
<%@page import ="java.io.IOException"%> <!-- IMPORTACION DE IOExecption -->
<%@page import ="jakarta.servlet.ServletException"%> <!-- IMPORTACION DE servletException -->
<%@page import ="jakarta.servlet.http.HttpServletRequest"%> <!-- IMPORTACION DE httpServletRequest -->
<%@page import ="jakarta.servlet.http.HttpServletResponse"%> <!-- IMPORTACION DE httpServletResponse -->
<%@page import ="jakarta.servlet.http.HttpSession"%> <!-- IMPORTACION DE httpSession -->
<%@page import ="Business.Services.UserService"%>
<%@page import ="Business.Exceptions.UserNotFoundException"%>

<%
    UserService userService = new UserService();
    String action = request.getParameter("action");

    if (action == null) {
        action = "list";
    }

    switch (action) {
        case "login":
            handleLogin(request, response, session);
            break;
        case "authenticate":
            handleAuthenticate(request, response, session, userService);
            break;
        case "listVisit":
            handleListVisit(request, response, session, userService);
            break;
        case "showCreateForm":
            showCreateUserForm(request, response);
            break;

        case "create":
            handleCreateUser(request, response, session, userService);
            break;
        
        case "showFindForm":
            showFindForm(request, response, session, userService);
            break;
        case "search":
            handleSearch(request, response, session, userService);
            break;
        case "update":
            handleUpdateUser(request, response, session, userService);
            break;
        case "delete":
            handleDeleteUser(request, response, session, userService);
            break;
        case "deletefl":
            handleDeleteUserFormList(request, response, session, userService);
            break;
        case "listAll":
            handleListAllUsers(request, response, session, userService);
            break;
        case "logout":
            handleLogout(request, response, session);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }

%>
<%!
    //Metodo para ir a la lista de visitas
    private void handleListVisit(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
        User user = (User) session.getAttribute("searchedUser");
        if (user == null) {
            request.setAttribute("errorMessage", "Primero debes buscar un usuario para ver sus visitas.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String id = user.getId(); //Usamos el id del usuario buscado

    
        response.sendRedirect(request.getContextPath() + "/Controllers/VisitController.jsp?action=listAll&id=" + id);
       
    }

    //metodo para mostrar el formulario de login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        session.invalidate(); //Cerramos la sesion existente
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }

    //metodo para autenticar el usuario
    private void handleAuthenticate(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
        try {
            User loggedInUser = userService.loginUser(email, password);
            session.setAttribute("loggedInUser", loggedInUser); //Guardamos el usuario en la sesion
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch(UserNotFoundException e){
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/login.jsp").forward(request, response);
        } catch(SQLException e){
            request.setAttribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Users/login.jsp").forward(request, response);
        }   
    }


    //Mostrar el formulario de creaci n de usuario
    private void showCreateUserForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/create.jsp");
    }

    //Metodo para crear un nuevo usuario (deslues de enviar el formualio de creaci n)
    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String last_name = request.getParameter("last_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");

        try {
            userService.createUser(email, password, name, last_name, role, phone, status);
            request.setAttribute("successMessage", "Usuario creado correctamente");
            handleListAllUsers(request, response, session, userService);
        } catch (DuplicateUserException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/create.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher ("/Views/Forms/Users/create.jsp").forward(request, response);
        }
    }


    //Mostrar el formulario para editar un usuario
    private void showFindForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/find_edit_delete.jsp");
    }

    //Metodo para buscar un usuario
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
                String searchCode = request.getParameter("id");   

        try {
            User user = userService.getUserByCode(searchCode);
            session.setAttribute("searchedUser", user); //Guardamos el usuario en la sesion
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            session.removeAttribute("searchedUser"); //Limpiamos la sesion si no se encuentra el usuario
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    //Mostrar el formulario para editar un usuario
    private void showeditUserForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            User user = userService.getUserByCode(id);
            session.setAttribute("userToEdit", user); //Guardamos el usuario en la sesion
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", "errorMessage");   
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        }       
    }

    //metodo para actualizar los datos de un usuario
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
        User searchedUser = (User) session.getAttribute("searchedUser");

        if (searchedUser == null) {
            request.setAttribute("errorMessage", "Primero debes buscar un usuario para editar.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String id =searchedUser.getId(); //Usamos el id del usuario buscado
        String name = request.getParameter("name") !=null && !request.getParameter("name").isEmpty() ? request.getParameter("name") : searchedUser.getName();
        String lastName = request.getParameter("last_name") !=null && !request.getParameter("last_name").isEmpty() ? request.getParameter("last_name") : searchedUser.getLast_name();
        String email = request.getParameter("email") !=null && !request.getParameter("email").isEmpty() ? request.getParameter("email") : searchedUser.getEmail();
        String password = request.getParameter("password") !=null && !request.getParameter("password").isEmpty() ? request.getParameter("password") : searchedUser.getPassword();
        String role = request.getParameter("role") !=null && !request.getParameter("role").isEmpty() ? request.getParameter("role") : searchedUser.getRole();
        String phone = request.getParameter("phone") !=null && !request.getParameter("phone").isEmpty() ? request.getParameter("phone") : searchedUser.getPhone();
        String status = request.getParameter("status") !=null && !request.getParameter("status").isEmpty() ? request.getParameter("status") : searchedUser.getStatus();


        try {
            userService.updateUser(id, password, name, lastName, email, role, phone, status );
            request.setAttribute("successMessage", "Usuario actualizados correctamente");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }

    }

    private void handleDeleteUserFormList(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
        var id = request.getParameter("id");

        if (id == null ||id.trim().isEmpty()) {
            request.setAttribute("errorMessage", "El id es requerido");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
            return;
        }

        try {   
            userService.deleteUser(id);
            request.setAttribute("successMessage", "Usuario eliminado correctamente");
            handleListAllUsers(request, response, session, userService);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAllUsers(request, response,session, userService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error en la base de datos.");
            handleListAllUsers(request, response, session, userService);
            
        }
      }

      //Metodo para eliminar un usuario
      private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws ServletException, IOException {
            User searchUser = (User) session.getAttribute("searchedUser");
            if (searchUser == null) {
                request.setAttribute("errorMessage", "Primero debes buscar un usuario para eliminar.");
                request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
                return;
            }
            String id = searchUser.getId(); //Usamos el id del usuario buscado

            try {
                userService.deleteUser(id);
                session.removeAttribute("searchUser");
                request.setAttribute("successMessage", "Usuario eliminado");
                handleListAllUsers(request, response, session, userService);
                }catch(UserNotFoundException e){
                    request.setAttribute("errorMessage", e.getMessage());
                    request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
                }catch(SQLException e){
                    request.setAttribute("errorMessage", "Error de base de datos.");
                    request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
                }

            }
            
            //Metodo para litar todos los usuarios
            private void handleListAllUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
                    throws ServletException, IOException {
                 try {
                List<User> user = userService.getAllUser();
                    request.setAttribute("users", user); //Guardamos los usuarios en la sesion
                    request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
                } catch (SQLException e) {
                    request.setAttribute("errorMessage", "Error de base de datos al listar los usuarios.");
                    request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
                }
            }

            //Metodo para cerrar sesion
            private void handleLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
                    throws ServletException, IOException {
                session.invalidate(); //Cerramos la sesion existente
                response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }
%>     