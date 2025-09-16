package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import Model.UserService;
import Dao.DBConnection;
import java.io.IOException;
import java.sql.*;


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
        String telefono = request.getParameter("telefono");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection(); 
            UserService userService = new UserService();
            

            if (userService.registerUser(nome,email, telefono,password, conn)) {
                // Registrazione avvenuta con successo
                request.setAttribute("notifica", "Account creato correttamente ✔️!");
                request.setAttribute("coloreNotifica", "#16a34a"); //verde= 16a34a || rosso=dc2626
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                dispatcher.forward(request, response);
            } else {
                // Username già esistente
                request.setAttribute("notifica", "Username già esistente ❌!");
                request.setAttribute("coloreNotifica", "#dc2626"); 
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
