package controller;

import java.io.IOException;
import java.sql.SQLException;

import Model.UserService;
import Model.Recensione;
import Dao.RecensioneDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RecensioniServlet  extends HttpServlet {
	

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//CONTROLLO SE L'ARTICOLO è STATO EFFETTIVAMENTE ACQUISTATO
		
		HttpSession session = request.getSession(false);


		if (session == null || session.getAttribute("username") == null) {
				request.getRequestDispatcher("/Login.jsp").forward(request, response);
			return;
		}


		
		String mail = (String) session.getAttribute("email");
		int idUtente = UserService.getIdByMail(mail,(String) session.getAttribute("role"));
		
		int idProdotto = Integer.parseInt(request.getParameter("id_prodotto"));
		int punteggio = Integer.parseInt(request.getParameter("punteggio"));
		String descrizione = request.getParameter("descrizione");
		Recensione r = new Recensione(punteggio,descrizione,idUtente,idProdotto);
		try {
			RecensioneDAO.addRecensione(r);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/schedaprodotto?id=" + idProdotto);
	}
}
