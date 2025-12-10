package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import Model.Carrello;
import Model.ElementoCarrello;
import Model.UserService;
import Dao.CarrelloDAO;
import Dao.DBConnection;
import java.io.IOException;
import java.sql.*;

import java.util.List;

public class LoginServlet extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection(); 
            UserService userService = new UserService();

            String role = userService.loginUser(email, password, conn);

            if (role != null) {
                // Login riuscito
            	
            	
                HttpSession session = request.getSession(); 
                
                Carrello guestCart = (Carrello) session.getAttribute("carrello");

                // 2) somma il guest nel DB dell'utente (se c'è qualcosa)
                if (guestCart != null && guestCart.getProdotti() != null) {
                    for (ElementoCarrello e : guestCart.getProdotti()) {
                        CarrelloDAO.aggiungiOaggiornaElemento(UserService.getIdByMail(email, role), e.getIdProdotto(), e.getQuantita());
                    }
                }
                Carrello mergedCart = new Carrello();
                List<ElementoCarrello> righe = CarrelloDAO.findByUserId(UserService.getIdByMail(email, role));
                for (ElementoCarrello r : righe) {
                	mergedCart.aggiungiProdotto(r.getIdProdotto(), r.getQuantita());
                }
                session.setAttribute("carrello", mergedCart); 
                
                
                session.setAttribute("email", email); 
                String username = userService.getUsername(email, password, conn,role);
                session.setAttribute("username", username);
                session.setAttribute("role", role); // Salva il ruolo (user o admin)
                session.setAttribute("userId", UserService.getIdByMail(email, role));

                // Redirigi alla pagina catalogo
                if ("admin".equals(role)) {
                    response.sendRedirect("catalogo");
                } else {
                    response.sendRedirect("catalogo"); 
                }
            } else {
                // Credenziali errate
                request.setAttribute("notifica", "Email o password errati.");
                request.setAttribute("coloreNotifica", "#dc2626");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
