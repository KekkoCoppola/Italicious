package controller;

import Dao.ProdottoDAO;
import Model.Prodotto;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;
//@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false); // Otteniamo la sessione esistente, se non c'è è null
    	if (session == null || "user".equals(session.getAttribute("role"))) {
    	    // Se non c'è sessione o username, reindirizza al login
    	    response.sendRedirect("login");
    	    return;
    	}
    	String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "view";  // Impostiamo 'view' come valore di default
        }


        if ("view".equals(action)) {
            // Mostra tutti i prodotti
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            List<Prodotto> prodotti = prodottoDAO.getAllProdotti();
            request.setAttribute("prodotti", prodotti);
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
            dispatcher.forward(request, response);
        } else if ("edit".equals(action)) {
            // Modifica un prodotto
            int id = Integer.parseInt(request.getParameter("id"));
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            Prodotto prodotto = prodottoDAO.getProdottoById(id);
            request.setAttribute("prodotto", prodotto);
            RequestDispatcher dispatcher = request.getRequestDispatcher("edit.jsp");
            dispatcher.forward(request, response);
        } else if ("add".equals(action)){
        	RequestDispatcher dispatcher = request.getRequestDispatcher("add.jsp");
            dispatcher.forward(request, response);
            // Altrimenti mostra la lista dei prodotti
            
        }else if("delete".equals(action)){
        	int id = Integer.parseInt(request.getParameter("id"));
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            System.out.println("ELIMINANO PRODOTTO:"+id);
            prodottoDAO.deleteProdotto(id);
            response.sendRedirect("admin?action=view");
        }else doGet(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Aggiungi un prodotto
        	int id =  0;
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            double iva = Double.parseDouble(request.getParameter("iva"));
            int disponibilita = Integer.parseInt(request.getParameter("disponibilita"));
            String immagine = request.getParameter("immagine");
            String regione = request.getParameter("regione");

            Prodotto prodotto = new Prodotto(id,nome, descrizione, prezzo,iva, disponibilita, immagine, regione);
            
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodottoDAO.addProdotto(prodotto);

            response.sendRedirect("admin?action=view");
        } else if ("update".equals(action)) {
            // Modifica un prodotto
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            double iva = Double.parseDouble(request.getParameter("iva"));
            int disponibilita = Integer.parseInt(request.getParameter("disponibilita"));
            String immagine = request.getParameter("immagine");
            String regione = request.getParameter("regione");

            Prodotto prodotto = new Prodotto(id,nome, descrizione, prezzo,iva, disponibilita, immagine, regione);
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            prodottoDAO.updateProdotto(prodotto);

            response.sendRedirect("admin?action=view");
        } else if ("delete".equals(action)) {
            // Elimina un prodotto
            int id = Integer.parseInt(request.getParameter("id"));
            ProdottoDAO prodottoDAO = new ProdottoDAO();
            System.out.println("ELIMINANO PRODOTTO:"+id);
            prodottoDAO.deleteProdotto(id);

            response.sendRedirect("admin?action=view");
        }
    }
}
