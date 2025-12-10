package Model;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class OrdineProdotto {
    private int idOrdine;     
    private int idProdotto;   
    private BigDecimal prezzo; 
    private BigDecimal iva;  
    private int quantita;

    public OrdineProdotto() {}

    public OrdineProdotto(int idProdotto, BigDecimal prezzo, BigDecimal iva, int quantita) {
        this.idProdotto = idProdotto;
        this.prezzo = prezzo;
        this.iva = iva;
        this.quantita = quantita;
    }

    public BigDecimal getTotaleRigaIvato() {
        return prezzo.multiply(BigDecimal.valueOf(quantita));
    }

    public BigDecimal getImponibileRiga() {
        BigDecimal moltiplicatore = BigDecimal.ONE.add(iva.divide(BigDecimal.valueOf(100)));
        return getTotaleRigaIvato().divide(moltiplicatore, 2, RoundingMode.HALF_UP);
    }

    public BigDecimal getIvaRiga() {
        return getTotaleRigaIvato().subtract(getImponibileRiga());
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
