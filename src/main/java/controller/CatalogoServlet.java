package controller;

import Dao.ProdottoDAO;
import Model.Prodotto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
//@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String regione = request.getParameter("regione");
    	if(regione!=null && !regione.isEmpty()) {
    		List<Prodotto> found = ProdottoDAO.getProdottiByRegione(regione);
    		request.setAttribute("prodotti", found); 
            request.setAttribute("pageTitle", "Catalogo Prodotti");
        	request.setAttribute("contentPage", "catalogo.jsp"); 

            request.getRequestDispatcher("/layout.jsp").forward(request, response);
            return;
    	}
    	String suggest = request.getParameter("suggest");
    	if(suggest!=null && !suggest.isEmpty()) {
	    	if ("1".equals(suggest)) {
	    	    String q = request.getParameter("q");
	    	    String categoria = request.getParameter("categoria"); // opzionale
	    	    int limit = 8;
	    	    try { limit = Math.min(20, Math.max(1, Integer.parseInt(request.getParameter("limit")))); } catch (Exception ignored) {}
	
	    	    List<Prodotto> found = ProdottoDAO.suggest(q, categoria, limit);
	
	    	    response.setContentType("application/json; charset=UTF-8");
	    	    StringBuilder json = new StringBuilder("[");
	    	    for (int i = 0; i < found.size(); i++) {
	    	        Prodotto p = found.get(i);
	    	        if (i > 0) json.append(',');
	    	        json.append('{')
	    	        .append("\"id\":").append(p.getId())
	    	        .append(",\"nome\":\"").append(escape(nvl(p.getNome()))).append('"')
	    	        .append(",\"regione\":\"").append(escape(nvl(p.getRegione()))).append('"')
	    	        .append(",\"img\":\"").append(escape(nvl(p.getImmagine()))).append('"')
	    	        .append('}');
	    	    }
	    	    json.append("]");
	    	    response.getWriter().write(json.toString());
	    	    return; 
	    	}
    	}
    	String cat = request.getParameter("cat");
        if (cat == null || cat.isBlank()) cat = "tutti";
        
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodotti;
        if ("tutti".equals(cat)) {
            prodotti = prodottoDAO.getAllProdotti();
        } else {
            prodotti = prodottoDAO.getProdottiByCategoria(cat); 
        }


        request.setAttribute("prodotti", prodotti); 
        request.setAttribute("pageTitle", "Catalogo Prodotti");
    	request.setAttribute("contentPage", "catalogo.jsp"); 

        request.getRequestDispatcher("/layout.jsp").forward(request, response);
        
    }
    private static String nvl(String s) {
        return (s == null) ? "" : s;
    }
    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\\","\\\\").replace("\"","\\\"")
                .replace("<","\\u003C").replace(">","\\u003E")
                .replace("&","\\u0026");
    }
}