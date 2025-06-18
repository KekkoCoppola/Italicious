package Model;

public class Prodotto {
    private int id;
    private String nome;
    private String descrizione;
    private double prezzo;
    private double iva;
    private int disponibilita;
    private String immagine;
    private String regione;

    // Costruttori
    public Prodotto() {}

    public Prodotto(int id, String nome, String descrizione, double prezzo, double iva,
                    int disponibilita, String immagine, String regione) {
        this.id = id;
        this.nome = nome;
        this.descrizione = descrizione;
        this.prezzo = prezzo;
        this.iva = iva;
        this.disponibilita = disponibilita;
        this.immagine = immagine;
        this.regione = regione;
    }
    // Getter & Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public double getIva() { return iva; }
    public void setIva(double iva) { this.iva = iva; }

    public int getDisponibilita() { return disponibilita; }
    public void setDisponibilita(int disponibilita) { this.disponibilita = disponibilita; }

    public String getImmagine() { return immagine; }
    public void setImmagine(String immagine) { this.immagine = immagine; }

    public String getRegione() { return regione; }
    public void setRegione(String regione) { this.regione = regione; }
}
