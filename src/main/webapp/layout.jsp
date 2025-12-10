<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it" class="h-full">
<head>
  <meta charset="UTF-8">
  <title>${pageTitle}</title>
  <link rel="icon" type="image/png" href="img/loghi/logo_top.png">
</head>
<style>
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
<body class="min-h-screen flex flex-col">

  <jsp:include page="parziali/navbar.jsp" />

  <!-- main  -->
  <main class="flex-1">
    <div class="container mx-auto px-4 py-6">
      <jsp:include page="${contentPage}" />
    </div>
  </main>

  <!--  footer  -->
  <footer class="mt-auto">
    <jsp:include page="parziali/footer.jsp" />
  </footer>
	<div id="notifica" class="nascosta"></div> <!-- banner di solito nascosto, si attiva richiamndo la funzione di script -->
</body>

<!--  script -->
<script>
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
</html>
