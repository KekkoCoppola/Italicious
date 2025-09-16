package Model;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public class Prodotto {
    private int id;
    private String nome;
    private String descrizione;
    private double prezzo;
    private double iva;
    private int disponibilita;
    private String immagine;
    private String regione;
    private String categoria;
    private static DecimalFormat CURRENCY_IT = new DecimalFormat();
    static {
        DecimalFormatSymbols sym = new DecimalFormatSymbols(Locale.ITALY);
        sym.setDecimalSeparator(',');
        sym.setGroupingSeparator('.');
        CURRENCY_IT = new DecimalFormat("#,##0.00", sym);
    }
    // Costruttori
    public Prodotto() {}

    public Prodotto(int id, String nome, String descrizione,String categoria, double prezzo, double iva,
                    int disponibilita, String immagine, String regione) {
        this.id = id;
        this.nome = nome;
        this.descrizione = descrizione;
        this.prezzo = prezzo;
        this.iva = iva;
        this.disponibilita = disponibilita;
        this.immagine = immagine;
        this.regione = regione;
        this.categoria = categoria;
    }
    
    
    public double getPrezzoPiuIva() {
        double totale = prezzo + (prezzo * iva / 100.0);
        return Math.round(totale * 100.0) / 100.0;
    }
    
    public String getPrezzoFormattato(){
    	return CURRENCY_IT.format(prezzo);
    }


    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public double getPrezzo() { return Math.round(prezzo * 100.0) / 100.0; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public double getIva() { return iva; }
    public void setIva(double iva) { this.iva = iva; }

    public int getDisponibilita() { return disponibilita; }
    public void setDisponibilita(int disponibilita) { this.disponibilita = disponibilita; }

    public String getImmagine() { return immagine; }
    public void setImmagine(String immagine) { this.immagine = immagine; }
    
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria;} 

    public String getRegione() { return regione; }
    public void setRegione(String regione) { this.regione = regione; }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Prodotto)) return false;
        Prodotto p = (Prodotto) o;
        return id == p.id; // confronta per id
    }

}
