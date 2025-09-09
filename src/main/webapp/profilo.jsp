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
    <div class="container mx-auto px-4 py-8">
        <div class="flex flex-col md:flex-row gap-8">
            <!-- Sidebar -->
            <jsp:include page="parziali/sidebarProfilo.jsp" />
            <!-- Main Content -->
            <div class="w-full md:w-3/4 lg:w-4/5">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h1 class="title text-2xl font-bold mb-6">Il tuo profilo</h1>
                    
                    <form method=POST action="<%=request.getContextPath() %>/profilo">
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
                                <input type="tel" id="telefono" name="telefono" value="+39 <%=u.getTelefono() %>" class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
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
                
                <div class="bg-white rounded-lg shadow-md p-6 mt-6">
                    <h2 class="title text-xl font-bold mb-4">Sicurezza</h2>
                    <div class="space-y-4">
                        <div class="flex justify-between items-center border-b pb-4">
                            <div>
                                <h3 class="font-medium">Password</h3>
                                <p class="text-sm text-gray-500">Ultima modifica: 3 mesi fa</p>
                            </div>
                            <button class="btn-primary px-4 py-1 text-sm rounded-lg">
                                Cambia
                            </button>
                        </div>
                        <div class="flex justify-between items-center">
                            <div>
                                <h3 class="font-medium">Autenticazione a due fattori</h3>
                                <p class="text-sm text-gray-500">Aumenta la sicurezza del tuo account</p>
                            </div>
                            <button class="px-4 py-1 text-sm border rounded-lg hover:bg-gray-50">
                                Attiva
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Feather icons replacement
        document.addEventListener('DOMContentLoaded', function() {
            feather.replace();
        });
    </script>
</body>
</html>