<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.Ordine" %>
<%@ page import="Model.Ordine.StatoOrdine" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.UserService" %>
<%@ page import="Model.Utente" %>
<%@ page import="Model.OrdineProdotto" %>
<%@ page import="Dao.OrdineDAO" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>

<%
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	NumberFormat Nfmt = NumberFormat.getNumberInstance(Locale.ITALY);
	Nfmt.setMinimumFractionDigits(2);
	Nfmt.setMaximumFractionDigits(2);
	Utente u = UserService.getUserById((Integer) session.getAttribute("userId"), (String) session.getAttribute("role"));
	boolean hasFatturazione = false;
	if(u.getFatturazione()!=null && !u.getFatturazione().isEmpty()) hasFatturazione = true;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<body class="min-h-screen">
<div class="max-w-none mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row block gap-8">
			<jsp:include page="parziali/sidebarProfilo.jsp" />
				<div class="flex-1 min-w-0 bg-white rounded-lg shadow-sm overflow-hidden">

  <% List<Ordine> ordini = new OrdineDAO().findByUserWithRighe((Integer) session.getAttribute("userId"));
     if (ordini != null && !ordini.isEmpty()) { %>

  <!-- Header: solo desktop/tablet -->
  <div class="hidden md:grid grid-cols-12 bg-gray-100 p-4 font-medium text-gray-700">
    <div class="col-span-2">ID Ordine</div>
    <div class="col-span-2">Data</div>
    <div class="col-span-2">Totale</div>
    <div class="col-span-2">Stato</div>
    <div class="col-span-2">Corriere</div>
    <div class="col-span-2 text-right">Azioni</div>
  </div>

  <% for (Ordine o : ordini) { %>
  <!-- Riga: card su mobile, tabella da md -->
  <div class="grid grid-cols-1 gap-2 md:grid-cols-12 p-4 border-b border-gray-200 hover:bg-gray-50 transition">
    <div class="md:col-span-2">
      <span class="md:hidden block text-xs text-gray-500">ID Ordine</span>
      <span class="font-medium">#<%= o.getId() %></span>
    </div>

    <div class="md:col-span-2">
      <span class="md:hidden block text-xs text-gray-500">Data</span>
      <span class="text-gray-600"><%= o.getDataOrdine().format(fmt) %></span>
    </div>

    <div class="md:col-span-2">
      <span class="md:hidden block text-xs text-gray-500">Totale</span>
      <span class="font-medium">€ <%= Nfmt.format(o.getTotaleIvato()) %></span>
    </div>

<%
	StatoOrdine stato = o.getStato();
    String badgeClass = "";

    switch (stato) {
    case IN_ELABORAZIONE:
        badgeClass = "bg-yellow-100 text-yellow-800";
        break;
    case SPEDITO:
        badgeClass = "bg-blue-100 text-blue-800";
        break;
    case ANNULLATO:
        badgeClass = "bg-red-100 text-red-800";
        break;
    case CONSEGNATO:
        badgeClass = "bg-green-100 text-green-800";
        break;
    default:
        badgeClass = "bg-gray-100 text-gray-800";
}
%>

<div class="md:col-span-2">
    <span class="md:hidden block text-xs text-gray-500">Stato</span>
    <span class="inline-block <%= badgeClass %> px-2 py-0.5 rounded text-sm">
        <%= stato.getValue() %>
    </span>
</div>


    <div class="md:col-span-2">
      <span class="md:hidden block text-xs text-gray-500">Corriere</span>
      <span class="text-gray-600 break-all md:truncate">
        <%= o.getCorriere() != null ? o.getCorriere() : "-" %> (<%= o.getCodiceTracking() %>)
      </span>
    </div>

    <div class="md:col-span-2 flex md:justify-end">
      <button onclick="scaricaFattura(<%= o.getId() %>)"
              class="text-green-600 hover:text-green-800" title="Scarica Fattura">
        <i class="fas fa-download"></i>
      </button>
    </div>
  </div>
  <% } %>

  <% } else { %>
    <p class="p-6">Nessun Ordine Registrato.</p>
  <% } %>
</div>

			           </div>
			          </div>
			          <div id="piva-modal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 hidden">
						  <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
						    
						    <!-- Titolo -->
						    <h2 class="text-xl font-semibold text-gray-800 mb-4 text-center">Inserisci la Partita IVA</h2>
						    <p class="text-gray-600 text-sm mb-4 text-center">
						      Se non hai la Partita IVA puoi usare il tuo Codice Fiscale per la fatturazione.
						    </p>
						
						    <!-- Input -->
						    <form id=generaFattura action="<%=request.getContextPath() %>/fattura" method="post" target="_blank">
						    <div class="mb-4">		  
						    <input id=ordineId name=ordineId type=hidden value="">
						      <label id="piLabel" for="partitaIva" class="block text-sm font-medium text-gray-700">Partita IVA</label>
						      <input type="text" id="partitaIva" name="richiedente"
						             placeholder="IT12345678901"
						             class="mt-1 w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none" required>
						    </div>					
						    <!-- Checkbox -->
						    <div class="flex items-center mb-6">
						      <input type="checkbox" id="noPiva" class="h-4 w-4 text-blue-600 border-gray-300 rounded">
						      <label for="noPiva" class="ml-2 text-sm text-gray-700">Non ho la Partita IVA</label>
						    </div>
						
						    <!-- Azioni -->
						    <div class="flex justify-end space-x-3">
						      <button id="cancelModal" type="button" class="px-4 py-2 border rounded-lg text-gray-700 hover:bg-gray-100">
						        Annulla
						      </button>
						      <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700">
						        Conferma
						      </button>
						    </div>
						    </form>
						  </div>
						</div>
</body>
<script>
const modal = document.getElementById('piva-modal');
const cancelBtn = document.getElementById('cancelModal');
const confirmBtn = document.getElementById('confirmModal');
const noPiva = document.getElementById('noPiva');
const pivaLabel = document.getElementById('piLabel');
const pivaInput = document.getElementById('partitaIva');
const ordineId = document.getElementById('ordineId');
//FATTURA
function scaricaFattura(orderId) {
	ordineId.value=orderId;
	if(<%=hasFatturazione%>){
		pivaInput.value='<%=u.getFatturazione()%>';
		const form = document.getElementById('generaFattura');
		form.submit()
	}else
		modal.classList.remove('hidden');
	
  }

//MODALE IVA
 // Apri il modale


 // Chiudi il modale
 cancelBtn.addEventListener('click', () => {
   modal.classList.add('hidden');
 });

 // Se spunta "Non ho la P.IVA" disabilita input
 noPiva.addEventListener('change', () => {
   if(noPiva.checked) {
	     pivaInput.value = "";
	     pivaInput.placeholder = "Es. RSSMRA85M01H501Z";
	     pivaLabel.textContent="Codice Fiscale";
   } else {
	   	pivaInput.value = "";
	    pivaInput.placeholder = "Es. IT12345678901";
	    pivaLabel.textContent="Partita IVA";
   }
 });

 // Conferma → qui puoi gestire lato server il valore
 confirmBtn.addEventListener('click', () => {
   modal.classList.add('hidden');

 });
</script>
</html>