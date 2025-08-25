<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prodotti Tipici Italiani - Dettaglio Prodotto</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-gallery {
            scroll-snap-type: x mandatory;
        }
        .product-gallery img {
            scroll-snap-align: start;
        }
        .flag-italy {
            background: linear-gradient(to right, #009246 33%, #FFFFFF 33%, #FFFFFF 66%, #CE2B37 66%);
        }
        .heart-animation {
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        .origin-map {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 60" fill="none" stroke="%23e5e7eb"><path d="M50,5 C60,15 70,10 80,15 C90,20 95,30 80,40 C65,50 60,45 50,55 C40,45 35,50 20,40 C5,30 10,20 20,15 C30,10 40,15 50,5 Z"/></svg>');
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
        }
        #notifica {
		  position: fixed;
		  top: 20px;
		  right: 20px;
		  background-color: #333;
		  color: #fff;
		  padding: 12px 20px;
		  border-radius: 8px;
		  box-shadow: 0 2px 10px rgba(0,0,0,0.3);
		  font-family: sans-serif;
		  display: none;
		  z-index: 9999;
		  animation: fadein 0.5s, fadeout 0.5s 2.5s;
		}
		
    </style>
</head>
<body class="bg-gray-50 font-sans">
<div id="notifica" class="nascosta"></div>
    <div class="container mx-auto px-4 py-8 max-w-6xl">
    		<% Prodotto p = (Prodotto)request.getAttribute("prodotto"); %>
        <!-- Breadcrumb -->
        <nav class="flex mb-6" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a href="/Italicious/catalogo" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-green-600">
                        <i class="fas fa-arrow-left mr-2"></i>
                        Indietro
                    </a>
                </li>
                
            </ol>
        </nav>

        <div class="bg-white rounded-xl shadow-lg overflow-hidden">
            <div class="md:flex">
                <!-- IMMAGINE -->
                <div class="md:w-1/2 p-0">
                    <div class="relative mb-4">
                        <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1 ">
                            <img src="<%=p.getImmagine() %>"  
                                 alt="Aceto Balsamico di Modena" 
                                 class="w-full h-auto object-cover rounded-lg flex-shrink-0">
                            <!-- <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                 alt="Aceto Balsamico di Modena - confezione" 
                                 class="w-full h-80 object-cover rounded-lg flex-shrink-0">
                            <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                 alt="Aceto Balsamico di Modena - produzione" 
                                 class="w-full h-80 object-cover rounded-lg flex-shrink-0"> -->
                        </div>
                        <div class="absolute top-4 left-4">
                            <span class="bg-green-500 text-white text-xs font-semibold px-2.5 py-0.5 rounded-full">DOP</span>
                        </div>
                        <form action="lista-preferiti" method="post">
							    <input type="hidden" name="action" value="add">
							    <input type="hidden" name="id_prodotto" value="42">
                        		<button type="submit" class="absolute top-4 right-4 bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                            		<i class="far fa-heart text-gray-600 text-xl"></i>
                       			</button>
                        </form>
                    </div>
                    <!--  <div class="grid grid-cols-4 gap-2">
                        <img src="<%=p.getImmagine() %>" 
                             alt="Thumbnail 1" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-green-400">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 2" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-green-400">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 3" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-green-400">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 4" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-green-400">
                    </div>-->
                </div>
		
                <!-- INFO PRODOTTO -->
                <div class="md:w-1/2 p-6">
                    <div class="mb-4">
                        <div class="flex items-center justify-between">
                            <h1 class="text-3xl font-bold text-gray-900"><%= p.getNome() %></h1>
                            <div class="flag-italy w-8 h-6 rounded-sm"></div>
                        </div>
                        <p class="text-gray-500 mt-1"><%=p.getRegione() %></p>
                    </div>

                    <div class="flex items-center mb-4">
                        <div class="flex items-center">
                            <i class="fas fa-star text-green-400"></i>
                            <i class="fas fa-star text-green-400"></i>
                            <i class="fas fa-star text-green-400"></i>
                            <i class="fas fa-star text-green-400"></i>
                            <i class="fas fa-star-half-alt text-green-400"></i>
                            <span class="text-gray-600 ml-2">4.7 (128 recensioni)</span>
                        </div>
                        <span class="mx-2 text-gray-300">|</span>
                        <div class="flex items-center text-green-600">
                            <i class="fas fa-check-circle mr-1"></i>
                            <span>Disponibile</span>
                        </div>
                    </div>

                    <div class="mb-6">
                        <span class="text-3xl font-bold text-gray-900">&euro;<%=p.getPrezzo() %></span>
                        <span class="text-sm text-gray-500 ml-1">IVA esclusa (<%=p.getIva() %>%)</span>
                    </div>

                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-2">Descrizione</h3>
                        <p class="text-gray-700"><%=p.getDescrizione() %></p>
                    </div>

                    <div class="mb-6">
                        
                    </div>

                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-2">Caratteristiche</h3>
                        <div class="grid grid-cols-2 gap-2">
                            <div class="flex items-center">
                                <i class="fas fa-wine-bottle text-gray-500 mr-2"></i>
                                <span>250ml</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-leaf text-gray-500 mr-2"></i>
                                <span>Biologico</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-clock text-gray-500 mr-2"></i>
                                <span>12 anni</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-certificate text-gray-500 mr-2"></i>
                                <span>DOP</span>
                            </div>
                        </div>
                    </div>

                    <div class="mb-6">
                        <div class="flex items-center mb-4">
                            <button class="bg-gray-200 hover:bg-gray-300 rounded-l-lg p-2">
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="number" value="1" min="1" class="w-16 text-center border-t border-b border-gray-200 py-2">
                            <button class="bg-gray-200 hover:bg-gray-300 rounded-r-lg p-2">
                                <i class="fas fa-plus"></i>
                            </button>
                            <span class="ml-4 text-sm text-gray-500">Disponibili: <%=p.getDisponibilita() %></span>
                        </div>

                        <div class="flex space-x-4">
                        	<form id="aggiungiAlCarrelloGrande" method="post" action="<%= request.getContextPath() %>/carrello">
						    <input type="hidden" name="azione" value="aggiungi">
						    <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
						    <input type="hidden" name="quantita" value="1">
                            <button class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg flex-1 flex items-center justify-center">
                                <i class="fas fa-shopping-cart mr-2"></i>
                                Aggiungi al carrello
                            </button>
                            </form>
                       
                        </div>
                    </div>

                    <div class="border-t border-gray-200 pt-4">
                        <div class="flex items-center text-sm text-gray-600">
                            <i class="fas fa-truck mr-2"></i>
                            <span>Spedizione gratuita per ordini superiori a &euro;50</span>
                        </div>
                        <div class="flex items-center text-sm text-gray-600 mt-2">
                            <i class="fas fa-undo mr-2"></i>
                            <span>Reso gratuito entro 30 giorni</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Tabs -->
        <div class="mt-8 bg-white rounded-xl shadow-lg overflow-hidden">
            <div class="border-b border-gray-200">
                <nav class="flex -mb-px">
                    
                    <button class="tab-button py-4 px-6 text-center border-b-2 font-medium text-sm border-transparent text-green-500 hover:text-green-700 hover:border-green-300">
                        <i class="fas fa-star mr-2"></i>Recensioni
                    </button>
                    
                </nav>
            </div>
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Recensione 1 -->
                <div class="review-card bg-gray-50 p-6 rounded-lg shadow-md">
                    <div class="flex items-center mb-4">
                        <div class="flex-shrink-0">
                            <img class="h-10 w-10 rounded-full" src="https://randomuser.me/api/portraits/women/32.jpg" alt="Maria Rossi">
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900">Maria Rossi</p>
                            <div class="flex">
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                            </div>
                        </div>
                    </div>
                    <p class="text-gray-600 italic">"Ho ricevuto il pacco con i prodotti della Toscana e sono rimasta stupita dalla qualità. L'olio EVO ha un profumo incredibile e il pecorino è perfetto. Consiglio Italicious a tutti gli amanti della vera cucina italiana!"</p>
                </div>
                </div>
            </div>
        </div>

        <!-- Related Products -->
        <div class="mt-12">
            <h2 class="text-2xl font-bold mb-6">Altri prodotti della regione <%=p.getRegione() %></h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                
			
			<%
			    	System.out.println("\n==================== INIZIO DEBUG ====================\n");
			        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodottiByRegione");
			        System.out.println("PRODOTTI: "+prodotti);
			        if (prodotti != null && !prodotti.isEmpty()) {
			            for (Prodotto p2 : prodotti) {
   			%>
                 <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="<%= p2.getImmagine() %>" alt="<%= p2.getNome() %>" class="w-full h-48 object-cover" onclick="window.location.href='schedaprodotto?id=<%=p2.getId()%>'">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2"><%= p2.getNome() %></h3>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded"><%= p2.getRegione() %></span>
                        </div>
                        <p class="text-gray-600 mb-4"><%= p2.getDescrizione() %></p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">&euro;<%= p2.getPrezzo() %></span>
                            <form class="aggiungiCarrello" method="post" action="<%= request.getContextPath() %>/carrello">
						    <input type="hidden" name="azione" value="aggiungi">
						    <input type="hidden" name="idProdotto2" value="<%= p2.getId() %>">
						    <input type="hidden" name="quantita" value="1">
                            <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition">
                                <i class="fas fa-cart-plus mr-2"></i>Aggiungi
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
        </div>
    </div>
<script>
document.addEventListener("DOMContentLoaded", () => {
	const formGrande = document.getElementById("aggiungiAlCarrelloGrande");
	
	formGrande.addEventListener("submit",function(e) {
		e.preventDefault();
	    const formData = new URLSearchParams(new FormData(formGrande));
	    const dati = Object.fromEntries(formData.entries());
		
		fetch(formGrande.action, {
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
		    	//console.log("CLICCATO TASTO SU");
		        mostraNotifica(json.messaggio || "Prodotto aggiunto al carrello ✅", "#16a34a");
		    })
		.catch(err => {
		    console.error(err);
		    mostraNotifica("Errore durante l'aggiunta al carrello ❌", "#dc2626");
		});
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