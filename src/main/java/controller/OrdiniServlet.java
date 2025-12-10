package controller;

import java.io.IOException;

import Model.UserService;
import Model.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OrdiniServlet extends HttpServlet{
	@Override 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
    	if (session == null || session.getAttribute("username")==null) {
    	    response.sendRedirect("login");
    	    return;
    	}
    	request.setAttribute("paginaCorrente", "ordini");
    	request.setAttribute("pageTitle", "I Miei Ordini - Italicious");
    	request.setAttribute("contentPage", "ordini.jsp"); 
	    request.getRequestDispatcher("layout.jsp").forward(request, response);
	}
	@Override 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
    	if (session == null || session.getAttribute("username")==null) {
    	    response.sendRedirect("login");
    	    return;
    	}
    	request.setAttribute("paginaCorrente", "ordini");
    	request.setAttribute("pageTitle", "I Miei Ordini - Italicious");
    	request.setAttribute("contentPage", "ordini.jsp"); 
	    request.getRequestDispatcher("layout.jsp").forward(request, response);
	}
}
