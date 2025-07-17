package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import Model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ListaPreferitiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        Integer idUtente = (Integer) request.getSession().getAttribute("id_utente");
        List<Prodotto> preferiti = new ArrayList<>();

       /* try (Connection conn = Database.getConnection()) {
            String sql = "SELECT p.* FROM Prodotto p JOIN ListaPreferiti l ON p.id_prodotto = l.id_prodotto WHERE l.id_utente = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idUtente);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId(rs.getInt("id_prodotto"));
                    p.setNome(rs.getString("nome"));
                    // ... altri campi
                    preferiti.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }*/

        request.setAttribute("preferiti", preferiti);
        request.getRequestDispatcher("/preferiti.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        int idProdotto = Integer.parseInt(request.getParameter("id_prodotto"));
        Integer idUtente = (Integer) request.getSession().getAttribute("id_utente");

       /* try (Connection conn = Database.getConnection()) {
            if ("add".equals(action)) {
                String sql = "INSERT INTO ListaPreferiti (id_utente, id_prodotto) VALUES (?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, idUtente);
                    stmt.setInt(2, idProdotto);
                    stmt.executeUpdate();
                }
            } else if ("remove".equals(action)) {
                String sql = "DELETE FROM ListaPreferiti WHERE id_utente = ? AND id_prodotto = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, idUtente);
                    stmt.setInt(2, idProdotto);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }*/

        // redirect al catalogo o pagina preferiti
        response.sendRedirect("catalogo.jsp");
    }
}

