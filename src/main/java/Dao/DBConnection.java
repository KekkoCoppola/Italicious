package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
    	System.out.println("➡️ Tentativo di connessione al DB...");

        try {
        	
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
        	System.out.println("➡️ Connessione Fallita!!!!");
            e.printStackTrace();
        }

        String url = "jdbc:mysql://localhost:3306/italiciousdb";
        String user = "root";
        String password = "Napoli1926"; 
        return DriverManager.getConnection(url, user, password);
    }
}

