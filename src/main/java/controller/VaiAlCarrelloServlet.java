package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


public class VaiAlCarrelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object utente = (session != null) ? session.getAttribute("utente") : null;

        if (utente != null) {
            response.sendRedirect("/carrello.jsp");
        } else {
            response.sendRedirect("/Italicious/login");
        }
    }
}
