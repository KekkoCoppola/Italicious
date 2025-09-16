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
	<link rel="stylesheet" href="css/catalogo.css">
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
        <input id="searchBox" type="text" placeholder="Cerca prodotti..."
               autocomplete=off  class="w-full py-3 px-5 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent">
     
          <i class="fas fa-search absolute right-1 top-1/2 -translate-y-1/2 text-red-600"></i>

        <!-- Dropdown suggerimenti -->
        <div id="sugg" class="absolute z-[9999] mt-2 w-full bg-white border border-gray-200 rounded-xl shadow-lg hidden"></div>
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
                <%
					String cat = request.getParameter("cat") != null ? request.getParameter("cat") : "all";
				%>
				
				<form class="flex flex-wrap gap-3 mb-8"
				      method="get" action="<%=request.getContextPath()%>/catalogo">
				  <button type="submit" name="cat" value="tutti"
				          class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "tutti".equals(cat) ? "bg-red-600 text-white" : "" %>">
				    Tutti
				  </button>
				
				  <button type="submit" name="cat" value="pasta"
				          class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "pasta".equals(cat) ? "bg-red-600 text-white" : "" %>">
				    Pasta
				  </button>
				
				  <button type="submit" name="cat" value="formaggi"
				          class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "formaggi".equals(cat) ? "bg-red-600 text-white" : "" %>">
				    Formaggi
				  </button>
				
				  <button type="submit" name="cat" value="salumi"  class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "salumi".equals(cat) ? "bg-red-600 text-white" : "" %>">Salumi</button>
				  <button type="submit" name="cat" value="bevande" class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "bevande".equals(cat) ? "bg-red-600 text-white" : "" %>">Bevande</button>
				  <button type="submit" name="cat" value="dolci"   class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "dolci".equals(cat) ? "bg-red-600 text-white" : "" %>">Dolci</button>
				  <button type="submit" name="cat" value="oli"     class="region-filter px-4 py-2 rounded-full border border-gray-300 hover:bg-red-50 transition <%= "oli".equals(cat) ? "bg-red-600 text-white" : "" %>">Oli e Aceti</button>
				</form>
            </div>
            
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-2xl title-font text-gray-800">I nostri prodotti</h2>
                <div class="flex items-center">
                    <!--  <span class="text-gray-600 mr-2">Ordina per:</span>
                    <select class="border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-red-500">
                        <option>Più popolari</option>
                        <option>Prezzo: dal più basso</option>
                        <option>Prezzo: dal più alto</option>
                        <option>Nome A-Z</option>
                    </select>-->
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
    //RICERCA DROPDOWN
	document.addEventListener('DOMContentLoaded', () => {
  const box  = document.getElementById('searchBox');
  const menu = document.getElementById('sugg');
  let t;

  function show(list){
    if (!list || !list.length) {
      menu.innerHTML = '';
      menu.classList.add('hidden');
      return;
    }
    var placeholder = '<%=request.getContextPath()%>/img/placeholder.png';
    var html = '';
    for (var i=0; i<list.length; i++){
      var p = list[i];
      var img = (p.img && p.img.length) ? p.img : placeholder;
      var regione = (p.regione && p.regione.length) ? p.regione : 'Italia';
      html += '<div class="sitem" data-id="' + p.id + '">'
           +    '<img class="simg" src="' + img + '" alt="">'
           +    '<div style="display:flex; flex-direction:column; align-items:flex-start; gap:.15rem;">'
           +      '<div class="sname">' + escapeHtml(p.nome) + '</div>'
           +      '<span class="sbadge">' + escapeHtml(regione) + '</span>'
           +    '</div>'
           +  '</div>';
    }
    menu.innerHTML = html;
    menu.classList.remove('hidden');
  }

  function escapeHtml(s){
    if (s == null) return '';
    return String(s).replace(/[&<>"']/g, function(m){ return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m]); });
  }

  box.addEventListener('input', () => {
    const q = box.value.trim();
    clearTimeout(t);
    if (q.length < 1) { show([]); return; }

    t = setTimeout(async () => {
      const cat = new URLSearchParams(window.location.search).get('categoria') || '';
      const url = '<%=request.getContextPath()%>/catalogo?suggest=1&q='
                + encodeURIComponent(q)
                + '&categoria=' + encodeURIComponent(cat)
                + '&limit=8';

      console.log('URL chiamato:', url);
      try {
        const res = await fetch(url, { headers: { 'Accept': 'application/json' } });
        if (!res.ok) { show([]); return; }
        const data = await res.json();
        console.log('Risposta JSON:', data);
        show(data);
      } catch (e) {
        console.error(e);
        show([]);
      }
    }, 180);
  });

  menu.addEventListener('mousedown', e => {
    const el = e.target.closest('.sitem');
    if (!el) return;
    window.location.href = '<%=request.getContextPath()%>/schedaprodotto?id=' + el.dataset.id;
  });

  document.addEventListener('click', (e) => {
    if (!menu.contains(e.target) && e.target !== box) menu.classList.add('hidden');
  });
});    </script>
</body>
</html>