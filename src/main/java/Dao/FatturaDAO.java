package Dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FatturaDAO {
	public static int saveOrUpdateFattura(int ordineId, String partitaIva,
            BigDecimal totale, BigDecimal totaleImponibile)
throws SQLException {
	
		final String sql = "INSERT INTO fattura (ordine_id, partita_iva, totale, totaleimponibile) " +
		"VALUES (?, ?, ?, ?) " +
		"ON DUPLICATE KEY UPDATE " +
		"partita_iva = VALUES(partita_iva), " +
		"totale = VALUES(totale), " +
		"totaleimponibile = VALUES(totaleimponibile)";
		
		try (var conn = DBConnection.getConnection();
		var ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
		
		ps.setInt(1, ordineId);
		ps.setString(2, partitaIva);
		ps.setBigDecimal(3, totale == null ? null : totale.setScale(2, java.math.RoundingMode.HALF_UP));
		ps.setBigDecimal(4, totaleImponibile == null ? null : totaleImponibile.setScale(2, java.math.RoundingMode.HALF_UP));
		
		ps.executeUpdate();
		
		// Recupera l'id della fattura
		try (ResultSet rs = ps.getGeneratedKeys()) {
		if (rs.next()) {
		return rs.getInt(1); // se era un insert nuovo
		}
	}
	
	// se era un update, recupero l'id con una select
		try (var ps2 = conn.prepareStatement("SELECT id FROM fattura WHERE ordine_id = ?")) {
			ps2.setInt(1, ordineId);
			try (ResultSet rs2 = ps2.executeQuery()) {
				if (rs2.next()) return rs2.getInt("id");
			}
	}
	
		throw new SQLException("Impossibile ottenere l'id della fattura.");
			}
		}

}
