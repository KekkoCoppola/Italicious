package Model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Carrello implements Serializable {

    private List<ElementoCarrello> prodotti;

    public Carrello() {
        prodotti = new ArrayList<>();
    }

    /* AGGIUNGE UN PRODOTTO AL CARRELLO*/
    public void aggiungiProdotto(int idProdotto, int quantita) {
        for (ElementoCarrello e : prodotti) {
            if (e.getIdProdotto() == idProdotto) {
                // Prodotto già presente → sommo la quantità
                e.setQuantita(e.getQuantita() + quantita);
                return;
            }
        }

        prodotti.add(new ElementoCarrello(idProdotto, quantita));
    }

    /* RIMUOVE UN PRODOTTO DAL CARRELLO */
    public void rimuoviProdotto(int idProdotto) {
        // Rimuove l'elemento con quell'id (se esiste)
        prodotti.removeIf(e -> e.getIdProdotto() == idProdotto);
    }

    /**
     * Aggiorna la quantità di un prodotto nel carrello.
     * Se la quantità è zero o negativa, il prodotto viene rimosso.
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
     */
    public List<ElementoCarrello> getProdotti() {
        return prodotti;
    }
    
   
    /**
     * Sostituisce l’intero contenuto del carrello.
     * Usato ad esempio quando si carica il carrello dal database dopo il login.
     */
    public void setProdotti(List<ElementoCarrello> listaProdotti) {
        this.prodotti = listaProdotti;
    }
}
