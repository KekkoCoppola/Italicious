package controller;

import java.io.IOException;
import java.sql.SQLException;

import Dao.OrdineDAO;

import Model.Ordine;
import Model.Ordine.StatoOrdine;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OrdiniAdminServlet extends HttpServlet{
	@Override 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
    	if (session == null || "user".equals(session.getAttribute("role"))) {
    	    response.sendRedirect("login");
    	    return;
    	}
    	request.setAttribute("paginaCorrente", "gestione_ordini");
    	request.setAttribute("pageTitle", "Gestione Ordini - Italicious");
    	request.setAttribute("contentPage", "ordiniAdmin.jsp"); 
	    request.getRequestDispatcher("layout.jsp").forward(request, response);
	}
	@Override 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
    	if (session == null || "user".equals(session.getAttribute("role"))) {
    	    response.sendRedirect("login");
    	    return;
    	}
    	int id = Integer.parseInt(request.getParameter("idOrdine"));
    	String statoStr = request.getParameter("stato");
    	StatoOrdine stato = StatoOrdine.fromValue(statoStr);
    	try {
			OrdineDAO.updateSoloStato(id, stato);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	request.setAttribute("paginaCorrente", "gestione_ordini");
    	request.setAttribute("pageTitle", "Gestione Ordini - Italicious");
    	request.setAttribute("contentPage", "ordiniAdmin.jsp"); 
	    request.getRequestDispatcher("layout.jsp").forward(request, response);
	}
}
