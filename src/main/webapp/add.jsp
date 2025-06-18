<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Aggiungi Prodotto</title>
</head>
<body>
    <h2>Aggiungi Nuovo Prodotto</h2>
    <form action="admin" method="post">
        <input type="hidden" name="action" value="add" />
        <!-- ID: <input type="number" name="id" required /><br>-->
        Nome: <input type="text" name="nome" required /><br>
        Descrizione: <input type="text" name="descrizione" required /><br>
        Prezzo: <input type="number" name="prezzo" required /><br>
        IVA: <input type="number" name="iva" required /><br>
        Disponibilità: <input type="number" name="disponibilita" required /><br>
        Immagine: <input type="text" name="immagine" required /><br>
        Regione: <input type="text" name="regione" required /><br>
        <button type="submit">Aggiungi Prodotto</button>
    </form>
</body>
</html>