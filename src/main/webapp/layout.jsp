<!-- layout.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link href="/css/styles.css" rel="stylesheet" />
</head>
<body>

<jsp:include page="parziali/navbar.jsp" />

<div class="container mx-auto px-4 py-6">
   <jsp:include page="${contentPage}" />


</div>

<jsp:include page="parziali/footer.jsp" />

</body>
</html>
