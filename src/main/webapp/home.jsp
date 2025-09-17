<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Italicious - Prodotti Tipici Italiani</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/home.css">
</head>
<body class="bg-gray-50 font-sans">
<div id="notifica" class="nascosta"></div>


    <!-- Hero Section -->
    <section class="hero-section text-white py-16">
        <div class="container mx-auto px-4 text-center">
            <h1 class="text-4xl md:text-5xl font-bold mb-6">Scopri i Sapori d'Italia</h1>
            <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto">Autentici prodotti regionali direttamente dalla terra italiana alla tua tavola</p>
            <a href="/Italicious/catalogo" class="bg-white text-red-600 border-2 border-green-600 hover:bg-green-600 hover:text-white font-bold py-3 px-8 rounded-full text-lg transition transform hover:scale-105">
                Esplora il Catalogo
            </a>
        </div>
    </section>

    <!-- Prodotti in evidenza -->
    <section class="py-12 bg-gray-50">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12 text-gray-800">I Nostri Prodotti in Evidenza</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Prodotto 1 -->
                <%
			    	System.out.println("\n==================== INIZIO DEBUG ====================\n");
			        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodottiTop3");
			        System.out.println("PRODOTTI: "+prodotti);
			        if (prodotti != null && !prodotti.isEmpty()) {
			            for (Prodotto p2 : prodotti) {
			            	boolean esaurito = false;
                    		if(p2.getDisponibilita()==0) esaurito=true;
   			%>
                 <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="<%= p2.getImmagine() %>" alt="<%= p2.getNome() %>" class="w-full h-48 object-cover" onclick="window.location.href='schedaprodotto?id=<%=p2.getId()%>'">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2"><%= p2.getNome() %></h3>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded"><%= p2.getRegione() %></span>
                        </div>
                        <p class="text-gray-600 mb-4 min-h-[60px]"><%= p2.getDescrizione() %></p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">&euro;<%= p2.getPrezzoFormattato() %></span>
                            <form class="aggiungiCarrello" method="post" action="<%= request.getContextPath() %>/carrello">
						    <input type="hidden" name="azione" value="aggiungi">
						    <input type="hidden" name="idProdotto2" value="<%= p2.getId() %>">
						    <input type="hidden" name="quantita" value="1">
                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition disabled:bg-gray-400 disabled:cursor-not-allowed disabled:hover:bg-gray-400" <%= esaurito ? "disabled" : ""%> >
                                <i class="<%= esaurito ? "fas fa-circle-xmark" : "fas fa-cart-plus"%> mr-2"></i><%= esaurito ? "Esaurito" : "Aggiungi" %>
                            </button>
                            </form>
                        </div>
                    </div>
                </div>
        <%
	           }
	        } else {
	    %>
	            <p>Nessun prodotto disponibile.</p>
	    <%
	        }
	    %>
              
            </div>
            
            <div class="text-center mt-10">
                <a href="/Italicious/catalogo" class="bg-white text-green-600 border-2 border-green-600 hover:bg-green-600 hover:text-white font-bold py-3 px-8 rounded-full text-lg transition transform hover:scale-105">
                    Vedi Tutti i Prodotti
                </a>
            </div>
        </div>
    </section>

    <script>
        // Menu mobile toggle
        document.getElementById('mobile-menu-button').addEventListener('click', function() {
            const menu = document.getElementById('mobile-menu');
            menu.classList.toggle('hidden');
        });
        
        const forms = document.querySelectorAll(".aggiungiCarrello");

        forms.forEach(form => {
            form.addEventListener("submit", function(e) {
                e.preventDefault();
                const formData = new URLSearchParams(new FormData(form));
                const dati = Object.fromEntries(formData.entries());

                fetch(form.action, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "X-Requested-With": "XMLHttpRequest"
                    },
                    body: JSON.stringify(dati)
                })
                .then(res => {
    	                if (!res.ok) throw new Error("Errore server");
    	                return res.json();
    	            })
    	            .then(json => {
    	                mostraNotifica(json.messaggio || "Prodotto aggiunto al carrello ✅", "#16a34a");
    	                //console.log("CLICCATO TASTO GIU CON DATI: "+JSON.stringify(dati));
    	            })
                .catch(err => {
                    console.error(err);
                    mostraNotifica("Errore durante l'aggiunta al carrello ❌", "#dc2626");
                });
            });
        });
        function mostraNotifica(testo, colore = "#333") {
      	  const notifica = document.getElementById("notifica");
      	  notifica.style.backgroundColor = colore;
      	  notifica.innerText = testo;
      	  notifica.style.display = "block";
      	  setTimeout(() => {
      	    notifica.style.display = "none";
      	  }, 3000);
      	}
       
    </script>
</body>
</html>