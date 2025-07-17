package Model;

import java.io.Serializable;

public class ElementoCarrello implements Serializable {

    private int idProdotto;
    private int quantita;

    public ElementoCarrello(int idProdotto, int quantita) {
        this.idProdotto = idProdotto;
        this.quantita = quantita;
    }

    public int getIdProdotto() {
        return idProdotto;
    }

    public void setIdProdotto(int idProdotto) {
        this.idProdotto = idProdotto;
    }

    public int getQuantita() {
        return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
}
