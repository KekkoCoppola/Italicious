<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it" class="h-full">
<head>
  <meta charset="UTF-8">
  <title>${pageTitle}</title>
  <link rel="icon" type="image/png" href="img/loghi/logo_top.png">
</head>

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

</body>
</html>
