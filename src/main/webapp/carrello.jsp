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
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Il tuo Carrello - Italicious</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50 text-gray-800">

    <div class="container mx-auto px-4 py-10">
        <h1 class="text-3xl font-bold mb-8 text-center">Il tuo carrello</h1>

        <%
            if (carrello == null || carrello.getProdotti().isEmpty()) {
        %>
            <p class="text-center text-lg text-gray-600">Il carrello è vuoto.</p>
        <%
            } else {
        %>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white shadow rounded-lg overflow-hidden">
                    <thead class="bg-red-100 text-red-800">
                        <tr>
                            <th class="py-3 px-6 text-left">Prodotto</th>
                            <th class="py-3 px-6 text-center">Prezzo</th>
                            <th class="py-3 px-6 text-center">Quantità</th>
                            <th class="py-3 px-6 text-center">Totale</th>
                        </tr>
                    </thead>
                    <tbody>
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
                        <tr class="border-b hover:bg-gray-50">
                            <td class="py-4 px-6 font-semibold"><%= prodotto.getNome() %></td>
                            <td class="py-4 px-6 text-center"><%= df.format(prezzoUnitario) %> €</td>
                            <td class="py-4 px-6 text-center">
                                <div class="flex justify-center items-center gap-2">
                                    <form action="" method="post">
                                        <input type="hidden" name="azione" value="aggiorna"/>
                                        <input type="hidden" name="id_prodotto" value="<%= idProdotto %>"/>
                                        <input type="hidden" name="quantita" value="<%= quantita - 1 %>"/>
                                        <button type="submit" class="px-2 py-1 rounded bg-gray-200 hover:bg-gray-300 text-gray-700" <%= (quantita <= 1) ? "disabled" : "" %>>-</button>
                                    </form>

                                    <span class="font-medium"><%= quantita %></span>

                                    <form action="" method="post">
                                        <input type="hidden" name="azione" value="aggiorna"/>
                                        <input type="hidden" name="id_prodotto" value="<%= idProdotto %>"/>
                                        <input type="hidden" name="quantita" value="<%= quantita + 1 %>"/>
                                        <button type="submit" class="px-2 py-1 rounded bg-gray-200 hover:bg-gray-300 text-gray-700">+</button>
                                    </form>
                                </div>
                            </td>
                            <td class="py-4 px-6 text-center font-semibold"><%= df.format(subtotale) %> €</td>
                        </tr>
                        <%
                                }
                            }
                        %>
                        <tr class="bg-red-100 font-bold">
                            <td colspan="3" class="py-4 px-6 text-right">Totale:</td>
                            <td class="py-4 px-6 text-center"><%= df.format(totale) %> €</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="flex justify-center mt-8 gap-4">
                <form action="" method="post">
                    <input type="hidden" name="azione" value="svuota"/>
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded shadow">
                        <i class="fas fa-trash-alt mr-2"></i>Svuota carrello
                    </button>
                </form>

                <form action="" method="post">
                    <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded shadow">
                        <i class="fas fa-credit-card mr-2"></i>Procedi all'acquisto
                    </button>
                </form>
            </div>
        <%
            }
        %>
    </div>

</body>
</html>
