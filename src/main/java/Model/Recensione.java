package Model;

public class Recensione {
	private int id;
	private int punteggio;
	private String descrizione;
	private int idUtente;
	private int idProdotto;
	
	public Recensione() {}
	public Recensione(int punteggio, String descrizione, int idUtente, int idProdotto) {
		this.punteggio=punteggio;
		this.descrizione=descrizione;
		this.idUtente=idUtente;
		this.idProdotto=idProdotto;
	}
	
	public int getId() {return this.id;}
	public int getPunteggio() {return this.punteggio;}
	public String getDescrizione() {return this.descrizione;}
	public int getIdUtente() {return this.idUtente;}
	public int getIdProdotto() {return this.idProdotto;}
	
	public void setId(int id) {this.id=id;}
	public void setPunteggio(int punteggio) {this.punteggio=punteggio;}
	public void setDescrizione(String descrizione) {this.descrizione=descrizione;}
	public void setIdUtente(int idUtente) {this.idUtente=idUtente;}
	public void setIdProdotto(int idProdotto) {this.idProdotto=idProdotto;}

}
