<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Carrello" %>
<%@ page import="Model.ElementoCarrello" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="Dao.ProdottoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");
    DecimalFormat df = new DecimalFormat("#0.00");
    double totale = 0.0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrello</title>
    <style>
        table { width: 80%; margin: auto; border-collapse: collapse; }
        th, td { border: 1px solid #aaa; padding: 10px; text-align: center; }
        .btn { padding: 6px 10px; margin: 4px; cursor: pointer; }
        .qty-container { display: flex; justify-content: center; align-items: center; gap: 5px; }
    </style>
</head>
<body>

<h2 style="text-align:center;">Il tuo carrello</h2>

<%
    if (carrello == null || carrello.getProdotti().isEmpty()) {
%>
    <p style="text-align:center;">Il carrello è vuoto.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>Nome prodotto</th>
            <th>Prezzo</th>
            <th>Quantità</th>
            <th>Totale</th>
        </tr>
<%
        for (ElementoCarrello item : carrello.getProdotti()) {
            int idProdotto = item.getIdProdotto();
            int quantita = item.getQuantita();
            Prodotto prodotto = ProdottoDAO.getProdottoById(idProdotto);

            if (prodotto != null) {
                double prezzoUnitario = prodotto.getPrezzo();
                double subtotale = prezzoUnitario * quantita;
                totale += subtotale;
%>
        <tr>
            <td><%= prodotto.getNome() %></td>
            <td><%= df.format(prezzoUnitario) %> €</td>
            <td>
                <div class="qty-container">
                    <!-- Bottone - -->
                    <form action="../CarrelloServlet" method="post">
                        <input type="hidden" name="azione" value="aggiorna"/>
                        <input type="hidden" name="id_prodotto" value="<%= idProdotto %>"/>
                        <input type="hidden" name="quantita" value="<%= quantita - 1 %>"/>
                        <input type="submit" value="-" class="btn" <%= (quantita <= 1) ? "disabled" : "" %>/>
                    </form>

                    <span><%= quantita %></span>

                    <!-- Bottone + -->
                    <form action="../CarrelloServlet" method="post">
                        <input type="hidden" name="azione" value="aggiorna"/>
                        <input type="hidden" name="id_prodotto" value="<%= idProdotto %>"/>
                        <input type="hidden" name="quantita" value="<%= quantita + 1 %>"/>
                        <input type="submit" value="+" class="btn"/>
                    </form>
                </div>
            </td>
            <td><%= df.format(subtotale) %> €</td>
        </tr>
<%
            }
        }
%>
        <tr>
            <td colspan="3" style="text-align:right;"><strong>Totale:</strong></td>
            <td><strong><%= df.format(totale) %> €</strong></td>
        </tr>
    </table>

    <div style="text-align:center; margin-top:20px;">
        <form action="../CarrelloServlet" method="post" style="display:inline;">
            <input type="hidden" name="azione" value="svuota"/>
            <input type="submit" value="Svuota carrello" class="btn"/>
        </form>

        <form action="../ConfermaOrdineServlet" method="post" style="display:inline;">
            <input type="submit" value="Procedi all'acquisto" class="btn"/>
        </form>
    </div>
<%
    }
%>

</body>
</html>
