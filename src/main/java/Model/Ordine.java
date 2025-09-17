package Model;

import java.time.LocalDate;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Ordine {
    private int id;
    private LocalDate dataOrdine;
    private String corriere;
    private String codiceTracking;
    private StatoOrdine stato;
    private int idUtente;

    private List<OrdineProdotto> righe = new ArrayList<>();

    public enum StatoOrdine {
        IN_ELABORAZIONE("in elaborazione"),
        SPEDITO("spedito"),
        CONSEGNATO("consegnato"),
    	ANNULLATO("annullato");

        private final String value;
        StatoOrdine(String v){ this.value = v; }
        public String getValue(){ return value; }
        public static StatoOrdine fromValue(String v){
            for (StatoOrdine s: values()) if (s.value.equalsIgnoreCase(v)) return s;
            throw new IllegalArgumentException("Stato non valido: " + v);
        }
    }

    public Ordine() {}
    public Ordine(int idUtente){
        this.idUtente = idUtente;
        this.dataOrdine = LocalDate.now();
        this.stato = StatoOrdine.IN_ELABORAZIONE;
    }

    // --- helpers righe ---
    public void addRiga(OrdineProdotto r){ righe.add(r); }
    public List<OrdineProdotto> getRighe(){ return righe; }

    public BigDecimal getTotaleIvato() {
        // Prezzi già ivati → somma dei totali riga
        return righe.stream()
            .map(OrdineProdotto::getTotaleRigaIvato)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public BigDecimal getTotaleImponibile() {
        // Somma degli imponibili scorporati da ciascuna riga
        return righe.stream()
            .map(OrdineProdotto::getImponibileRiga)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public BigDecimal getTotaleIva() {
        // Differenza tra totale ivato e imponibile
        return getTotaleIvato().subtract(getTotaleImponibile());
    }

    // --- getters/setters base ---
    public int getId(){ return id; }
    public void setId(int id){ this.id = id; }
    public LocalDate getDataOrdine(){ return dataOrdine; }
    public void setDataOrdine(LocalDate d){ this.dataOrdine = d; }
    public String getCorriere(){ return corriere; }
    public void setCorriere(String c){ this.corriere = c; }
    public String getCodiceTracking(){ return codiceTracking; }
    public void setCodiceTracking(String c){ this.codiceTracking = c; }
    public StatoOrdine getStato(){ return stato; }
    public void setStato(StatoOrdine s){ this.stato = s; }
    public int getIdUtente(){ return idUtente; }
    public void setIdUtente(int idUtente){ this.idUtente = idUtente; }
}
