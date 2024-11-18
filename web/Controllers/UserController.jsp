<%-- 
    Document   : UserController
    Created on : 4/11/2024, 8:22:14 p.�m.
    Author     : LUIS VEGA
--%>

<%page import= "java.util.List"%>
<%page import= "Domain.Model.User"%>
<%page import ="java.sql.SQLException"%>
<%page import ="Business.Exception.DuplicatedCodeException"%>
<%page import = "java.io.IOException"%> <!-- IMPORTACION DE IOExecption -->
<%page import = "jakata.servlet.servletException"%> <!-- IMPORTACION DE servletException -->
<%page import = "jakata.http.HttpServletRequest"%> <!-- IMPORTACION DE httpServletRequest -->
<%page import = "jakata.http.HttpServletResponse"%> <!-- IMPORTACION DE httpServletResponse -->
<%page import = "jakata.http.HttpSession"%> <!-- IMPORTACION DE httpSession -->
<%page import = "Business.Service.UserService"%>
<% import = "Business.Exception.UserNotFoundException"%>


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
            handleAuthenticate(request, response, session);
            break;
        case "showCreateForm":
            showCreateUserForm(request, response);
            break;

        case "create"
            hendleCreateUser(request, response, userService);
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
        case "deletefl"
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


    //metodo para mostrar el formulario de login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            trows servletException, IOException {
        session.invalidate(); //Cerramos la sesion existente
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }

    //metodo para autenticar el usuario
    private void handleAuthenticate(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
        try {
            User user = userService.authenticate(email, password);
            session.setAttribute("loggedInUser", loggedInUser); //Guardamos el usuario en la sesion
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch(UserNotFoundException e){
            request.setAtribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp").forward(request, response);
        } catch(SQLException e){
            request.setAtribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp").forward(request, response);
        }   
    }


    //Mostrar el formulario de creaci�n de usuario
    private void showCreateUserForm(HttpServletRequest request, HttpServletResponse response)
            throws servletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/create.jsp");
    }

    //Metodo para cerar un nuevio usuario (deslues de enviar el formualio de creaci�n)
    private void hadleCreateUser(HttpServletRequest request, httpServletResponse response, UserService userService)
            throws servletException, IOException {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String codido = request.getParameter("codigo");

        try {
            User user = new User(nombre, email, password, codigo);
            request.setAttribute("successMessage", "Usuario creado correctamente");
            handleListAllUsers(request, response, userService);
        } catch (DuplicatedCodeException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/create.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher ("/Views/Forms/Users/create.jsp").forward(request, response);
        }
    }


    //Mostrar el formulario para editar un usuario
    private void showFindForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/find_edit_delete.jsp");
    }

    //Metodo para buscar un usuario
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
                String searchCode = request.getParameter("codigo");   

        try {
            User user = userService.getUserByCode(searchCode);
            session.setAttribute("searchUser", user); //Guardamos el usuario en la sesion
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            session.setAtribute("searchUser"); //Limpiamos la sesion si no se encuentra el usuario
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error al conectar con la base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    //Mostrar el formulario para editar un usuario
    private void showeditUserForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
        String code = request.getParameter("codigo");
        try {
            User user = userService.getUserByCode(codido);
            session.setAttribute("userToEdit", user); //Guardamos el usuario en la sesion
            request.getRequestDispatcher("/Views/Forms/Users/edit.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            session.setAtribute("userToEdit"); //Limpiamos la sesion si no se encuentra el usuario
            request.getRequestDispatcher("/Views/Forms/Users/edit.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intente nuevamente.");
            request.getRequestDispatcher("/Views/Forms/Users/edit.jsp").forward(request, response);
        }       
    }

    //metodo para actualizar los datos de un usuario
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
        User searchUser = (User) session.getAttribute("searchUser");

        if (searchUser == null) {
            request.setAttribute("errorMessage", "Primero debes buscar un usuario para editar.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
            return;
        }
        String coq =searchUser.getCodigo(); //Usamos el codigo del usuario buscado
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        

        try {
            User user = new User(nombre, email, password, codigo);
            request.setAttribute("successMessage", "Usuario actualizados correctamente");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (DuplicatedCodeException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }

    }

    private void handleDeleteUserFormList(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
        var code = request.getParameter("codigo");

        if (code == null ||codigo.trim().isEmpty()) {
            request.setAttribute("errorMessage", "El codigo es requerido");
            request.getRequestDispatcher("/Views/Forms/Users/delete.jsp").forward(request, response);
            return;
        }

        try {   
            userService.deleteUser(codigo);
            request.setAttribute("successMessage", "Usuario eliminado correctamente");
            handleListAllUsers(request, response, userService);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAllUsers(request, response, userService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error en la base de datos.");
            handleListAllUsers(request, response, userService);
            
        }
      }

      //Metodo para eliminar un usuario
      private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
            throws servletException, IOException {
            User searchUser = (User) session.getAttribute("searchUser");
            if (searchUser == null) {
                request.setAttribute("errorMessage", "Primero debes buscar un usuario para eliminar.");
                request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
                return;
            }
            String codigo = searchUser.getCodigo(); //Usamos el codigo del usuario buscado

            try {
                userService.deleteUser(codigo);
                session.removeAttribute("searchUser");
                request.setAttribute("successMessage", "Usuario eliminado correctamente");catch(UserNotFoundException e){
                    request.setAtribute("errorMessage", e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp").forward(request, response);
                }catch(UserNotFoundException e){
                    request.setAtribute("errorMessage", e.getMessage());
                    response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp").forward(request, response);
                }catch(SQLException e){
                    request.setAtribute("errorMessage", "Error de base de datos.");
                    response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp").forward(request, response);
                }

            }
            
            //Metodo para lsitar todos los usuarios
            private void handleListAllUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService)
                    throws servletException, IOException {
                 try {
                List<User> users = userService.getAllUsers();
                    session.setAttribute("users", users); //Guardamos los usuarios en la sesion
                    request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
                } catch (SQLException e) {
                    request.setAttribute("errorMessage", "Error de base de datos al listar los usuarios.");
                    request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
                }
            }

            //Metodo para cerrar sesion
            private void handleLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
                    throws servletException, IOException {
                session.invalidate(); //Cerramos la sesion existente
                response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
            }