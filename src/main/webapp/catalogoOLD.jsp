<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Catalogo Prodotti</title>
    <%
    String username = (String) session.getAttribute("username");
    if (username != null) {
%>
    <p>Benvenuto, <strong><%= username %></strong>!</p>
<%
    }
%>
<%
    String ruolo = (String) session.getAttribute("role");
    if ("admin".equals(ruolo)) {
%>
    <button onclick="location.href='admin'">Gestisci Prodotti</button>
<%
    }
%>
  <link rel="stylesheet" href="css/card_prodotto.css" />
</head>
<body>
    <h1>Catalogo Prodotti Tipici</h1>
<div class="catalogo">
    <%
    System.out.println("\n==================== INIZIO DEBUG ====================\n");
        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
        System.out.println("PRODOTTI: "+prodotti);
        if (prodotti != null && !prodotti.isEmpty()) {
            for (Prodotto p : prodotti) {
    %>
                <!-- From Uiverse.io by Praashoo7 --> 
                <div class="card">
				  <div class="wrapper">
				    <div class="card-image"><img src="<%= p.getImmagine() %>" height=150rem width=150rem/></div>
				    <div class="content">
				      <p class="title"><%= p.getNome() %></p>
				      <p class="title price">€<%= p.getPrezzo() %></p>
				      <!--  <p class="title price old-price">&nbsp;<%= p.getPrezzo() %></p>-->
				      <p></p>
				    </div>
				    <button class="card-btn">Aggiungi al carrello</button>
				  </div>
				  <p class="tag">-50%</p>
				</div>
		<!--<div class="main">
		<div class="card">
		  <div class="heading"><%= p.getNome() %></div>
		  <div class="details"><%= p.getDescrizione() %></div>
		  <div class="price"><%= p.getPrezzo() %></div>
		  <button class="btn1">Compra</button>
		  <button class="btn2">Aggiungi al carrello</button>
		</div>
		
		<svg class="glasses" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="100px" height="100px" viewBox="0 0 100 100" xml:space="preserve">  <image id="image0" width="100" height="100" x="0" y="0" href="<%= p.getImmagine() %>"></image>
		</svg>
		</div>
                <div style="border:1px solid #ccc; padding:10px; margin:10px;">
                    <h3><%= p.getNome() %></h3>
                    <p><%= p.getDescrizione() %></p>
                    <p>Prezzo: €<%= p.getPrezzo() %> + IVA: <%= p.getIva() %>%</p>
                    <img src="<%= p.getImmagine() %>" alt="immagine prodotto" width="150"/><br/>
                    <form action="addToCart" method="post">
                        <input type="hidden" name="idProdotto" value="<%= p.getId() %>" />
                        <button type="submit">Aggiungi al carrello</button>
                    </form>
                </div>-->
    <%
            }
        } else {
    %>
            <p>Nessun prodotto disponibile.</p>
    <%
        }
    %></div>
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
    

</body>
</html>
