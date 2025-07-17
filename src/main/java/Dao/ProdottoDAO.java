package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Model.Prodotto;

public class ProdottoDAO {

    public List<Prodotto> getAllProdotti() {
        List<Prodotto> prodotti = new ArrayList<>();
      
        String query = "SELECT * FROM Prodotto";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setIva(rs.getDouble("iva"));
                p.setDisponibilita(rs.getInt("disponibilita"));
                p.setImmagine(rs.getString("immagine"));
                p.setRegione(rs.getString("regione"));
                System.out.println("PRODOTTO: "+p);
                prodotti.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return prodotti;
    }
    
    public static List<Prodotto> getProdottiByRegione(String regione) {
        List<Prodotto> prodotti = new ArrayList<>();

        String query = "SELECT * FROM Prodotto WHERE regione = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, regione); // Imposta il valore della regione nel placeholder

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id"));
                    p.setNome(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setIva(rs.getDouble("iva"));
                    p.setDisponibilita(rs.getInt("disponibilita"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setRegione(rs.getString("regione"));
                    prodotti.add(p);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return prodotti;
    }

    
    public void addProdotto(Prodotto prodotto) {
        String query = "INSERT INTO Prodotto (nome, descrizione, prezzo, immagine, regione) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, prodotto.getNome());
            stmt.setString(2, prodotto.getDescrizione());
            stmt.setDouble(3, prodotto.getPrezzo());
            stmt.setString(4, prodotto.getImmagine());
            stmt.setString(5, prodotto.getRegione());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
      
    }
    
    public static Prodotto getProdottoById(int id) {
        Prodotto prodotto = null;
        String query = "SELECT * FROM Prodotto WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                prodotto = new Prodotto(
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getString("descrizione"),
                    rs.getDouble("prezzo"),
                    rs.getDouble("iva"),
                    rs.getInt("disponibilita"),
                    rs.getString("immagine"),
                    rs.getString("regione")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prodotto;
    }
    
    public void updateProdotto(Prodotto prodotto) {
        String query = "UPDATE Prodotto SET nome = ?, descrizione = ?, prezzo = ?, iva = ?, disponibilita = ?, immagine = ?, regione = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, prodotto.getNome());
            stmt.setString(2, prodotto.getDescrizione());
            stmt.setDouble(3, prodotto.getPrezzo());
            stmt.setDouble(4, prodotto.getIva());  
            stmt.setDouble(5, prodotto.getDisponibilita());  
            stmt.setString(6, prodotto.getImmagine());
            stmt.setString(7, prodotto.getRegione());
            stmt.setInt(8, prodotto.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteProdotto(int id) {
        String query = "DELETE FROM Prodotto WHERE id = ?";
       
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

