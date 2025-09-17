<%@ page import="Model.Prodotto" %>
<%@ page import="Dao.ProdottoDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Modifica Prodotto</title>
</head>
<link rel="stylesheet" href="css/admin.css">
<body>
    <h2>Modifica Prodotto</h2>
        <%
        // Recupera il prodotto dalla request e fai il cast a Prodotto
        Model.Prodotto prodotto = (Model.Prodotto) request.getAttribute("prodotto");
    %>
    <form action="admin" method="post">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="<%= prodotto.getId() %>" />
       <!--   ID: <input type="number" name="id" value="<%= prodotto.getId() %>" required /><br>-->
        <b>Nome</b>: <input type="text" name="nome" value="<%= prodotto.getNome() %>" required /><br>
        <b>Descrizione</b>: <textarea  name="descrizione" required /><%= prodotto.getDescrizione() %></textarea><br>
        <b>Prezzo</b>: <input type="number" name="prezzo" value="<%= prodotto.getPrezzo() %>" required /><br>
        <b>IVA</b>: <input type="number" name="iva" value="<%= prodotto.getIva() %>" required /><br>
        <b>Disponibilità</b>: <input type="number" name="disponibilita" value="<%= prodotto.getDisponibilita() %>" required /><br>
        <b>Immagine</b>: <input type="text" name="immagine" value="<%= prodotto.getImmagine() %>" required /><br>
        <b>Regione</b>: 
       	   <select name="regione" required>
	    <%
	        List<String> regioni = ProdottoDAO.getRegioni(); 
	    	String regioneAttuale = (prodotto != null) ? prodotto.getRegione() : "";
	        for (String reg : regioni) {
	        	String regSelected = reg.equalsIgnoreCase(regioneAttuale) ? "selected" : "";
	    %>
	        <option value="<%= reg %>"<%= regSelected %>><%= reg %></option>
	    <%
	        }
	    %>
		</select>
		<br>
        <b>Categoria</b>:
        <select name="categoria" required>
	    <%
	        List<String> categorie = ProdottoDAO.getCategorie();
	    	String categoriaAttuale = (prodotto != null) ? prodotto.getCategoria() : "";
	        for (String cat : categorie) {
	        	String catSelected = cat.equalsIgnoreCase(categoriaAttuale) ? "selected" : "";
	    %>
	        <option value="<%= cat %>"<%= catSelected %>><%= cat %></option>
	    <%
	        }
	    %>
	</select>
	<br>
        <button type="submit">Aggiorna Prodotto</button>
    </form>

</body>
</html>
