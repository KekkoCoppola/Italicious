package Model;

import java.io.Serializable;

/**
 * Bean per rappresentare un utente registrato.
 * Mappa i campi della tabella 'Utente' nel database.
 */
public class Utente implements Serializable {

    private int id;                 // corrisponde a: id INT PRIMARY KEY
    private String nome;           // corrisponde a: nome VARCHAR(30)
    private String mail;           // corrisponde a: mail VARCHAR(50)
    private String password;       // corrisponde a: password VARCHAR(255)
    private String indirizzo;      // corrisponde a: indirizzo VARCHAR(120)
    private String telefono;       // corrisponde a: telefono VARCHAR(20)

    // Costruttore vuoto
    public Utente() {}
    
    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
}
