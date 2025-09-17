<%@ page import="Model.UserService" %>
<%@ page import="Model.Utente" %>
<%
	Utente u = UserService.getUserById((int) session.getAttribute("userId"),(String) session.getAttribute("role"));
	String current = (String) request.getAttribute("paginaCorrente");
%>
<style>
	.sidebar-item.active {
            background-color: #38a169;
            color: white;
        }
        
        .sidebar-item:hover:not(.active) {
            background-color: #e2e8f0;
        }
        body {
            background-color: #f8f9fa;
        }
</style>

<div class="w-full md:w-1/4 lg:w-1/5">
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="p-6 text-center border-b">
                        <div class="w-24 h-24 mx-auto rounded-full overflow-hidden border-4 border-green-100 mb-4">
                            <img src="https://ui-avatars.com/api/?name=<%=u.getNome() %>&background=E5E7EB&color=374151&size=64" alt="Profile" class="w-full h-full object-cover">
                        </div>
                        <h2 class="title text-xl font-bold"><%=u.getNome() %></h2>
                        <%
                        	if(session.getAttribute("role").equals("admin")){
                        %>
                        	<p class="text-gray-500 text-sm">Amministratore</p>
                        <%
                        	}
                        %>
                    </div>
                    
                    <nav class="py-2">
                        <a href="<%=request.getContextPath() %>/profilo" class="sidebar-item block px-6 py-3 text-sm font-medium <%= current.equals("profilo") ? "active" : ""%>">
                            <i class="fas fa-user mr-2"></i> Profilo 
                        </a>
                        <a href="<%=request.getContextPath() %>/ordini" class="sidebar-item block px-6 py-3 text-sm font-medium <%= current.equals("ordini") ? "active" : ""%>">
                            <i class="fas fa-shopping-bag mr-2"></i> Ordini
                        </a>
                        <a href="<%=request.getContextPath() %>/lista_preferiti" class="sidebar-item block px-6 py-3 text-sm font-medium <%= current.equals("lista_preferiti") ? "active" : ""%>">
                            <i class="fas fa-heart mr-2"></i> Lista preferiti
                        </a>
                        <%
                        	if(session.getAttribute("role").equals("admin")){
                        %>
                        <a href="<%=request.getContextPath() %>/admin" class="sidebar-item block px-6 py-3 text-sm font-medium <%= current.equals("admin") ? "active" : ""%>">
                            <i class="fas fa-wine-bottle mr-2"></i> Gestione Prodotti
                        </a>
                        <a href="<%=request.getContextPath() %>/gestione_ordini" class="sidebar-item block px-6 py-3 text-sm font-medium <%= current.equals("gestione_ordini") ? "active" : ""%>">
                            <i class="fas fa-boxes-stacked mr-2"></i> Gestione Ordini
                        </a>
                        <%
                        	}
                        %>
                    </nav>
                </div>
            </div>
            