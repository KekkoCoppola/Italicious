package Model;

import java.math.BigDecimal;

public class OrdineProdotto {
    private int idOrdine;     // FK -> ordine.id
    private int idProdotto;   // FK -> prodotto.id
    private BigDecimal prezzo; // DECIMAL(10,2) - prezzo unitario imponibile
    private BigDecimal iva;    // DECIMAL(5,2)  - percentuale (es. 22.00)
    private int quantita;

    public OrdineProdotto() {}

    public OrdineProdotto(int idProdotto, BigDecimal prezzo, BigDecimal iva, int quantita) {
        this.idProdotto = idProdotto;
        this.prezzo = prezzo;
        this.iva = iva;
        this.quantita = quantita;
    }

    // --- helpers calcolo riga ---
    public BigDecimal getImponibileRiga() {
        return prezzo.multiply(BigDecimal.valueOf(quantita));
    }

    public BigDecimal getIvaRiga() {
        // prezzo * qta * (iva/100)
        return getImponibileRiga()
                .multiply(iva)
                .divide(BigDecimal.valueOf(100));
    }

    public BigDecimal getTotaleRigaIvato() {
        return getImponibileRiga().add(getIvaRiga());
    }

    // --- getters/setters ---
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public BigDecimal getPrezzo() { return prezzo; }
    public void setPrezzo(BigDecimal prezzo) { this.prezzo = prezzo; }
    public BigDecimal getIva() { return iva; }
    public void setIva(BigDecimal iva) { this.iva = iva; }
    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }
}
