package controller;

import java.io.IOException;
import java.util.List;

import Dao.ProdottoDAO;
import Model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	List<Prodotto> prodottiTop3 = ProdottoDAO.getTop3ProdottiByFeedback(); 
    	System.out.println("TOP 3"+prodottiTop3);
    	request.setAttribute("prodottiTop3", prodottiTop3);
    	request.setAttribute("pageTitle", "Home - Italicious");
    	request.setAttribute("contentPage", "home.jsp");

        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }
}
