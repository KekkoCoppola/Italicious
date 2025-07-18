package controller;

import Model.Carrello;
import Model.ElementoCarrello;
import Model.Utente;
import Dao.CarrelloDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class CarrelloServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        request.setAttribute("pageTitle", "Carrello - Italicious");
        request.setAttribute("contentPage", "carrello.jsp");

        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        Utente utente = (Utente) session.getAttribute("utente");
        Integer idUtente = (utente != null) ? utente.getId() : null;

        String azione = request.getParameter("azione");
        int idProdotto = Integer.parseInt(request.getParameter("id_prodotto"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));

        switch (azione) {
            case "aggiungi":
                carrello.aggiungiProdotto(idProdotto, quantita);
                if (idUtente != null) {
                    CarrelloDAO.aggiungiOaggiornaElemento(idUtente, idProdotto, quantita);
                }
                break;

            case "rimuovi":
                carrello.rimuoviProdotto(idProdotto);
                if (idUtente != null) {
                    CarrelloDAO.rimuoviElemento(idUtente, idProdotto);
                }
                break;

            case "aggiorna":
                carrello.aggiornaQuantita(idProdotto, quantita);
                if (idUtente != null) {
                    if (quantita <= 0) {
                        CarrelloDAO.rimuoviElemento(idUtente, idProdotto);
                    } else {
                        CarrelloDAO.aggiungiOaggiornaElemento(idUtente, idProdotto, quantita);
                    }
                }
                break;

            case "svuota":
                carrello.svuota();
                if (idUtente != null) {
                    CarrelloDAO.svuotaCarrello(idUtente);
                }
                break;
        }

        session.setAttribute("carrello", carrello);

        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            request.getRequestDispatcher("carrello.jsp").forward(request, response); // restituisce HTML completo
        } else {
            response.sendRedirect("carrello");
        }
    }
}
