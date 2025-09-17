package Dao;

import Model.Ordine;
import Model.Ordine.StatoOrdine;
import Model.OrdineProdotto;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO {
	
    /* ==========================
       CREATE
       ========================== */
    public int insertOrdineConRighe(Ordine ordine) throws SQLException {
        final String sqlOrdine = """
            INSERT INTO ordine (data_ordine, corriere, codice_tracking, stato, id_utente)
            VALUES (?, ?, ?, ?, ?)
        """;
        final String sqlRiga = """
            INSERT INTO ordine_prodotto (prezzo, iva, quantita, id_ordine, id_prodotto)
            VALUES (?, ?, ?, ?, ?)
        """;
        Connection conn = DBConnection.getConnection();
        boolean oldAuto = conn.getAutoCommit();
        conn.setAutoCommit(false);

        try (PreparedStatement psOrd = conn.prepareStatement(sqlOrdine, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement psRig = conn.prepareStatement(sqlRiga)) {

            // ordine
            psOrd.setDate(1, Date.valueOf(ordine.getDataOrdine() != null ? ordine.getDataOrdine() : LocalDate.now()));
            psOrd.setString(2, ordine.getCorriere());
            psOrd.setString(3, ordine.getCodiceTracking());
            psOrd.setString(4, (ordine.getStato() != null ? ordine.getStato() : StatoOrdine.IN_ELABORAZIONE).getValue());
            psOrd.setInt(5, ordine.getIdUtente());
            psOrd.executeUpdate();

            // chiave
            int idOrdine;
            try (ResultSet rs = psOrd.getGeneratedKeys()) {
                if (!rs.next()) throw new SQLException("Impossibile recuperare ID ordine.");
                idOrdine = rs.getInt(1);
            }
            ordine.setId(idOrdine);

            // righe
            for (OrdineProdotto r : ordine.getRighe()) {
                r.setIdOrdine(idOrdine);
                psRig.setBigDecimal(1, r.getPrezzo());
                psRig.setBigDecimal(2, r.getIva());
                psRig.setInt(3, r.getQuantita());
                psRig.setInt(4, idOrdine);
                psRig.setInt(5, r.getIdProdotto());
                psRig.addBatch();
            }
            psRig.executeBatch();

            conn.commit();
            return idOrdine;

        } catch (SQLException ex) {
            conn.rollback();
            throw ex;
        } finally {
            conn.setAutoCommit(oldAuto);
        }
    }

    /* ==========================
       READ
       ========================== */
    public static Ordine findByIdWithRighe(int idOrdine) throws SQLException {
    	Connection conn = DBConnection.getConnection();
        final String qOrd = """
            SELECT id, data_ordine, corriere, codice_tracking, stato, id_utente
            FROM ordine WHERE id=?
        """;
        final String qRig = """
            SELECT prezzo, iva, quantita, id_ordine, id_prodotto
            FROM ordine_prodotto WHERE id_ordine=?
        """;

        Ordine o = null;
        try (PreparedStatement ps = conn.prepareStatement(qOrd)) {
            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    o = new Ordine();
                    o.setId(rs.getInt("id"));
                    o.setDataOrdine(rs.getDate("data_ordine").toLocalDate());
                    o.setCorriere(rs.getString("corriere"));
                    o.setCodiceTracking(rs.getString("codice_tracking"));
                    o.setStato(StatoOrdine.fromValue(rs.getString("stato")));
                    o.setIdUtente(rs.getInt("id_utente"));
                } else {
                    return null;
                }
            }
        }

        try (PreparedStatement ps = conn.prepareStatement(qRig)) {
            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineProdotto r = new OrdineProdotto();
                    r.setPrezzo(rs.getBigDecimal("prezzo"));
                    r.setIva(rs.getBigDecimal("iva"));
                    r.setQuantita(rs.getInt("quantita"));
                    r.setIdOrdine(rs.getInt("id_ordine"));
                    r.setIdProdotto(rs.getInt("id_prodotto"));
                    o.addRiga(r);
                }
            }
        }
        return o;
    }
    public static List<Ordine> findAllWithRighe() throws SQLException {
        Connection conn = DBConnection.getConnection();
        final String qOrd = """
            SELECT id, data_ordine, corriere, codice_tracking, stato, id_utente
            FROM ordine
        """;
        final String qRig = """
            SELECT prezzo, iva, quantita, id_ordine, id_prodotto
            FROM ordine_prodotto
            WHERE id_ordine = ?
        """;

        List<Ordine> ordini = new ArrayList<>();

        try (PreparedStatement psOrd = conn.prepareStatement(qOrd);
             ResultSet rsOrd = psOrd.executeQuery()) {

            while (rsOrd.next()) {
                Ordine o = new Ordine();
                o.setId(rsOrd.getInt("id"));
                o.setDataOrdine(rsOrd.getDate("data_ordine").toLocalDate());
                o.setCorriere(rsOrd.getString("corriere"));
                o.setCodiceTracking(rsOrd.getString("codice_tracking"));
                o.setStato(StatoOrdine.fromValue(rsOrd.getString("stato")));
                o.setIdUtente(rsOrd.getInt("id_utente"));

                // carico le righe dell'ordine
                try (PreparedStatement psRig = conn.prepareStatement(qRig)) {
                    psRig.setInt(1, o.getId());
                    try (ResultSet rsRig = psRig.executeQuery()) {
                        while (rsRig.next()) {
                            OrdineProdotto r = new OrdineProdotto();
                            r.setPrezzo(rsRig.getBigDecimal("prezzo"));
                            r.setIva(rsRig.getBigDecimal("iva"));
                            r.setQuantita(rsRig.getInt("quantita"));
                            r.setIdOrdine(rsRig.getInt("id_ordine"));
                            r.setIdProdotto(rsRig.getInt("id_prodotto"));
                            o.addRiga(r);
                        }
                    }
                }
                ordini.add(o);
            }
        }
        return ordini;
    }


    public List<Ordine> findByUserWithRighe(int idUtente) throws SQLException {
        Connection conn = DBConnection.getConnection();
        final String qOrd = """
            SELECT id, data_ordine, corriere, codice_tracking, stato, id_utente
            FROM ordine
            WHERE id_utente=?
            ORDER BY data_ordine DESC, id DESC
        """;
        final String qRig = """
            SELECT prezzo, iva, quantita, id_ordine, id_prodotto
            FROM ordine_prodotto
            WHERE id_ordine=?
        """;

        List<Ordine> lista = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(qOrd)) {
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ordine o = new Ordine();
                    int idOrdine = rs.getInt("id");
                    o.setId(idOrdine);
                    o.setDataOrdine(rs.getDate("data_ordine").toLocalDate());
                    o.setCorriere(rs.getString("corriere"));
                    o.setCodiceTracking(rs.getString("codice_tracking"));
                    o.setStato(Ordine.StatoOrdine.fromValue(rs.getString("stato")));
                    o.setIdUtente(rs.getInt("id_utente"));

                    // carico righe dell'ordine
                    try (PreparedStatement psR = conn.prepareStatement(qRig)) {
                        psR.setInt(1, idOrdine);
                        try (ResultSet rr = psR.executeQuery()) {
                            while (rr.next()) {
                                OrdineProdotto r = new OrdineProdotto();
                                r.setPrezzo(rr.getBigDecimal("prezzo"));
                                r.setIva(rr.getBigDecimal("iva"));
                                r.setQuantita(rr.getInt("quantita"));
                                r.setIdOrdine(rr.getInt("id_ordine"));
                                r.setIdProdotto(rr.getInt("id_prodotto"));
                                o.addRiga(r);
                            }
                        }
                    }

                    lista.add(o);
                }
            }
        }
        return lista;
    }


    /* ==========================
       UPDATE
       ========================== */

    /** Aggiorna i campi di ordine e SOSTITUISCE le righe. */
    public void updateOrdineConRighe(Ordine ordine) throws SQLException {
    	Connection conn = DBConnection.getConnection();
        final String upOrd = """
            UPDATE ordine
               SET data_ordine=?, corriere=?, codice_tracking=?, stato=?, id_utente=?
             WHERE id=?
        """;
        final String delRighe = "DELETE FROM ordine_prodotto WHERE id_ordine=?";
        final String insRiga = """
            INSERT INTO ordine_prodotto (prezzo, iva, quantita, id_ordine, id_prodotto)
            VALUES (?, ?, ?, ?, ?)
        """;

        boolean oldAuto = conn.getAutoCommit();
        conn.setAutoCommit(false);

        try (PreparedStatement psU = conn.prepareStatement(upOrd);
             PreparedStatement psD = conn.prepareStatement(delRighe);
             PreparedStatement psI = conn.prepareStatement(insRiga)) {

            // update ordine
            psU.setDate(1, Date.valueOf(ordine.getDataOrdine()));
            psU.setString(2, ordine.getCorriere());
            psU.setString(3, ordine.getCodiceTracking());
            psU.setString(4, ordine.getStato().getValue());
            psU.setInt(5, ordine.getIdUtente());
            psU.setInt(6, ordine.getId());
            psU.executeUpdate();

            // replace righe: delete + batch insert
            psD.setInt(1, ordine.getId());
            psD.executeUpdate();

            for (OrdineProdotto r : ordine.getRighe()) {
                r.setIdOrdine(ordine.getId());
                psI.setBigDecimal(1, r.getPrezzo());
                psI.setBigDecimal(2, r.getIva());
                psI.setInt(3, r.getQuantita());
                psI.setInt(4, ordine.getId());
                psI.setInt(5, r.getIdProdotto());
                psI.addBatch();
            }
            psI.executeBatch();

            conn.commit();

        } catch (SQLException ex) {
            conn.rollback();
            throw ex;
        } finally {
            conn.setAutoCommit(oldAuto);
        }
    }

    /** Aggiorna solo lo stato dell'ordine. */
    public static void updateSoloStato(int idOrdine, StatoOrdine stato) throws SQLException {
    	Connection conn = DBConnection.getConnection();
        final String sql = "UPDATE ordine SET stato=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stato.getValue());
            ps.setInt(2, idOrdine);
            ps.executeUpdate();
        }
    }

    /* ==========================
       DELETE
       ========================== */

    public void deleteOrdine(int idOrdine) throws SQLException {
    	Connection conn = DBConnection.getConnection();
        // Se hai FK ON DELETE CASCADE su ordine_prodotto, basta cancellare ordine.
        final String del = "DELETE FROM ordine WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(del)) {
            ps.setInt(1, idOrdine);
            ps.executeUpdate();
        }
    }

    /* ==========================
       RIGHE singole (utility)
       ========================== */
    public void addRiga(OrdineProdotto riga) throws SQLException {
    	Connection conn = DBConnection.getConnection();
        final String ins = """
            INSERT INTO ordine_prodotto (prezzo, iva, quantita, id_ordine, id_prodotto)
            VALUES (?, ?, ?, ?, ?)
        """;
        try (PreparedStatement ps = conn.prepareStatement(ins)) {
            ps.setBigDecimal(1, riga.getPrezzo());
            ps.setBigDecimal(2, riga.getIva());
            ps.setInt(3, riga.getQuantita());
            ps.setInt(4, riga.getIdOrdine());
            ps.setInt(5, riga.getIdProdotto());
            ps.executeUpdate();
        }
    }

    public void removeRiga(int idOrdine, int idProdotto) throws SQLException {
    	Connection conn = DBConnection.getConnection();
        final String del = "DELETE FROM ordine_prodotto WHERE id_ordine=? AND id_prodotto=?";
        try (PreparedStatement ps = conn.prepareStatement(del)) {
            ps.setInt(1, idOrdine);
            ps.setInt(2, idProdotto);
            ps.executeUpdate();
        }
    }
    public static boolean haAcquistatoProdotto(int idUtente, int idProdotto) throws SQLException {
        String sql = "SELECT 1 " +
                     "FROM ordine o " +
                     "JOIN ordine_prodotto op ON o.id = op.id_ordine " +
                     "WHERE o.id_utente = ? AND op.id_prodotto = ? " +
                     "LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idUtente);
            ps.setInt(2, idProdotto);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true se esiste almeno una riga
            }
        }
    }
}
