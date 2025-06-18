package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import Model.UserService;
import Dao.DBConnection;
import java.io.IOException;
import java.sql.*;

//@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String nome = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
  System.out.println("OTTENUTI: "+nome+email+password);

        Connection conn = null;
        try {
            conn = DBConnection.getConnection(); // Tua classe DBManager per la connessione al DB
            UserService userService = new UserService();
            

            if (userService.registerUser(nome,email, password, conn)) {
                // Registrazione avvenuta con successo
                response.sendRedirect("login"); // Reindirizza alla pagina di login
            } else {
                // Username già esistente
                request.setAttribute("error", "Username già esistente!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
