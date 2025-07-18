package controller;

import Model.Carrello;
import Model.Utente;
import Dao.CarrelloDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;


public class CarrelloServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        request.setAttribute("pageTitle", "Carrello - Italicious");
        request.setAttribute("contentPage", "carrello.jsp");
        request.getRequestDispatcher("/layout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            gestisciAjax(request, response);
            return;
        }

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
                if (idUtente != null)
                    CarrelloDAO.aggiungiOaggiornaElemento(idUtente, idProdotto, quantita);
                break;
            case "rimuovi":
                carrello.rimuoviProdotto(idProdotto);
                if (idUtente != null)
                    CarrelloDAO.rimuoviElemento(idUtente, idProdotto);
                break;
            case "aggiorna":
                carrello.aggiornaQuantita(idProdotto, quantita);
                if (idUtente != null) {
                    if (quantita <= 0)
                        CarrelloDAO.rimuoviElemento(idUtente, idProdotto);
                    else
                        CarrelloDAO.aggiungiOaggiornaElemento(idUtente, idProdotto, quantita);
                }
                break;
            case "svuota":
                carrello.svuota();
                if (idUtente != null)
                    CarrelloDAO.svuotaCarrello(idUtente);
                break;
        }

        session.setAttribute("carrello", carrello);
        response.sendRedirect("carrello");
    }

    private void gestisciAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        Utente utente = (Utente) session.getAttribute("utente");
        Integer idUtente = (utente != null) ? utente.getId() : null;

        JsonObject json = new Gson().fromJson(request.getReader(), JsonObject.class);

        String azione = json.get("azione").getAsString();
        // Supporta entrambi i nomi di campo
        int idProdotto = json.has("id_prodotto") ?
                         json.get("id_prodotto").getAsInt() :
                         json.get("idProdotto").getAsInt();

        int quantita = json.get("quantita").getAsInt();

        JsonObject risposta = new JsonObject();
        risposta.addProperty("success", true);

        switch (azione) {
            case "aggiungi":
                carrello.aggiungiProdotto(idProdotto, quantita);
                if (idUtente != null)
                    CarrelloDAO.aggiungiOaggiornaElemento(idUtente, idProdotto, quantita);
                risposta.addProperty("messaggio", "Prodotto  aggiunto al carrello ✅");
                break;

            case "aggiorna":
                carrello.aggiornaQuantita(idProdotto, quantita);
                if (idUtente != null) {
                    if (quantita <= 0)
                        CarrelloDAO.rimuoviElemento(idUtente, idProdotto);
                    else
                        CarrelloDAO.aggiungiOaggiornaElemento(idUtente, idProdotto, quantita);
                }
                risposta.addProperty("nuovaQuantita", quantita);
                risposta.addProperty("messaggio", "Quantità aggiornata ✅");
                break;

            default:
                risposta.addProperty("success", false);
                risposta.addProperty("messaggio", "Azione non supportata");
                break;
        }

        session.setAttribute("carrello", carrello);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(risposta.toString());
    }
}
