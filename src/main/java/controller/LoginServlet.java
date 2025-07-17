package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import Model.UserService;
import Dao.DBConnection;
import java.io.IOException;
import java.sql.*;
//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection(); // Tua classe DBManager per la connessione al DB
            UserService userService = new UserService();

            String role = userService.loginUser(email, password, conn);

            if (role != null) {
                // Login riuscito, imposta la sessione
                HttpSession session = request.getSession(); // Otteniamo la sessione corrente o ne creiamo una nuova
                session.setAttribute("email", email); 
                String username = userService.getUsername(email, password, conn,role);
                session.setAttribute("username", username);
                session.setAttribute("role", role); // Salva il ruolo (user o admin)

                // Redirigi alla pagina corretta in base al ruolo
                if ("admin".equals(role)) {
                    response.sendRedirect("catalogo"); // Dashboard admin
                } else {
                    response.sendRedirect("catalogo"); // Dashboard utente
                }
            } else {
                // Credenziali errate
                request.setAttribute("error", "Email o password errati.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
