<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="Model.UserService" %>
<%@ page import="Model.Recensione" %>
<%@ page import="Dao.RecensioneDAO" %>
<%@ page import="Dao.ListaPreferitiDAO" %>
<%@ page import="Dao.OrdineDAO" %>
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
		.review-card .star-rating{direction:rtl}
		.review-card .star-rating input[type="radio"]{display:none}
		.review-card .star-rating label{
			color:#e2e8f0;font-size:1.75rem;padding:0 3px;cursor:pointer;transition:all .2s ease
		}
		.review-card .star-rating label:hover,
		.review-card .star-rating label:hover ~ label,
		.review-card .star-rating input[type="radio"]:checked ~ label{color:#fbbf24}
		.review-card .error-message{color:#ef4444;font-size:.875rem;margin-top:.25rem;display:none}
		.review-card .char-counter{font-size:.75rem;color:#64748b;text-align:right}
    </style>
</head>
<body class="bg-gray-50 font-sans">
<div id="notifica" class="nascosta"></div>
    <div class="container mx-auto px-4 py-8 max-w-6xl">
    		<% 
    			Prodotto p = (Prodotto)request.getAttribute("prodotto");
    			ListaPreferitiDAO lf = new ListaPreferitiDAO();
    			boolean preferito = false;
    			if(session.getAttribute("userId")!=null)
    			 	preferito = lf.exists((Integer) session.getAttribute("userId"),p.getId());
    		%>
        <!-- Breadcrumb -->
        <nav class="flex mb-6" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a href="<%=request.getContextPath() %>/catalogo" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-green-600">
                        <i class="fas fa-arrow-left mr-2"></i>
                        Catalogo
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
                            <span class="bg-green-500 text-white text-xs font-semibold px-2.5 py-0.5 rounded-full"><%=p.getCategoria().toUpperCase() %></span>
                        </div>
                        <form action="<%=request.getContextPath() %>/lista_preferiti" method="post">
							    <input type="hidden" name="id_prodotto" value="<%=p.getId()%>">
                        		<button type="submit" class="absolute top-4 right-4 bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                            		<i class="<%= preferito ? "fas fa-heart text-red-600" : "far fa-heart text-grey-600"%>  text-xl" onclick="mostraNotifica('Prodotto <%= preferito ? "rimosso dai" : "aggiunto ai"%> preferiti!', '#38a169')"></i>
                       			</button>
                        </form>
                    </div>
                
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
                        	<%
                        		boolean esaurito = false;
                        		if(p.getDisponibilita()==0) esaurito=true;
                        		double media = RecensioneDAO.getMediaByProdotto(p.getId());
	                        	double m = Math.max(0, Math.min(5, media));
	                        	double mHalf = Math.round(m * 2.0) / 2.0;
	                        	int countRecensioni = RecensioneDAO.countRecensioniByProdotto(p.getId());
                            	List<Recensione> listaRecensioni = RecensioneDAO.getRecensioniByProdotto(p.getId());
	                        	
                        	%>
                              <% for (int i = 1; i <= 5; i++) {
							       String cls;
							       if (mHalf >= i) {
							         // stella piena
							         cls = "fas fa-star text-yellow-400";
							       } else if (mHalf >= i - 0.5) {
							         // mezza stella
							         cls = "fas fa-star-half-alt text-yellow-400";  
							         
							       } else {
							         // vuota
							         cls = "far fa-star text-gray-300";
							       } %>
							       <i class="<%= cls %>"></i>
							  <% } %>
                  
                            <span class="text-gray-600 ml-2"><%=media %> (<%=countRecensioni%> recensioni)</span>
                        </div>
                        <span class="mx-2 text-gray-300">|</span>
                        
                            
                            <%
                            	if(esaurito){
                            %>
                            <div class="flex items-center text-red-600">
                            <i class="fas fa-circle-xmark mr-1"></i>
                            <span>Esaurito</span>
                            <%
                            	}else{
                            %>
                            <div class="flex items-center text-green-600">
                            <i class="fas fa-check-circle mr-1"></i>
                            <span>Disponibile</span>
                            <%
                            	}
                            %>
                        </div>
                    </div>

                    <div class="mb-6">
                        <span class="text-3xl font-bold text-gray-900">&euro; <%=p.getPrezzoFormattato() %></span>
                        <span class="text-sm text-gray-500 ml-1">IVA inclusa (<%=p.getIva() %>%)</span>
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
                        <%	
                       
                        switch (p.getCategoria().toLowerCase()) {
                            case "bevande":
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-wine-bottle text-gray-500 mr-2"></i>
                                    <span>750ml</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-percent text-gray-500 mr-2"></i>
                                    <span>12% vol</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-leaf text-gray-500 mr-2"></i>
                                    <span>Biologico</span>
                                </div>
                    <%
                                break;
                            case "alimentari":
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-weight-hanging text-gray-500 mr-2"></i>
                                    <span>500g</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-gray-500 mr-2"></i>
                                    <span>Tempo cottura: 8 min</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-leaf text-gray-500 mr-2"></i>
                                    <span>Biologico</span>
                                </div>
                    <%
                                break;
                            case "dolci":
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-weight-hanging text-gray-500 mr-2"></i>
                                    <span>250g</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-certificate text-gray-500 mr-2"></i>
                                    <span>IGP</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-candy-cane text-gray-500 mr-2"></i>
                                    <span>Ingredienti tipici</span>
                                </div>
                    <%
                                break;
                            case "formaggi":
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-weight-hanging text-gray-500 mr-2"></i>
                                    <span>300g</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-gray-500 mr-2"></i>
                                    <span>Stagionatura: 12 mesi</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-certificate text-gray-500 mr-2"></i>
                                    <span>DOP</span>
                                </div>
                    <%
                                break;
                            case "salumi":
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-weight-hanging text-gray-500 mr-2"></i>
                                    <span>1kg</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-clock text-gray-500 mr-2"></i>
                                    <span>Stagionatura: 24 mesi</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-certificate text-gray-500 mr-2"></i>
                                    <span>IGP</span>
                                </div>
                    <%
                                break;
                            case "oli":
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-wine-bottle text-gray-500 mr-2"></i>
                                    <span>500ml</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-leaf text-gray-500 mr-2"></i>
                                    <span>Biologico</span>
                                </div>
                                <div class="flex items-center">
                                    <i class="fas fa-certificate text-gray-500 mr-2"></i>
                                    <span>DOP</span>
                                </div>
                    <%
                                break;
                            default:
                    %>
                                <div class="flex items-center">
                                    <i class="fas fa-box text-gray-500 mr-2"></i>
                                    <span>Caratteristiche non disponibili</span>
                                </div>
                    <%
                        }
                    %>

                        </div>
                    </div>

                    <div class="mb-6">
                    <form id="aggiungiAlCarrelloGrande" method="post" action="<%= request.getContextPath() %>/carrello">
                        <div class="flex items-center mb-4">
                        <%
                        	if(!esaurito){
                        %>
                            <button type=button data-step="-1" class="bg-gray-200 hover:bg-gray-300 rounded-l-lg p-2">
                                <i class="fas fa-minus"></i>
                            </button>
                              <input id="qty" name="quantita" type="number"
						         value="1" min="1" max="<%= p.getDisponibilita() %>"
						         class="w-16 text-center border-x border-gray-200 py-2 outline-none"
						         inputmode="numeric" readonly>
                            <button type=button data-step="1" class="bg-gray-200 hover:bg-gray-300 rounded-r-lg p-2">
                                <i class="fas fa-plus"></i>
                            </button>
                            <span class="ml-4 text-sm text-gray-500">Disponibili: <%=p.getDisponibilita() %></span>
                            	<%
                        	}
						%>
                        </div>
					
                        <div class="flex space-x-4">
                        	
						    <input type="hidden" name="azione" value="aggiungi">
						    <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
						    
                            <button class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-6 rounded-lg flex-1 flex items-center justify-center  disabled:bg-gray-400 disabled:cursor-not-allowed disabled:hover:bg-gray-400" <%= esaurito ? "disabled" : ""%>>
                                <i class="fas fa-shopping-cart mr-2"></i>
                                <%= esaurito ? "Esaurito" : "Aggiungi al carrello" %>
                            </button>
                            
                       
                        </div>
                        </form>
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

        <!-- RECENSIONI -->
        <div class="mt-8 bg-white rounded-xl shadow-lg overflow-hidden">
            <div class="border-b border-gray-200">
                <nav class="flex -mb-px">
                    
                    <button class="tab-button py-4 px-6 text-center border-b-2 font-medium text-sm border-transparent text-green-500 ">
                        <i class="fas fa-star mr-2"></i>Recensioni
                    </button>
                    
                </nav>
            </div>
            <div class="p-6">
				  <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
				    <%
				      if (listaRecensioni != null && !listaRecensioni.isEmpty()) {
				        for (Recensione r : listaRecensioni) {
				    %>
				      <div class="review-card bg-gray-50 p-6 rounded-lg shadow-md">
				        <div class="flex items-center mb-4">
				          <img class="h-10 w-10 rounded-full" src="https://ui-avatars.com/api/?name=<%=RecensioneDAO.getAutore(r.getIdUtente()) %>&background=E5E7EB&color=374151&size=64" alt="Avatar">
				          <div class="ml-3">
				            <p class="text-sm font-medium text-gray-900"><%= RecensioneDAO.getAutore(r.getIdUtente()) %></p>
				            <% int rating = Math.max(0, Math.min(5, r.getPunteggio())); %>
				            <div class="flex items-center" title="<%=rating%>/5">
				              <% for (int i = 1; i <= 5; i++) { %>
				                <i class="<%= (i <= rating) ? "fas fa-star text-yellow-400" : "far fa-star text-gray-300" %>"></i>
				              <% } %>
				            </div>
				          </div>
				        </div>
				        <p class="text-gray-600 italic"><%= r.getDescrizione() %></p>
				      </div>
				    <%
				        } // end for
				      } else {
				    %>
				      <p class="col-span-full text-gray-500">Nessuna recensione disponibile per questo prodotto.</p>
				    <%
				      } // end if
				    %>
				  </div>
				</div>

           
            
            <%	
            	if(session.getAttribute("email")!=null){
	            String mail = (String) session.getAttribute("email");
	    		int idUtente = UserService.getIdByMail(mail,(String) session.getAttribute("role"));
            	if(!RecensioneDAO.haGiaRecensito(idUtente, p.getId())){
            		if(session.getAttribute("userId")!=null)
            			if(OrdineDAO.haAcquistatoProdotto((Integer) session.getAttribute("userId"),p.getId())){
            	
            %>
            
            <div id="review-card-<%=p.getId()%>" class="review-card bg-white rounded-xl shadow-md p-6 md:p-8">
			  <div class="mb-6">
			    <h2 class="text-xl md:text-2xl font-bold text-gray-800 mb-1">Lascia una recensione</h2>
			    <p class="text-sm text-gray-600">
			      Prodotto: <span class="font-medium text-green-700"><%= p.getNome() %></span>
			    </p>
			  </div>
			
			  <form id="reviewForm-<%=p.getId()%>" class="space-y-6"
			        method="post" action="<%= request.getContextPath() %>/recensioni">
			    <input type="hidden" name="id_prodotto" value="<%= p.getId() %>">
			
			    <!-- Valutazione -->
			    <div>
			      <label class="block text-sm font-medium text-gray-700 mb-2">Valutazione</label>
			      <div class="star-rating flex justify-center" role="radiogroup" aria-label="Valutazione">
			        <input type="radio" id="r5-<%=p.getId()%>" name="punteggio" value="5" />
			        <label for="r5-<%=p.getId()%>" title="Eccellente">★</label>
			
			        <input type="radio" id="r4-<%=p.getId()%>" name="punteggio" value="4" />
			        <label for="r4-<%=p.getId()%>" title="Molto buono">★</label>
			
			        <input type="radio" id="r3-<%=p.getId()%>" name="punteggio" value="3" />
			        <label for="r3-<%=p.getId()%>" title="Buono">★</label>
			
			        <input type="radio" id="r2-<%=p.getId()%>" name="punteggio" value="2" />
			        <label for="r2-<%=p.getId()%>" title="Sufficiente">★</label>
			
			        <input type="radio" id="r1-<%=p.getId()%>" name="punteggio" value="1" />
			        <label for="r1-<%=p.getId()%>" title="Scarsa">★</label>
			      </div>
			      <div class="flex justify-between text-xs text-gray-500 mt-1">
			        <span>Scarsa</span><span>Eccellente</span>
			      </div>
			      <p class="error-message" data-error="rating">Seleziona una valutazione</p>
			    </div>
			
			    <!-- Testo recensione -->
			    <div>
			      <label for="rev-<%=p.getId()%>" class="block text-sm font-medium text-gray-700 mb-1">
			        La tua recensione*
			      </label>
			      <textarea id="rev-<%=p.getId()%>" name="descrizione" rows="5"
			                minlength="50" maxlength="1000"
			                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition"
			                placeholder="Condividi la tua esperienza con questo prodotto..." required></textarea>
			      <p class="error-message" data-error="content">La recensione deve contenere almeno 50 caratteri</p>
			      <div class="char-counter"><span data-counter>0</span>/1000 caratteri</div>
			    </div>
			
			    <!-- Azioni -->
			    <div class="flex flex-col sm:flex-row gap-3 pt-2">
			      <button type="submit" class="flex-1 px-6 py-3 bg-green-600 text-white font-medium rounded-lg
			                                  hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500
			                                  focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed transition"
			              disabled>
			        Invia recensione
			      </button>
			      <button type="reset" class="flex-1 px-6 py-3 border border-gray-300 text-gray-700 font-medium rounded-lg
			                                 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2">
			        Annulla
			      </button>
			    </div>
			  </form>
			</div>
			<%
            			}
            	}
            	}
			%>
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
			            	boolean esaurito2 = false;
			            	if(p2.getDisponibilita()==0) esaurito2=true;
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
						    <input type="hidden" name="quantita2" value="1">
                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition disabled:bg-gray-400 disabled:cursor-not-allowed disabled:hover:bg-gray-400" <%= esaurito2 ? "disabled" : ""%> >
                                <i class="<%= esaurito2 ? "fas fa-circle-xmark" : "fas fa-cart-plus"%> mr-2"></i><%= esaurito2 ? "Esaurito" : "Aggiungi" %>
                            </button>
                            </form>
                        </div>
                    </div>
                </div>
        <%
	           }
	        } else {
	    %>
	            <p>Nessun altro prodotto di questa regione disponibile.</p>
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

	
//+ e -
const qty = document.getElementById("qty");
  document.querySelectorAll("[data-step]").forEach(btn => {
    btn.addEventListener("click", () => {
      qty.stepUp(btn.dataset.step);
      const min = +qty.min || 1, max = +qty.max || 9999;
      if (qty.value < min) qty.value = min;
      if (qty.value > max) qty.value = max;
    });
  });

//CODICE RECENSIONI
function initReviewCard(root){
    const form = root.querySelector('form');
    const content = form.querySelector('textarea[name="descrizione"]');
    const counter = form.querySelector('[data-counter]');
    const ratingInputs = form.querySelectorAll('input[name="punteggio"]');
    const submitBtn = form.querySelector('button[type="submit"]');
    const errRating = root.querySelector('[data-error="rating"]');
    const errContent = root.querySelector('[data-error="content"]');

    const validateContent = () => {
      const ok = content.value.trim().length >= 50;
      errContent.style.display = ok ? 'none' : 'block';
      return ok;
    };
    const validateRating = () => {
      const ok = [...ratingInputs].some(i => i.checked);
      errRating.style.display = ok ? 'none' : 'block';
      return ok;
    };
    const validateForm = () => {
      const ok = validateContent() && validateRating();
      submitBtn.disabled = !ok;
      return ok;
    };

    content.addEventListener('input', () => {
      counter.textContent = content.value.length;
      validateForm();
    });
    ratingInputs.forEach(i => i.addEventListener('change', validateForm));
    form.addEventListener('reset', () => {
      setTimeout(() => {
        counter.textContent = '0';
        errRating.style.display = 'none';
        errContent.style.display = 'none';
        submitBtn.disabled = true;
      }, 0);
    });

    // Se vuoi inviarla in AJAX, aggiungi data-ajax="true" al form
    form.addEventListener('submit', (e) => {
      if (form.dataset.ajax === 'true') {
        e.preventDefault();
        if (!validateForm()) return;
        const body = new URLSearchParams(new FormData(form));
        fetch(form.action, { method: 'POST', body })
          .then(r => r.ok ? r.json() : Promise.reject(r))
          .then(_ => { form.reset(); /* mostra notifica qui */ })
          .catch(console.error);
      }
    });
  }

  // Call per questa istanza
  initReviewCard(document.getElementById('review-card-<%=p.getId()%>'));
</script>

</body>
</html>