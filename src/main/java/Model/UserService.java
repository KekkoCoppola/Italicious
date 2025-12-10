package Model;

import org.mindrot.jbcrypt.BCrypt;

import Dao.DBConnection;

import java.sql.*;

public class UserService {

    public String loginUser(String email, String password, Connection conn) throws SQLException {
        // Verifica nella tabella user
        String query = "SELECT password FROM utente WHERE mail = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    return "user"; // Login come user
                }
            }
        }

        // Verifica nella tabella admin
        query = "SELECT password FROM amministratore WHERE mail = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
            	System.out.println("SIAMO NEL CASO ADMIN");
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    return "admin"; // Login come admin
                }
            }
        }

        return null; // Se non trovato
    }

    // Registra un nuovo utente
    public boolean registerUser(String nome, String email,String telefono, String password, Connection conn) throws SQLException {
            // Registrazione per utente normale nella tabella user
            return registerNormalUser(nome,email,telefono, password, conn);
            }
    
    public static boolean updateUtente(Utente u,String role) {
        boolean updated = false;
        String query = "UPDATE utente SET nome = ?, mail = ?, indirizzo = ?, telefono = ?, fatturazione = ? WHERE id = ?";
        if (role.equals("admin")) {
    		query = "UPDATE amministratore SET nome = ?, mail = ?, indirizzo = ?, telefono = ?,fatturazione = ? WHERE id = ?";
    	}

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, u.getNome());
            ps.setString(2, u.getMail());
            ps.setString(3, u.getIndirizzo());
            ps.setString(4, u.getTelefono());
            ps.setString(5, u.getFatturazione());
            ps.setInt(6, u.getId());

            int rows = ps.executeUpdate();
            updated = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }
    // Cambia Password
    public static boolean changePassword(int idUtente,String password,String role) {
        boolean updated = false;
        String query = "UPDATE utente SET password = ? WHERE id = ?";
        if (role.equals("admin")) {
    		query = "UPDATE amministratore SET password = ? WHERE id = ?";
    	}
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, hashedPassword);
            ps.setInt(2, idUtente);

            int rows = ps.executeUpdate();
            updated = rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updated;
    }
    // Ritorna l'username
    public String getUsername(String email,String password, Connection conn,String role) throws SQLException {
    	String query = "SELECT nome FROM utente WHERE mail = ?";
    	 if (role.equals("admin")) {
    		query = "SELECT nome FROM amministratore WHERE mail = ?";
    	}
    	 
        

            try (PreparedStatement stmt = conn.prepareStatement(query)){

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("nome");
                return username;
            } else {
                return null;
            }
            }
    }

    // Registrazione utente normale
    private boolean registerNormalUser(String nome, String email,String telefono, String password, Connection conn) throws SQLException {
        if (doesUserExist(email, conn, "utente") && doesUserExist(email, conn, "amministratore")) {
            return false; // Username già esistente
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String query = "INSERT INTO utente (nome,mail,telefono, password) VALUES (?, ?,?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
        	stmt.setString(1, nome);
        	stmt.setString(2, email);
        	stmt.setString(3, telefono);
            stmt.setString(4, hashedPassword);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Registrazione amministratore
    public static boolean registerAdmin(String nome,String email, String password, Connection conn) throws SQLException {
        if (doesUserExist(email, conn, "utente") && doesUserExist(email, conn, "amministratore")) {
            return false; // Username già esistente
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String query = "INSERT INTO amministratore (nome,mail, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
        	stmt.setString(1, nome);
        	stmt.setString(2, email);
            stmt.setString(3, hashedPassword);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Controlla se l'utente esiste già nella tabella specificata
    public static boolean doesUserExist(String email, Connection conn, String table) throws SQLException {
        String query = "SELECT mail FROM " + table + " WHERE mail = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Se l'utente esiste, torna true
        }
    }
    // controlla se l'username esiste gia nel db
    public static boolean usernameExistsAcrossTables(Connection conn, String username, int excludeId) throws SQLException {
        final String sql = """
            SELECT 1 FROM utente WHERE nome = ? AND id <> ?
            UNION ALL
            SELECT 1 FROM amministratore WHERE nome = ? AND id <> ?
            LIMIT 1
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username.trim());
            ps.setInt(2, excludeId);
            ps.setString(3, username.trim());
            ps.setInt(4, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
    // controlla se l'email esiste gia nel db
    public static boolean emailExistsAcrossTables(Connection conn, String email, int excludeId) throws SQLException {
        final String sql = """
            SELECT 1 FROM utente WHERE mail = ? AND id <> ?
            UNION ALL
            SELECT 1 FROM amministratore WHERE mail = ? AND id <> ?
            LIMIT 1
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim());
            ps.setInt(2, excludeId);
            ps.setString(3, email.trim());
            ps.setInt(4, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ritorna l'email dall'id (PK)
    public static int getIdByMail(String email, String role) {
    	String query = "SELECT id FROM utente WHERE mail = ?";
		if (role.equals("admin")) {
		   		query = "SELECT id FROM amministratore WHERE mail = ?";
		}
		
		try (PreparedStatement stmt = DBConnection.getConnection().prepareStatement(query)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id"); // restituisce l'ID trovato
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // log errore
        }
		return -1;
    }
    // Ritorna un utente dall'id
    public static Utente getUserById(int id,String role) {
    	Utente utente = null;
    	String query = "SELECT id, nome, mail, password, indirizzo, telefono,fatturazione FROM utente WHERE id = ?";
    	if (role.equals("admin")) {
	   		query = "SELECT id, nome, mail, password,indirizzo,telefono,fatturazione FROM amministratore WHERE id = ?";
	}
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    utente = new Utente();
                    utente.setId(rs.getInt("id"));
                    utente.setNome(rs.getString("nome"));
                    utente.setMail(rs.getString("mail"));
                    utente.setPassword(rs.getString("password"));
                    utente.setIndirizzo(rs.getString("indirizzo"));
                    utente.setTelefono(rs.getString("telefono"));
                    utente.setFatturazione(rs.getString("fatturazione"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return utente;
    }
}
