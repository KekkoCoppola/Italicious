package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import Dao.CarrelloDAO;
import Dao.OrdineDAO;
import Dao.ProdottoDAO;
import Model.Carrello;
import Model.ElementoCarrello;
import Model.Ordine;
import Model.OrdineProdotto;
import Model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CheckoutServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("username")==null) {
    	    response.sendRedirect("login");
    	    return;
    	}
		Carrello carrello = (Carrello) session.getAttribute("carrello");
		if (carrello == null) {
            response.sendRedirect("catalogo");
        }
		Ordine o = new Ordine((Integer) session.getAttribute("userId"));
		o.setCorriere("ItaliciousSDA");           		
		String tracking = "ITLCSTRACK" + System.currentTimeMillis();
		o.setCodiceTracking(tracking);
		for (ElementoCarrello item : carrello.getProdotti()) {
            int idProdotto = item.getIdProdotto();
            int quantita = item.getQuantita();
            Prodotto prodotto = ProdottoDAO.getProdottoById(idProdotto);
            double iva = prodotto.getIva();
            double prezzo = prodotto.getPrezzo();
            if(item.getQuantita()>prodotto.getDisponibilita()) {
            	request.setAttribute("errore", "la Quantita di "+prodotto.getNome()+" che stai cercando di ordinare non è disponibile (max "+prodotto.getDisponibilita()+")");
            	System.out.println("SIAMO NELL ERRORE QUANTITA");
            	request.getRequestDispatcher("/ordine_errore.jsp").forward(request, response);
            	return;
            };
            OrdineProdotto r = new OrdineProdotto(
            		prodotto.getId(),
            		BigDecimal.valueOf(prezzo), 
            		BigDecimal.valueOf(iva),
            		item.getQuantita()
                );
                o.addRiga(r);
                if(prodotto.getDisponibilita()-item.getQuantita()>=0)
                	prodotto.setDisponibilita(prodotto.getDisponibilita()-item.getQuantita());
                ProdottoDAO.updateProdotto(prodotto);
		}
		try {
			int id = new OrdineDAO().insertOrdineConRighe(o);
			request.setAttribute("idOrdine", "#"+o.getId());
			request.setAttribute("dataOrdine", o.getDataOrdine());
			request.setAttribute("totaleOrdine", o.getTotaleIvato());
			request.getRequestDispatcher("ordine_successo.jsp").forward(request, response);
			carrello.svuota();
            if ((Integer) session.getAttribute("userId") != null)
                CarrelloDAO.svuotaCarrello((Integer) session.getAttribute("userId"));
		} catch (SQLException e) {
			request.getRequestDispatcher("ordine_errore.jsp").forward(request, response);
			e.printStackTrace();
		}

	}
}
