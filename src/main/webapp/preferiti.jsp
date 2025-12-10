<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .btn-primary {
            background-color: #38a169;
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #2f855a;
        }
    </style>
</head>
<%
	List<Prodotto> preferiti = (List<Prodotto>) request.getAttribute("preferiti");
%>
<body class="min-h-screen">
    <div class="container mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row gap-8">
            <!-- Sidebar -->
            <jsp:include page="parziali/sidebarProfilo.jsp" />
            <!-- Main Content -->
            <div class="flex-1 min-w-0 grid grid-cols-1 md:grid-cols-3 gap-8">
                <%
                if (preferiti != null && !preferiti.isEmpty()) {
		            for (Prodotto p : preferiti) {
		            	boolean esaurito = false;
                		if(p.getDisponibilita()==0) esaurito=true;
                %>
                <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="<%= p.getImmagine() %>" alt="<%= p.getNome() %>" class="w-full h-48 object-cover" onclick="window.location.href='schedaprodotto?id=<%=p.getId()%>'">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2"><%= p.getNome() %></h3>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded"><%= p.getRegione() %></span>
                        </div>
                        <p class="text-gray-600 mb-4 min-h-[60px]"><%= p.getDescrizione() %></p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">&euro;<%= p.getPrezzoFormattato() %></span>
                            <form class="aggiungiCarrello" method="post" action="<%= request.getContextPath() %>/carrello">
						    <input type="hidden" name="azione" value="aggiungi">
						    <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
						    <input type="hidden" name="quantita" value="1">
                            <button type="submit" class="form-aggiungi bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition disabled:bg-gray-400 disabled:cursor-not-allowed disabled:hover:bg-gray-400" <%= esaurito ? "disabled" : ""%>>
                                <i class="<%= esaurito ? "fas fa-circle-xmark" : "fas fa-cart-plus"%> mr-2"></i><%= esaurito ? "Esaurito" : "Aggiungi"%>
                            </button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
		            }
                }else{
                %>     <p>la tua lista preferiti è vuota.</p>
			    <%
			        }
			    %>

            </div>
        </div>
    </div>
    
    <script>
        // replace delle icone feather
        document.addEventListener('DOMContentLoaded', function() {
            feather.replace();
        });
    </script>
</body>
</html>