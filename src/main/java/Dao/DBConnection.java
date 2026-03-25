package Dao;

import java.io.InputStream;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ArrayBlockingQueue;

public class DBConnection {
    private static final Properties properties = new Properties();
    private static final int MAX_POOL_SIZE = 15;
    private static ArrayBlockingQueue<Connection> pool;
    private static String url;
    private static String user;
    private static String password;

    static {
        // Carica il file properties
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (in != null) {
                properties.load(in);
            } else {
                System.err.println("ATTENZIONE: File 'config.properties' non trovato nel classpath. Rinominare 'config.properties.template' in 'config.properties' e inserire le credenziali.");
            }
        } catch (Exception e) {
            System.err.println("Errore durante il caricamento di config.properties");
            e.printStackTrace();
        }

        // Verifica la presenza del driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("➡️ Connessione Fallita!!!! Driver non trovato.");
            e.printStackTrace();
        }

        url = properties.getProperty("db.url");
        user = properties.getProperty("db.user");
        password = properties.getProperty("db.password"); 

        if (url != null && user != null && password != null) {
            // Inizializza il pool con una capacita' massima
            pool = new ArrayBlockingQueue<>(MAX_POOL_SIZE);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (pool == null) {
            throw new SQLException("Credenziali del database mancanti. Assicurati che config.properties sia presente e configurato.");
        }

        // Estrai una connessione libera dal pool, se c'è
        Connection connection = pool.poll();

        // Se il pool è vuoto, o la connessione non è più valida/è chiusa, creane una nuova fisica
        if (connection == null || connection.isClosed() || !connection.isValid(2)) {
            connection = DriverManager.getConnection(url, user, password);
        }

        final Connection realConnection = connection;

        // Crea un Proxy per intercettare le chiamate al metodo close().
        // In questo modo i vari DAO possono continuare ad usare il try-with-resources o .close().
        return (Connection) Proxy.newProxyInstance(
                Connection.class.getClassLoader(),
                new Class[]{Connection.class},
                (proxy, method, args) -> {
                    if ("close".equals(method.getName())) {
                        // Invece di chiudere la connessione fisica, la rilascio nel pool (se c'e' posto)
                        if (pool.size() < MAX_POOL_SIZE && !realConnection.isClosed()) {
                            pool.offer(realConnection);
                        } else {
                            realConnection.close();
                        }
                        return null; // close() ritorna void
                    }
                    if ("isClosed".equals(method.getName())) {
                        return false; 
                    }
                    // Tutti gli altri metodi di java.sql.Connection vengono proxiati sulla connessione vera
                    return method.invoke(realConnection, args);
                });
    }
}
