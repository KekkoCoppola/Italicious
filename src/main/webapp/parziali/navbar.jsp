<%@ page import="Model.UserService" %>
<%@ page import="Model.Utente" %>
<style>
    .flag-stripe {
        height: 8px;
    }
    .flag-stripe.green {
        background-color: #008C45;
    }
    .flag-stripe.white {
        background-color: #F4F5F0;
    }
    .flag-stripe.red {
        background-color: #CD212A;
    }

    .profile-container {
        position: relative;
        display: inline-block;
    }

    .profile-link {
        cursor: pointer;
        color: #2d3748;
        transition: color 0.3s ease;
        font-size: 1.25rem;
    }
    .profile-link:hover {
        color: #38a169;
    }

    .popup-menu {
        display: none;
        position: absolute;
        top: 100%;
        right: 0;
        background-color: white;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        min-width: 160px;
        z-index: 1000;
    }

    .popup-menu.show {
        display: block;
    }

    .popup-menu a {
        display: block;
        padding: 10px 15px;
        color: #2d3748;
        text-decoration: none;
        font-weight: 500;
    }
    .popup-menu a:hover {
        background-color: #e6fffa;
        color: #38a169;
    }
</style>

<%

    String ruolo = (String) session.getAttribute("role");
	boolean isLoggedIn = ruolo != null;
	Utente u = new Utente();
	if(isLoggedIn){
		int id = (Integer) session.getAttribute("userId");
    	u = UserService.getUserById(id,ruolo);
	}
%>

<nav class="backdrop-blur-md bg-white/30 shadow-md sticky top-0 z-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <!-- Logo -->
            <div class="flex items-center space-x-1">
                <div class="flag-stripe green w-4 h-8 rounded-l"></div>
                <div class="flag-stripe white w-4 h-8"></div>
                <div class="flag-stripe red w-4 h-8 rounded-r"></div>

                <a href="/Italicious/home" class="text-2xl font-bold text-gray-800 hover:text-green-700 transition">
                    <img src="img/loghi/logo.png" alt="Italicious Logo" class="h-10 object-contain">
                </a>
            </div>

            <!-- Menu per desktop -->
            <div class="hidden md:flex space-x-8">
                <a href="<%=request.getContextPath() %>/home" class="text-gray-800 hover:text-green-600 font-medium transition">Home</a>
                <a href="<%=request.getContextPath() %>/chi_siamo" class="text-gray-800 hover:text-green-600 font-medium transition">Chi Siamo</a>
                <a href="<%=request.getContextPath() %>/catalogo" class="text-gray-800 hover:text-green-600 font-medium transition">Catalogo</a>

                <%
                    if (!isLoggedIn) {
                %>
                    <a href="<%=request.getContextPath() %>/login" class="text-gray-800 hover:text-green-600 font-medium transition">Accedi</a>
                <%
                    } else if ("admin".equals(ruolo)) {
                %>
                    <a href="<%=request.getContextPath() %>/admin" class="text-gray-800 hover:text-green-600 font-medium transition">Gestione</a>
                <%
                    }
                %>
            </div>

            <!-- Sezione destra (utente, carrello, hamburger) -->
            <div class="flex items-center space-x-6 relative">
                <% if (isLoggedIn) { %>
                    <p class="text-sm text-gray-700">Ciao, <b><%= u.getNome() %></b></p>
                <% } %>
				
                <a href="/Italicious/carrello" class="relative text-gray-800 hover:text-green-600 transition">
    <i class="fas fa-shopping-cart text-xl"></i> 
    <span id="carrelloBadge" class="absolute -top-2 -right-2 bg-red-600 text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center"
          style="<%= (request.getAttribute("carrelloCount") != null && (int)request.getAttribute("carrelloCount") > 0) ? "" : "display:none;" %>">
        <%= request.getAttribute("carrelloCount") %>
    </span>
</a>


                <a href="#" class="text-gray-800 hover:text-green-600 transition profile-link" id="profileBtn">
                    <i class="fas fa-user text-xl"></i>
                    
                </a>

                <div class="popup-menu" id="profileMenu">
                    <% if (!isLoggedIn) { %>
                        <a href="/Italicious/login"><i class="fa-solid fa-right-to-bracket"></i> Accedi</a>
                    <% } else { %>
                        <a href="<%=request.getContextPath() %>/profilo">Profilo</a>
                        <a href="<%=request.getContextPath() %>/ordini">I Miei Ordini</a>
                        <a href="<%=request.getContextPath() %>/lista_preferiti">Lista preferiti</a>
                        <a href="<%= request.getContextPath() %>/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                    <% } %>
                </div>

                <button class="md:hidden focus:outline-none" id="mobile-menu-button">
                    <i class="fas fa-bars text-xl"></i>
                </button>
            </div>
        </div>

        <!-- Menu mobile -->
        <div class="md:hidden hidden py-4" id="mobile-menu">
            <a href="/Italicious/home" class="block py-2 text-gray-800 hover:text-green-600 transition">Home</a>
            <a href="/Italicious/chi_siamo" class="block py-2 text-gray-800 hover:text-green-600 transition">Chi Siamo</a>
            <a href="/Italicious/catalogo" class="block py-2 text-gray-800 hover:text-green-600 transition">Catalogo</a>

            <% if (!isLoggedIn) { %>
                <a href="/Italicious/login" class="block py-2 text-gray-800 hover:text-green-600 transition">Accedi</a>
            <% } %>
        </div>
    </div>
</nav>

<script>
    const profileBtn = document.getElementById('profileBtn');
    const profileMenu = document.getElementById('profileMenu');
    const mobileBtn  = document.getElementById('mobile-menu-button');
    const mobileMenu = document.getElementById('mobile-menu');

    profileBtn.addEventListener('click', function(e) {
        e.preventDefault();
        profileMenu.classList.toggle('show');
    });

    document.addEventListener('click', function(e) {
        if (!profileBtn.contains(e.target) && !profileMenu.contains(e.target)) {
            profileMenu.classList.remove('show');
        }
    });
    mobileBtn.addEventListener('click', function () {
      mobileMenu.classList.toggle('hidden');
    });
</script>
