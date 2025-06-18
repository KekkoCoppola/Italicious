<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin - Gestione Prodotti</title>
	    <%
	    String username = (String) session.getAttribute("username");
	    if (username != null) {
	%>
	    <p>Benvenuto, <strong><%= username %></strong>!</p>
	<%
	    }
	%>
	<button onclick="location.href='catalogo'">Catalogo</button>
</head>
<body>
    <h2>Gestione Prodotti</h2>
    <a href="admin?action=add">Aggiungi nuovo prodotto</a>
    <table>
        <tr>
        	<th>ID</th>
            <th>Nome</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>IVA</th>
            <th>Disponibilità</th>
            <th>Immagine</th>
            <th>Regione</th>
            <th>Azioni</th>
        </tr>
        <%
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            for (Prodotto p : prodotti) {
        %>
        <tr>
       		<td><%= p.getId() %></td>
            <td><%= p.getNome() %></td>
            <td><%= p.getDescrizione() %></td>
            <td><%= p.getPrezzo() %></td>
            <td><%= p.getIva() %></td>
            <td><%= p.getDisponibilita() %></td>
            <td><%= p.getImmagine() %></td>
            <td><%= p.getRegione() %></td>
            <td>
                <a href="admin?action=edit&id=<%= p.getId() %>">Modifica</a> | 
                <a href="admin?action=delete&id=<%= p.getId() %>">Elimina</a>
            </td>
        </tr>
        <% } %>
    </table>
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
    
</body>
</html>
