package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.setAttribute("pageTitle", "Home - Italicious");
    	request.setAttribute("contentPage", "home.jsp"); // <-- Qui lo imposti

        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }
}
