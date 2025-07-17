package Model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Questa classe rappresenta il carrello dell'utente.
 * Viene salvata nella sessione e contiene una lista di prodotti con relative quantità.
 * Può essere caricata/salvata dal/in database tramite CarrelloDAO.
 */
public class Carrello implements Serializable {

    // Lista di prodotti nel carrello (ogni ElementoCarrello ha id prodotto + quantità)
    private List<ElementoCarrello> prodotti;

    // Costruttore: inizializza la lista vuota
    public Carrello() {
        prodotti = new ArrayList<>();
    }

    /**
     * Aggiunge un prodotto al carrello.
     * Se già presente, incrementa la quantità.
     *
     * @param idProdotto ID del prodotto da aggiungere
     * @param quantita   Quantità da aggiungere
     */
    public void aggiungiProdotto(int idProdotto, int quantita) {
        for (ElementoCarrello e : prodotti) {
            if (e.getIdProdotto() == idProdotto) {
                // Prodotto già presente → sommo la quantità
                e.setQuantita(e.getQuantita() + quantita);
                return;
            }
        }
        // Prodotto non presente → lo aggiungo come nuovo
        prodotti.add(new ElementoCarrello(idProdotto, quantita));
    }

    /**
     * Rimuove completamente un prodotto dal carrello.
     *
     * @param idProdotto ID del prodotto da rimuovere
     */
    public void rimuoviProdotto(int idProdotto) {
        // Rimuove l'elemento con quell'id (se esiste)
        prodotti.removeIf(e -> e.getIdProdotto() == idProdotto);
    }

    /**
     * Aggiorna la quantità di un prodotto nel carrello.
     * Se la quantità è zero o negativa, il prodotto viene rimosso.
     *
     * @param idProdotto     ID del prodotto da aggiornare
     * @param nuovaQuantita  Nuova quantità da impostare
     */
    public void aggiornaQuantita(int idProdotto, int nuovaQuantita) {
        for (ElementoCarrello e : prodotti) {
            if (e.getIdProdotto() == idProdotto) {
                if (nuovaQuantita <= 0) {
                    // Se la quantità è zero o negativa → rimuovi il prodotto
                    rimuoviProdotto(idProdotto);
                } else {
                    // Altrimenti aggiorna la quantità
                    e.setQuantita(nuovaQuantita);
                }
                return;
            }
        }
    }

    /**
     * Svuota completamente il carrello.
     */
    public void svuota() {
        prodotti.clear();
    }

    /**
     * Restituisce la lista di prodotti nel carrello.
     *
     * @return Lista di oggetti ElementoCarrello
     */
    public List<ElementoCarrello> getProdotti() {
        return prodotti;
    }

    /**
     * Sostituisce l’intero contenuto del carrello.
     * Usato ad esempio quando si carica il carrello dal database dopo il login.
     *
     * @param listaProdotti Lista di prodotti da impostare
     */
    public void setProdotti(List<ElementoCarrello> listaProdotti) {
        this.prodotti = listaProdotti;
    }
}
