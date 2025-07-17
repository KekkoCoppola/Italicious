package controller;

import java.io.IOException;

import Dao.ProdottoDAO;
import Model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SchedaProdottoServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int id = Integer.parseInt(request.getParameter("id"));
	    ProdottoDAO prodotti = new ProdottoDAO();
	    Prodotto prodotto = prodotti.getProdottoById(id);
	    request.setAttribute("prodotto", prodotto);
	    request.getRequestDispatcher("schedaProdotto.jsp").forward(request, response);
	}
}
