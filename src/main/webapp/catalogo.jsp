<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Italicious - Catalogo Prodotti Tipici Italiani</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
       
        body {
            
            background-color: #f9f5f0;
        }
        
        .title-font {
            font-family: 'Playfair Display', serif;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .product-card {
            transition: all 0.3s ease;
        }
        
        .region-filter.active {
            background-color: #e11d48;
            color: white;
        }
        
        .cart-preview {
            transition: all 0.3s ease;
            max-height: 0;
            overflow: hidden;
        }
        
        .cart-preview.open {
            max-height: 500px;
        }
        
        /* Animazione pulsante carrello */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .cart-pulse {
            animation: pulse 0.5s ease;
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
		
		@keyframes fadein {
		  from { opacity: 0; top: 0px; }
		  to { opacity: 1; top: 20px; }
		}
		@keyframes fadeout {
		  from { opacity: 1; top: 20px; }
		  to { opacity: 0; top: 0px; }
		}
    </style>
</head>
<body class="bg-gray-50">
<div id="notifica" class="nascosta"></div>
    <!-- Hero Section -->
    <section class="bg-gradient-to-r from-red-50 to-amber-50 py-12">
        <div class="container mx-auto px-4">
            <div class="max-w-3xl mx-auto text-center">
                <h1 class="text-4xl md:text-5xl title-font text-gray-800 mb-4">Scopri l'autentico gusto italiano</h1>
                <p class="text-lg text-gray-600 mb-8">Prodotti selezionati direttamente dalle migliori regioni d'Italia, consegnati a casa tua con amore e tradizione.</p>
                <div class="relative max-w-md mx-auto">
                    <input type="text" placeholder="Cerca prodotti..." class="w-full py-3 px-5 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent">
                    <button class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-red-600 text-white p-2 rounded-full hover:bg-red-700 transition">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="container mx-auto px-4 py-12">
        <!-- Filters -->
        <div class="mb-12">
            <h2 class="text-2xl title-font text-gray-800 mb-6">Filtra per categoria</h2>
            <div class="flex flex-wrap gap-3 mb-8">
                <button class="region-filter active px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="all">Tutti</button>
                <button class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="pasta">Pasta</button>
                <button class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="formaggi">Formaggi</button>
                <button class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="salumi">Salumi</button>
                <button class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="olio">Olio e Aceti</button>
                <button class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="dolci">Dolci</button>
                <button class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition" data-region="vini">Vini</button>
            </div>
            
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-2xl title-font text-gray-800">I nostri prodotti</h2>
                <div class="flex items-center">
                    <span class="text-gray-600 mr-2">Ordina per:</span>
                    <select class="border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500">
                        <option>Più popolari</option>
                        <option>Prezzo: dal più basso</option>
                        <option>Prezzo: dal più alto</option>
                        <option>Nome A-Z</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Product 1 -->
            <%
			    	System.out.println("\n==================== INIZIO DEBUG ====================\n");
			        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
			        System.out.println("PRODOTTI: "+prodotti);
			        if (prodotti != null && !prodotti.isEmpty()) {
			            for (Prodotto p : prodotti) {
   			%>
                 <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="<%= p.getImmagine() %>" alt="<%= p.getNome() %>" class="w-full h-48 object-cover" onclick="window.location.href='schedaprodotto?id=<%=p.getId()%>'">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2"><%= p.getNome() %></h3>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded"><%= p.getRegione() %></span>
                        </div>
                        <p class="text-gray-600 mb-4"><%= p.getDescrizione() %></p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">&euro;<%= p.getPrezzo() %></span>
                            <form class="aggiungiCarrello" method="post" action="<%= request.getContextPath() %>/carrello">
						    <input type="hidden" name="azione" value="aggiungi">
						    <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
						    <input type="hidden" name="quantita" value="1">
                            <button type="submit" class="form-aggiungi bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition">
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
	    %></div>
        
        
        <!-- Pagination -->
        <div class="mt-12 flex justify-center">
            <nav class="flex items-center space-x-2">
                <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">&laquo;</button>
                <button class="px-3 py-1 rounded bg-red-600 text-white">1</button>
                <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">2</button>
                <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">3</button>
                <button class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-100">&raquo;</button>
            </nav>
        </div>
    </main>

    <script>
    document.addEventListener("DOMContentLoaded", () => {
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

    	  // Nasconde nottifica dopo 3 secondi
    	  setTimeout(() => {
    	    notifica.style.display = "none";
    	  }, 3000);
    	}
    </script>
</body>
</html>