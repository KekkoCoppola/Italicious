<%@ page import="Model.UserService" %>
<%@ page import="Model.Utente" %>
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
	Utente u = UserService.getUserById((int) session.getAttribute("userId"), (String) session.getAttribute("role"));
%>
<body class="min-h-screen">
<%
String notifica = (String) request.getAttribute("notifica");
String colore = (String) request.getAttribute("coloreNotifica");
if (notifica != null && colore!=null) {
%>
<script>
  window.addEventListener("DOMContentLoaded", () => {
    mostraNotifica("<%= notifica %>", "<%= colore %>");
  });
</script>
<%
}
%>
    <div class="container mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row gap-8">
            <!-- Sidebar -->
            <jsp:include page="parziali/sidebarProfilo.jsp" />
            <!-- Main Content -->
            <div class="w-full md:w-3/4 lg:w-4/5">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h1 class="title text-2xl font-bold mb-6">Il tuo profilo</h1>
                    
                    <form id=formProfilo method=POST action="<%=request.getContextPath() %>/profilo">
                    <input type=Hidden value = "<%=session.getAttribute("userId")%>" name=id>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                            <div>
                                <label class="block text-gray-700 text-sm font-medium mb-2" for="name">Nome</label>
                                <input type="text" id="nome" name="nome" value="<%=u.getNome() %>" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
                            </div>
                         
                            <div>
                                <label class="block text-gray-700 text-sm font-medium mb-2" for="email">Email</label>
                                <input type="email" id="mail" name="mail" value="<%=u.getMail() %>" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
                            </div>
                            <div>
                                <label class="block text-gray-700 text-sm font-medium mb-2" for="phone">Telefono</label>
                                <input type="tel" id="telefono" name="telefono" value="<%= (u.getTelefono() != null ? u.getTelefono() : "") %>" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
                            </div>
                            <div>
                                <label class="block text-gray-700 text-sm font-medium mb-2" for="indirizzo">Indirizzo</label>
                                <input id="indirizzo" name="indirizzo" value="<%= (u.getIndirizzo() != null ? u.getIndirizzo() : "") %>" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
                            </div>
                            <div>
                                <label class="block text-gray-700 text-sm font-medium mb-2" for="fatturazione">Partita IVA o Codice Fiscale</label>
                                <input id="fatturazione" name="fatturazione" value="<%= (u.getFatturazione() != null ? u.getFatturazione() : "") %>" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
                            </div>
                        </div>
                          
                        
                        <div class="flex justify-end space-x-4">
                            <button type="button" class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition">
                                Annulla
                            </button>
                            <button type="submit" class="btn-primary px-6 py-2 rounded-lg font-medium transition">
                                Salva modifiche
                            </button>
                        </div>
                    </form>
                </div>
                

            </div>
        </div>
    </div>
    
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("formProfilo");

        form.addEventListener("submit", function (e) {
            let valid = true;
            let messages = [];

            // Nome obbligatorio
            const nome = document.getElementById("nome").value.trim();
            if (nome.length < 2) {
                valid = false;
                messages.push("Il nome deve contenere almeno 2 caratteri.");
            }

            // Email obbligatoria e valida
            const mail = document.getElementById("mail").value.trim();
            const mailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!mailRegex.test(mail)) {
                valid = false;
                messages.push("Inserisci un'email valida.");
            }

            // Telefono (opzionale ma numerico)
            const telefono = document.getElementById("telefono").value.trim();
            if (telefono !== "" && !/^\d{7,15}$/.test(telefono)) {
                valid = false;
                messages.push("Il numero di telefono deve contenere solo cifre (7-15 cifre).");
            }

            // Partita IVA o Codice Fiscale (opzionale ma valido)
            const fatturazione = document.getElementById("fatturazione").value.trim();
            if (fatturazione !== "") {
                const cfRegex = /^[A-Z0-9]{16}$/i; // Codice fiscale
                const pivaRegex = /^\d{11}$/; // Partita IVA
                if (!cfRegex.test(fatturazione) && !pivaRegex.test(fatturazione)) {
                    valid = false;
                    messages.push("Inserisci un codice fiscale (16 caratteri) o una partita IVA (11 cifre) valida.");
                }
            }

            // Mostra errori se presenti
            if (!valid) {
                e.preventDefault();
                alert(messages.join("\n"));
            }
        });
    });


        // replace delle icone feather
        document.addEventListener('DOMContentLoaded', function() {
            feather.replace();
        });
    </script>
</body>
</html>