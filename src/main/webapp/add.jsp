<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="Dao.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Aggiungi Prodotto</title>
</head>
<link rel="stylesheet" href="css/admin.css">
<body>
    <h2>Aggiungi Nuovo Prodotto</h2>
    <form action="admin" method="post">
        <input type="hidden" name="action" value="add" />
        <!-- ID: <input type="number" name="id" required /><br>-->
        <b>Nome</b>: <input type="text" name="nome" required /><br>
        <b>Descrizione</b>: <input type="text" name="descrizione" required /><br>
        <b>Prezzo</b>: <input type="number" name="prezzo" required /><br>
        <b>IVA</b>: <input type="number" name="iva" required /><br>
        <b>Disponibilità</b>: <input type="number" name="disponibilita" required /><br>
        <b>Immagine</b>: <input type="text" name="immagine" required /><br>
        <b>Regione</b>:
        <select name="regione" required>
	    <%
	        List<String> regioni = ProdottoDAO.getRegioni();       
	        for (String reg : regioni) {
	    %>
	        <option value="<%= reg %>"><%= reg %></option>
	    <%
	        }
	    %>
		</select>
		<br>
        <b>Categoria</b>:
        <select name="categoria" required>
	    <%
	        List<String> categorie = ProdottoDAO.getCategorie();       
	        for (String cat : categorie) {
	    %>
	        <option value="<%= cat %>"><%= cat %></option>
	    <%
	        }
	    %>
	</select>
	<br>
        <button type="submit">Aggiungi Prodotto</button>
    </form>

</body>
</html>