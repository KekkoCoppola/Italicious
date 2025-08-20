<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Carrello" %>
<%@ page import="Dao.CarrelloDAO" %>
<%@ page import="Model.ElementoCarrello" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="Model.UserService" %>
<%@ page import="Dao.ProdottoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");
	int idUtente = -1;
	if(session.getAttribute("role")!=null)
		idUtente = UserService.getIdByMail((String) session.getAttribute("email"),(String) session.getAttribute("role"));
    DecimalFormat df = new DecimalFormat("#0.00");
    double totale = 0.0;
    
    if (carrello == null) {
        carrello = new Carrello();
        if (idUtente != -1) {
        	 List<ElementoCarrello> righe = CarrelloDAO.findByUserId(idUtente);
             for (ElementoCarrello r : righe) {
                 carrello.aggiungiProdotto(r.getIdProdotto(), r.getQuantita());
             }
        }
        session.setAttribute("carrello", carrello);
    }
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
                        <td class="py-4 px-6 text-center" id="prezzo-<%= idProdotto %>"><%= df.format(prezzoUnitario) %> &euro;</td>
                        <td class="py-4 px-6 text-center">
                            <div class="flex justify-center items-center gap-2">
                                <button onclick="aggiornaQuantitaDinamica(<%= idProdotto %>, -1)"
                                    class="px-2 py-1 rounded bg-gray-200 hover:bg-gray-300 text-gray-700"
                                    id="btn-meno-<%= idProdotto %>"
                                    <%= (quantita <= 1) ? "disabled" : "" %>>−</button>

                                <span class="font-medium" id="quantita-<%= idProdotto %>"><%= quantita %></span>

                                <button onclick="aggiornaQuantitaDinamica(<%= idProdotto %>, 1)"
                                    class="px-2 py-1 rounded bg-gray-200 hover:bg-gray-300 text-gray-700">+</button>
                                <button onclick="rimuovi(<%= idProdotto %>, 0)"
                                    class="px-2 py-1 text-red-500  hover:text-red-700"><i class = "fas fa-trash"></i></button>
                            </div>
                        </td>
                        <td class="py-4 px-6 text-center font-semibold" id="subtotale-<%= idProdotto %>">
                            <%= df.format(subtotale) %> €
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    <tr class="bg-red-100 font-bold">
                        <td colspan="3" class="py-4 px-6 text-right">Totale:</td>
                        <td class="py-4 px-6 text-center" id="totale-generale"><%= df.format(totale) %> €</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="flex justify-center mt-8 gap-4">
            <form action="carrello" method="post">
                <input type="hidden" name="azione" value="svuota"/>
                <input type="hidden" name="id_prodotto" value="0"/>
                <input type="hidden" name="quantita" value="0"/>
                <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded shadow">
                    <i class="fas fa-trash-alt mr-2"></i>Svuota carrello
                </button>
            </form>

            <form action="OrdineServlet" method="post">
                <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded shadow">
                    <i class="fas fa-credit-card mr-2"></i>Procedi all'acquisto
                </button>
            </form>
        </div>
    <%
        }
    %>
</div>

<!-- Notifica -->
<div id="notifica" class="fixed top-5 right-5 bg-gray-800 text-white px-4 py-2 rounded-lg shadow z-50 hidden"></div>

<script>
function aggiornaQuantitaDinamica(idProdotto, variazione) {
    const span = document.getElementById("quantita-" + idProdotto);
    const attuale = parseInt(span.innerText);
    const nuovaQuantita = attuale + variazione;
    if (nuovaQuantita < 1) return;
    aggiornaQuantita(idProdotto, nuovaQuantita);
}

function rimuovi(idProdotto, quantita) {
    fetch('carrello', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            azione: 'aggiorna',
            id_prodotto: idProdotto,
            quantita: quantita
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            //mostraNotifica("Elemento Rimosso ✅", "green");
            location.reload();
            //setTimeout(() => location.reload(), 300);
        } else {
            mostraNotifica("Errore rimozione", "red");
        }
    })
    .catch(() => mostraNotifica("Errore nella richiesta", "red"));
}


function aggiornaQuantita(idProdotto, nuovaQuantita) {
    fetch('carrello', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            azione: 'aggiorna',
            id_prodotto: idProdotto,
            quantita: nuovaQuantita
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            document.getElementById("quantita-" + idProdotto).innerText = data.nuovaQuantita;
            const btnMeno = document.getElementById("btn-meno-" + idProdotto);
            if (data.nuovaQuantita <= 1) btnMeno.setAttribute("disabled", "disabled");
            else btnMeno.removeAttribute("disabled");

            const prezzo = parseFloat(document.getElementById("prezzo-" + idProdotto).innerText.replace(",", "."));
            const nuovoSubtotale = prezzo * data.nuovaQuantita;
            document.getElementById("subtotale-" + idProdotto).innerText =
                nuovoSubtotale.toFixed(2).replace(".", ",") + " €";
            aggiornaTotaleGenerale();

            mostraNotifica("Quantità aggiornata ✅", "green");
        } else {
            mostraNotifica("Errore aggiornamento", "red");
        }
    })
    .catch(() => mostraNotifica("Errore nella richiesta", "red"));
}

function aggiornaTotaleGenerale() {
    let total = 0.0;
    document.querySelectorAll("[id^='subtotale-']").forEach(el => {
        const valore = parseFloat(el.innerText.replace(",", "."));
        if (!isNaN(valore)) total += valore;
    });
    document.getElementById("totale-generale").innerText = total.toFixed(2).replace(".", ",") + " €";
}

function mostraNotifica(msg, colore) {
    const box = document.getElementById("notifica");
    box.innerText = msg;
    box.style.backgroundColor = (colore === "green") ? "#16a34a" : "#dc2626";
    box.classList.remove("hidden");
    setTimeout(() => box.classList.add("hidden"), 3000);
}
</script>

</body>
</html>
