package controller;

import Model.Carrello;
import Model.ElementoCarrello;
import Model.Utente;
import Dao.CarrelloDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

/**
 * Servlet per gestire il carrello dell’utente, sia in sessione che nel DB.
 */
@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Carrello in sessione
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        // Recupera utente loggato
        Utente utente = (Utente) session.getAttribute("utente");
        Integer idUtente = (utente != null) ? utente.getId() : null;

        // Parametri della richiesta
        String azione = request.getParameter("azione");
        int idProdotto = Integer.parseInt(request.getParameter("id_prodotto")); // nome esatto come nel DB
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

        // Aggiorna il carrello in sessione
        session.setAttribute("carrello", carrello);

        // Reindirizza a layout.jsp con contentPage impostato
        request.setAttribute("pageTitle", "Carrello - Italicious");
        request.setAttribute("contentPage", "/carrello.jsp");
        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }
}
