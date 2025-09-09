package controller;

import java.io.IOException;
import java.util.List;

import Dao.ProdottoDAO;
import Model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SchedaProdottoServlet extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int id = Integer.parseInt(request.getParameter("id"));
	    ProdottoDAO prodotti = new ProdottoDAO();
	    Prodotto prodotto = prodotti.getProdottoById(id);
	    List<Prodotto> prodottiByRegione = ProdottoDAO.getProdottiByRegione(prodotto.getRegione()); 
	    prodottiByRegione.remove(prodotto);
	    System.out.println("PRODOTTO "+prodotto);
	    request.setAttribute("prodotto", prodotto);
	    request.setAttribute("prodottiByRegione", prodottiByRegione);
	    
        request.setAttribute("pageTitle", prodotto.getNome());
    	request.setAttribute("contentPage", "schedaprodotto.jsp"); 
	    request.getRequestDispatcher("layout.jsp").forward(request, response);
	}
}
