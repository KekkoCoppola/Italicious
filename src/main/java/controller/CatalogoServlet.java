package controller;

import Dao.ProdottoDAO;
import Model.Prodotto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
//@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodotti = prodottoDAO.getAllProdotti(); 

        System.out.println("👉 [DEBUG] Numero prodotti trovati: " + (prodotti != null ? prodotti.size() : "null"));

        request.setAttribute("prodotti", prodotti); 
        RequestDispatcher dispatcher = request.getRequestDispatcher("/catalogo.jsp");
        dispatcher.forward(request, response);
    }
}