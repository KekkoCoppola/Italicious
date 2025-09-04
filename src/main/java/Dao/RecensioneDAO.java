package Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.Recensione;

public class RecensioneDAO {
	public static int addRecensione(Recensione r) throws SQLException {
        if (r == null) throw new IllegalArgumentException("Recensione nulla");
        if (r.getPunteggio() < 1 || r.getPunteggio() > 5)
            throw new IllegalArgumentException("Punteggio fuori range (1..5)");

        String sql =
            "INSERT INTO feedback (punteggio, descrizione, id_utente, id_prodotto) " +
            "VALUES (?, ?, ?, ?) " +
            "ON DUPLICATE KEY UPDATE " +
            "  punteggio = VALUES(punteggio), " +
            "  descrizione = VALUES(descrizione), " + 
            "  data_feedback = CURRENT_TIMESTAMP, " +
            // trucco per ottenere SEMPRE l'id con getGeneratedKeys()
            "  id_feedback = LAST_INSERT_ID(id_feedback)";

        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getPunteggio());
            if (r.getDescrizione() == null || r.getDescrizione().isBlank()) {
                ps.setNull(2, java.sql.Types.LONGVARCHAR);
            } else {
                ps.setString(2, r.getDescrizione());
            }
            ps.setInt(3, r.getIdUtente());
            ps.setInt(4, r.getIdProdotto());
           

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // id_feedback (nuovo o esistente)
                }
            }
        }
        throw new SQLException("Impossibile ottenere id_feedback");
    }
	public boolean updateRecensioneById(int idFeedback, int punteggio, String descrizione) {
        String sql = "UPDATE feedback " +
                     "SET punteggio = ?, descrizione = ?, data_feedback = CURRENT_TIMESTAMP " +
                     "WHERE id_feedback = ?";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, punteggio); // 1..5
            if (descrizione == null || descrizione.isBlank()) {
                stmt.setNull(2, java.sql.Types.LONGVARCHAR);
            } else {
                stmt.setString(2, descrizione);
            }
            stmt.setInt(3, idFeedback);

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteRecensioneById(int idFeedback) {
        String sql = "DELETE FROM feedback WHERE id_feedback = ?";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, idFeedback);
            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static List<Recensione> getRecensioniByProdotto(int idProdotto) {
        List<Recensione> lista = new ArrayList<>();

        String sql = "SELECT id_feedback, punteggio, descrizione, id_utente, id_prodotto " +
                     "FROM feedback WHERE id_prodotto = ? " +
                     "ORDER BY data_feedback DESC";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, idProdotto);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Recensione r = new Recensione();
                    r.setId(rs.getInt("id_feedback"));
                    r.setPunteggio(rs.getInt("punteggio"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setIdUtente(rs.getInt("id_utente"));
                    r.setIdProdotto(rs.getInt("id_prodotto"));
                    lista.add(r);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public static List<Recensione> getRecensioniByUtente(int idUtente) {
        List<Recensione> lista = new ArrayList<>();

        String sql = "SELECT id_feedback, punteggio, descrizione, id_utente, id_prodotto " +
                     "FROM feedback WHERE id_utente = ? " +
                     "ORDER BY data_feedback DESC";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, idUtente);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Recensione r = new Recensione();
                    r.setId(rs.getInt("id_feedback"));
                    r.setPunteggio(rs.getInt("punteggio"));
                    r.setDescrizione(rs.getString("descrizione"));
                    r.setIdUtente(rs.getInt("id_utente"));
                    r.setIdProdotto(rs.getInt("id_prodotto"));
                    lista.add(r);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    public static int countRecensioniByProdotto(int idProdotto) {
    	int count=0;
        String sql = "SELECT COUNT(*) AS c FROM feedback WHERE id_prodotto = ?";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, idProdotto);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    count = rs.getInt("c");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public static double getMediaByProdotto(int idProdotto) {
        double media = 0.0;
        String sql = "SELECT ROUND(AVG(punteggio), 1) AS media " +
                     "FROM feedback WHERE id_prodotto = ?";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, idProdotto);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    media = rs.getDouble("media");
                    if (rs.wasNull()) media = 0.0; // nessuna recensione
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return media;
    }
    
    public static String getAutore(int idUtente) {
    	String username = null;
        String sql = "SELECT nome FROM utente WHERE id = ?";

        try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(sql)) {

            stmt.setInt(1, idUtente);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    username = rs.getString("nome");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return username; // null se non trovato
    }
    
    public static boolean haGiaRecensito(int idUtente, int idProdotto) {
        String sql = "SELECT 1 FROM feedback WHERE id_utente = ? AND id_prodotto = ? LIMIT 1";

        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true se trova almeno una recensione
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


	
}
