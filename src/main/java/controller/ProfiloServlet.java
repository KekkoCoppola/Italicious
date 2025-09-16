package controller;

import java.io.IOException;

import Model.UserService;
import Model.Utente;
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
	    	int id = Integer.parseInt(request.getParameter("id"));
	    	String nome = request.getParameter("nome");
	    	String mail = request.getParameter("mail");
	    	String telefono = request.getParameter("telefono");
	    	String indirizzo = request.getParameter("indirizzo");
	    	String fatturazione = request.getParameter("fatturazione");
	    	Utente u = new Utente();
	    	u.setId(id);
	    	u.setNome(nome);
	    	u.setMail(mail);
	    	u.setTelefono(telefono);
	    	u.setIndirizzo(indirizzo);
	    	u.setFatturazione(fatturazione);
	    	System.out.println("FATTURAZIONE INSERITA: "+u.getFatturazione());
	    	UserService.updateUtente(u, (String) session.getAttribute("role"));
	    	
	    	
	    	
	    	request.setAttribute("paginaCorrente", "profilo");
	    	request.setAttribute("pageTitle", "Profilo - Italicious");
	    	request.setAttribute("contentPage", "profilo.jsp"); 
		    request.getRequestDispatcher("layout.jsp").forward(request, response);
	 }
}
