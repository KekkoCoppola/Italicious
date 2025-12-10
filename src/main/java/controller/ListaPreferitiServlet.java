package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import Model.Prodotto;
import Dao.ListaPreferitiDAO;
import Dao.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ListaPreferitiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	if (session == null || session.getAttribute("username")==null) {
    	    response.sendRedirect("login");
    	    return;
    	}
        Integer idUtente = (Integer) request.getSession().getAttribute("userId");
        List<Prodotto> preferiti = new ArrayList<>();
        ListaPreferitiDAO lf = new ListaPreferitiDAO();
        List<Integer> ids = lf.findProductIdsByUser(idUtente);
        for(Integer id : ids) {
        	Prodotto p = ProdottoDAO.getProdottoById(id);
        	preferiti.add(p);
        }
        request.setAttribute("paginaCorrente", "lista_preferiti");
        request.setAttribute("preferiti", preferiti);
        request.setAttribute("pageTitle", "Lista Preferiti - Italicious");
    	request.setAttribute("contentPage", "preferiti.jsp"); 
	    request.getRequestDispatcher("layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	HttpSession session = request.getSession(false); 
    	if (session == null || session.getAttribute("username")==null) {
    	    response.sendRedirect("login");
    	    return;
    	}
        int idProdotto = Integer.parseInt(request.getParameter("id_prodotto"));
        Integer idUtente = (Integer) request.getSession().getAttribute("userId");
        ListaPreferitiDAO lf = new ListaPreferitiDAO();
        lf.toggle(idUtente, idProdotto);

        response.sendRedirect("schedaprodotto?id="+idProdotto);
    }
}

