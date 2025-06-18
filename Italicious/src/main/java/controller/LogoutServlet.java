package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

//@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ottieni la sessione corrente, se esiste
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            session.invalidate(); // Invalida la sessione
        }
        
        // Reindirizza l'utente alla pagina di login (o homepage)
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
