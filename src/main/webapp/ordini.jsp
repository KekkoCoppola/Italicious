<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Model.Ordine" %>
<%@ page import="java.util.List" %>
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
</head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.tailwindcss.com"></script>
<body class="min-h-screen">
<div class="max-w-none mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row block gap-8">
			<jsp:include page="parziali/sidebarProfilo.jsp" />
				<div class="flex-1 w-full bg-white rounded-lg shadow-sm overflow-hidden">
							<%
								List<Ordine> ordini = new OrdineDAO().findByUserWithRighe((Integer) session.getAttribute("userId"));
								if(ordini!=null && !ordini.isEmpty()){
							%>
			                <div class="grid grid-cols-12 bg-gray-100 p-4 font-medium text-gray-700">
							    <div class="col-span-2">ID Ordine</div>
							    <div class="col-span-2">Data</div>
							    <div class="col-span-2">Totale</div>
							    <div class="col-span-2">Stato</div>
							    <div class="col-span-2">Corriere</div>
							    <div class="col-span-2 text-right">Azioni</div>
							</div>
							
			                <!-- Order Item 1 -->
			                <%
			                		for(Ordine o : ordini){
			                	
			                %>
			                <div class="grid grid-cols-12 p-4 border-b border-gray-200 hover:bg-gray-50 transition">
							    <div class="col-span-2 font-medium">#<%=o.getId() %></div>
							    <div class="col-span-2 text-gray-600"><%= o.getDataOrdine().format(fmt) %></div>
							    <div class="col-span-2 font-medium">€ <%= Nfmt.format(o.getTotaleImponibile()) %></div>
							    <div class="col-span-2">
							        <span class="status-badge bg-green-100 text-green-800"><%=o.getStato() %></span>
							    </div>
							    <div class="col-span-2 text-gray-600"><%= o.getCorriere() != null ? o.getCorriere() : "-" %> (<%=o.getCodiceTracking() %>)</div>
							    <div class="col-span-2 flex justify-end space-x-2">
							        <button class="text-green-600 hover:text-green-800" aria-label="Scarica Fattura" title="Scarica Fattura">
							            <i class="fas fa-download"></i>
							        </button>
							    </div>
							</div>
			                <%
			                		}
			                	}else{
			                %>
			                <p>Nessun Ordine Registrato.</p>
			                <%
			                	}
			                %>
			            </div>
			           </div>
			          </div>
</body>
</html>