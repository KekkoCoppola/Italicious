<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.Ordine" %>
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

  <% List<Ordine> ordini = OrdineDAO.findAllWithRighe();
     if (ordini != null && !ordini.isEmpty()) { %>

  <!-- Header: solo desktop/tablet -->
  <div class="hidden md:grid grid-cols-10 bg-gray-100 p-4 font-medium text-gray-700">
    <div class="col-span-2">ID Ordine</div>
    <div class="col-span-2">Data</div>
    <div class="col-span-2">Totale</div>
    <div class="col-span-2">Stato</div>
    <div class="col-span-2">Utente</div>
  </div>

  <% for (Ordine o : ordini) { 
  	Utente u = UserService.getUserById(o.getIdUtente(),"user");
  %>
  <!-- Riga: card su mobile, tabella da md -->
  <div class="grid grid-cols-1 gap-2 md:grid-cols-10 p-4 border-b border-gray-200 hover:bg-gray-50 transition">
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

<form action="gestione_ordini" method="post" class=contents>
  <input type="hidden" name="idOrdine" value="<%= o.getId() %>">

  <div class="md:col-span-2">
    <span class="md:hidden block text-xs text-gray-500">Stato</span>
    <select name="stato" class="border rounded px-2 py-1 text-sm"
            onchange="this.form.submit()">
      <option value="in elaborazione" <%= "in elaborazione".equalsIgnoreCase(o.getStato().getValue()) ? "selected" : "" %>>in elaborazione</option>
      <option value="spedito" <%= "spedito".equalsIgnoreCase(o.getStato().getValue()) ? "selected" : "" %>>spedito</option>
      <option value="consegnato" <%= "consegnato".equalsIgnoreCase(o.getStato().getValue()) ? "selected" : "" %>>consegnato</option>
      <option value="annullato" <%= "annullato".equalsIgnoreCase(o.getStato().getValue()) ? "selected" : "" %>>annullato</option>
    </select>
  </div>
  
</form>
<div class="md:col-span-2">
      <span class="md:hidden block text-xs text-gray-500">Utente</span>
      <span class="text-gray-600 break-all md:truncate">
        <%= u.getNome() != null ? u.getNome() : "-" %> 
      </span>
    </div>
  </div>
  <% } %>

  <% } else { %>
    <p class="p-6">Nessun Ordine Registrato.</p>
  <% } %>
</div>

			           </div>
			          </div>
			          
</body>
</html>