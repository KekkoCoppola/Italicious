<%@ page import="Model.Prodotto" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Modifica Prodotto</title>
</head>
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
        Nome: <input type="text" name="nome" value="<%= prodotto.getNome() %>" required /><br>
        Descrizione: <input type="text" name="descrizione" value="<%= prodotto.getDescrizione() %>" required /><br>
        Prezzo: <input type="number" name="prezzo" value="<%= prodotto.getPrezzo() %>" required /><br>
        IVA: <input type="number" name="iva" value="<%= prodotto.getIva() %>" required /><br>
        Disponibilità: <input type="number" name="disponibilita" value="<%= prodotto.getDisponibilita() %>" required /><br>
        Immagine: <input type="text" name="immagine" value="<%= prodotto.getImmagine() %>" required /><br>
        Regione: <input type="text" name="regione" value="<%= prodotto.getRegione() %>" required /><br>
        <button type="submit">Aggiorna Prodotto</button>
    </form>
</body>
</html>
