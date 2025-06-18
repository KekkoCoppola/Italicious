package Model;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class UserService {

    // Verifica se l'utente esiste e la password è corretta (sia per user che per admin)
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
    public boolean registerUser(String nome, String email, String password, Connection conn) throws SQLException {
       
 
            // Registrazione per utente normale nella tabella user
            return registerAdmin(nome,email, password, conn);

       
    }
    
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
    private boolean registerNormalUser(String nome, String email, String password, Connection conn) throws SQLException {
        if (doesUserExist(email, conn, "utente")) {
            return false; // Username già esistente
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String query = "INSERT INTO utente (nome,mail, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
        	stmt.setString(1, nome);
        	stmt.setString(2, email);
            stmt.setString(3, hashedPassword);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Registrazione amministratore
    private boolean registerAdmin(String nome,String email, String password, Connection conn) throws SQLException {
        if (doesUserExist(email, conn, "amministratore")) {
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
    private boolean doesUserExist(String email, Connection conn, String table) throws SQLException {
        String query = "SELECT mail FROM " + table + " WHERE mail = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Se l'utente esiste, torna true
        }
    }
}
