package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Dao.DBConnection; // adegua al tuo package

/**
 * DAO per tabella: lista_preferiti(id_utente, id_prodotto)
 * PK composta: (id_utente, id_prodotto)
 */
public class ListaPreferitiDAO {

    private static final String INSERT_SQL =
            "INSERT INTO lista_preferiti (id_utente, id_prodotto) VALUES (?, ?)";

    private static final String DELETE_SQL =
            "DELETE FROM lista_preferiti WHERE id_utente = ? AND id_prodotto = ?";

    private static final String EXISTS_SQL =
            "SELECT 1 FROM lista_preferiti WHERE id_utente = ? AND id_prodotto = ?";

    private static final String LIST_BY_USER_SQL =
            "SELECT id_prodotto FROM lista_preferiti WHERE id_utente = ?";

    private static final String LIST_USERS_BY_PRODUCT_SQL =
            "SELECT id_utente FROM lista_preferiti WHERE id_prodotto = ?";

    private static final String COUNT_BY_USER_SQL =
            "SELECT COUNT(*) FROM lista_preferiti WHERE id_utente = ?";

    private static final String DELETE_ALL_BY_USER_SQL =
            "DELETE FROM lista_preferiti WHERE id_utente = ?";

    private static final String DELETE_ALL_BY_PRODUCT_SQL =
            "DELETE FROM lista_preferiti WHERE id_prodotto = ?";

    /** Inserisce una riga. Ritorna true se inserito, false se già presente (violazione PK). */
    public boolean add(int idUtente, int idProdotto) {
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(INSERT_SQL)) {
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            return ps.executeUpdate() == 1;
        } catch (SQLIntegrityConstraintViolationException dup) {
            // già esiste la coppia (id_utente, id_prodotto)
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Elimina la coppia. True se è stata eliminata una riga. */
    public boolean remove(int idUtente, int idProdotto) {
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(DELETE_SQL)) {
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            return ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Toggle: se esiste la rimuove, altrimenti la inserisce. Ritorna true se ADDED, false se REMOVED. */
    public boolean toggle(int idUtente, int idProdotto) {
        if (exists(idUtente, idProdotto)) {
            remove(idUtente, idProdotto);
            return false;
        } else {
            add(idUtente, idProdotto);
            return true;
        }
    }

    /** Verifica esistenza della coppia (id_utente, id_prodotto). */
    public boolean exists(int idUtente, int idProdotto) {
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(EXISTS_SQL)) {
            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /** Restituisce la lista degli id_prodotto preferiti dall'utente. */
    public List<Integer> findProductIdsByUser(int idUtente) {
        List<Integer> result = new ArrayList<>();
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(LIST_BY_USER_SQL)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) result.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /** Restituisce la lista degli id_utente che hanno tra i preferiti un certo prodotto. */
    public List<Integer> findUserIdsByProduct(int idProdotto) {
        List<Integer> result = new ArrayList<>();
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(LIST_USERS_BY_PRODUCT_SQL)) {
            ps.setInt(1, idProdotto);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) result.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /** Conta i preferiti dell'utente (utile per badge/paginazione lato app). */
    public int countByUser(int idUtente) {
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(COUNT_BY_USER_SQL)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /** Cancella tutti i preferiti dell'utente. */
    public int deleteAllByUser(int idUtente) {
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(DELETE_ALL_BY_USER_SQL)) {
            ps.setInt(1, idUtente);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /** Cancella tutte le occorrenze di un prodotto. */
    public int deleteAllByProduct(int idProdotto) {
        try (PreparedStatement ps = DBConnection.getConnection().prepareStatement(DELETE_ALL_BY_PRODUCT_SQL)) {
            ps.setInt(1, idProdotto);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
}
