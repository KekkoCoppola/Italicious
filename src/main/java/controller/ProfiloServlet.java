package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import Dao.DBConnection;
import Model.UserService;
import Model.Utente;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProfiloServlet extends HttpServlet{
	@Override
	 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false); // Otteniamo la sessione esistente, se non c'è è null
	    	if (session == null || session.getAttribute("username")==null) {
	    	    // Se non c'è sessione o username, reindirizza al login
	    	    response.sendRedirect("login");
	    	    return;
	    	}
	    	request.setAttribute("paginaCorrente", "profilo");
	    	request.setAttribute("pageTitle", "Profilo - Italicious");
	    	request.setAttribute("contentPage", "profilo.jsp"); 
		    request.getRequestDispatcher("layout.jsp").forward(request, response);
	 }
	@Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false); // Otteniamo la sessione esistente, se non c'è è null
	    	if (session == null || session.getAttribute("username")==null) {
	    	    // Se non c'è sessione o username, reindirizza al login
	    	    response.sendRedirect("login");
	    	    return;
	    	}
	    	request.setAttribute("paginaCorrente", "profilo");
	    	request.setAttribute("pageTitle", "Profilo - Italicious");
	    	request.setAttribute("contentPage", "profilo.jsp"); 
	    	int id = Integer.parseInt(request.getParameter("id"));
	    	String nome = request.getParameter("nome");
	    	String mail = request.getParameter("mail");
	    	String telefono = request.getParameter("telefono");
	    	String indirizzo = request.getParameter("indirizzo");
	    	String fatturazione = request.getParameter("fatturazione");
	    	try (Connection conn = DBConnection.getConnection()) {
	    	    if (UserService.usernameExistsAcrossTables(conn, nome, id)) {
	    	        request.setAttribute("notifica", "Questo username è già in uso.");
	    	        request.setAttribute("coloreNotifica", "#dc2626");
	    	        request.getRequestDispatcher("layout.jsp").forward(request, response);
	    	        return;
	    	    }
	    	    if (UserService.emailExistsAcrossTables(conn, mail, id)) {
	    	        request.setAttribute("notifica", "Questa mail è già in uso.");
	    	        request.setAttribute("coloreNotifica", "#dc2626");
	    	        request.getRequestDispatcher("layout.jsp").forward(request, response);
	    	        return;
	    	    }
	    	} catch (SQLException | ServletException | IOException e) {
	    	    e.printStackTrace();
	    	}

	    	Utente u = new Utente();
	    	u.setId(id);
	    	u.setNome(nome);
	    	u.setMail(mail);
	    	u.setTelefono(telefono);
	    	u.setIndirizzo(indirizzo);
	    	u.setFatturazione(fatturazione);
	    	System.out.println("FATTURAZIONE INSERITA: "+u.getFatturazione());
	    	
	    	if(UserService.updateUtente(u, (String) session.getAttribute("role"))) {
	    		request.setAttribute("notifica", "Aggiornamento Dati Effettuato.");
    	        request.setAttribute("coloreNotifica", "#16a34a");
	    	}
	    	
	    	
	    	
	    	
		    request.getRequestDispatcher("layout.jsp").forward(request, response);
	 }
}
