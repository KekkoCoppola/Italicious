package Dao;

import Model.ElementoCarrello;
import Dao.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO per gestire il carrello persistente nel database.
 * tabella 'Carrello' con colonne: id_utente, id_prodotto, quantita.
 */
public class CarrelloDAO {

    /**
     * Aggiunge un prodotto al carrello o ne aggiorna la quantità se già presente.
     */
    public static void aggiungiOaggiornaElemento(int idUtente, int idProdotto, int quantita) {
        String sql = """
            INSERT INTO Carrello (id_utente, id_prodotto, quantita)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE quantita = ?
        """;
        	System.out.println("STAMPA ID UTENTE:"+idUtente+" ID PRODOTTO: "+idProdotto+" QUANTITA"+quantita);
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.setInt(3, quantita);
            ps.setInt(4, quantita);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * Aggiorna il carrello e fa il merge tra carrello guest e utente.
     */
    public static void aggiornaMerge(int idUtente, int idProdotto, int quantita) {
        String sql = """
            INSERT INTO Carrello (id_utente, id_prodotto, quantita)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE quantita = quantita + ?
        """;
        	System.out.println("STAMPA ID UTENTE:"+idUtente+" ID PRODOTTO: "+idProdotto+" QUANTITA"+quantita);
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.setInt(3, quantita);
            ps.setInt(4, quantita);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Rimuove un prodotto specifico dal carrello dell’utente.
     */
    public static void rimuoviElemento(int idUtente, int idProdotto) {
        String sql = "DELETE FROM Carrello WHERE id_utente = ? AND id_prodotto = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Svuota completamente il carrello di un utente.
     */
    public static void svuotaCarrello(int idUtente) {
        String sql = "DELETE FROM Carrello WHERE id_utente = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Recupera gli elementi del carrello per uno specifico utente.
     */
    public static List<ElementoCarrello> doRetrieveByUtente(int idUtente) {
        List<ElementoCarrello> lista = new ArrayList<>();
        String sql = "SELECT id_prodotto, quantita FROM Carrello WHERE id_utente = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int idProdotto = rs.getInt("id_prodotto");
                    int quantita = rs.getInt("quantita");
                    lista.add(new ElementoCarrello(idProdotto, quantita));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    /**
     * Sovrascrive l’intero contenuto del carrello per un utente.
     * Svuota prima tutto e reinserisce ogni riga.
     */
    public static void salvaCarrello(List<ElementoCarrello> carrello, int idUtente) {
        svuotaCarrello(idUtente);
        for (ElementoCarrello e : carrello) {
            aggiungiOaggiornaElemento(idUtente, e.getIdProdotto(), e.getQuantita());
        }
    }
    /**
     * trova il carrello di un utente.
     */
    public static List<ElementoCarrello> findByUserId(int userId) {
        String sql = "SELECT id_prodotto, quantita FROM carrello WHERE id_utente = ?";
        List<ElementoCarrello> out = new ArrayList<>();
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    out.add(new ElementoCarrello(rs.getInt("id_prodotto"), rs.getInt("quantita")));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return out;
    }

}
