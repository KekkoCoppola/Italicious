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
        
        /* Contenitore link + menu */
		  .profile-container {
		    position: relative;
		    display: inline-block; /* in linea per stare vicino */
		  }
		
		  /* Link (icona) */
		  .profile-link {
		    cursor: pointer;
		    color: #2d3748; /* text-gray-800 */
		    transition: color 0.3s ease;
		    font-size: 1.25rem; /* text-xl */
		  }
		  .profile-link:hover {
		    color: #38a169; /* hover:text-green-600 */
		  }
		
		  /* Popup menu nascosto */
		  .popup-menu {
		    display: none;
		    position: absolute;
		    top: 100%; /* subito sotto il link */
		    right: 0;  /* allineato a destra */
		    background-color: white;
		    border: 1px solid #ccc;
		    border-radius: 6px;
		    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
		    min-width: 160px;
		    z-index: 1000;
		  }
		
		  /* Mostra menu */
		  .popup-menu.show {
		    display: block;
		  }
		
		  /* Voci menu */
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
    String username = (String) session.getAttribute("username");
    String ruolo = (String) session.getAttribute("role");
    boolean isLoggedIn = username != null;
    %>

<!-- Navbar -->
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
                    <a href="/Italicious/home" class="text-gray-800 hover:text-green-600 font-medium transition">Home</a>
                    <a href="#" class="text-gray-800 hover:text-green-600 font-medium transition">Chi Siamo</a>
                    <a href="/Italicious/catalogo" class="text-gray-800 hover:text-green-600 font-medium transition">Catalogo</a>
                    <!--  <a href="#" class="text-gray-800 hover:text-green-600 font-medium transition">Cerca</a>-->
                        <%
					
					    if (!isLoggedIn) {
					%>
						<a href="/Italicious/login" class="text-gray-800 hover:text-green-600 font-medium transition">Accedi</a>
					<%
					    }else if ("admin".equals(ruolo)) {
							%>
							<a href="/Italicious/admin" class="text-gray-800 hover:text-green-600 font-medium transition">Gestione</a>
							<%
					    }
							%>
				                    
                </div>
                
                <!-- Icona carrello -->
                <div class="flex items-center space-x-7">
                <%
					
					    if (isLoggedIn) {
					%>
					<p>Ciao, <b><%=username %></b></p>
					<%
					    }
					%>
                    <a href="#" class="text-gray-800 hover:text-green-600 transition">
                        <i class="fas fa-shopping-cart text-xl"></i> 
                    </a>
                    
                    <a href="" class="text-gray-800 hover:text-green-600 transition profile-link" id="profileBtn" >
                        <i class="fas fa-user text-xl"></i>
                    </a>
                    
                    <div class="popup-menu" id="profileMenu">
                    <%
					
					    if (!isLoggedIn) {
					%>
					<a href="/Italicious/login">Accedi</a>
                    <%
					    }else{
                    %>
					     
					    <a href="/profile">Profilo</a>
					    <a href="/settings">Impostazioni</a>
					    <a href="<%= request.getContextPath() %>/logout">Logout</a>
					    <% } %>
					  </div>
                    
                    <!-- Hamburger menu per mobile -->
                    <button class="md:hidden focus:outline-none" id="mobile-menu-button">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                </div>
            </div>
            
            <!-- Menu mobile -->
            <div class="md:hidden hidden py-4" id="mobile-menu">
                <a href="/Italicious/home" class="block py-2 text-gray-800 hover:text-green-600 transition">Home</a>
                <a href="#" class="block py-2 text-gray-800 hover:text-green-600 transition">Chi Siamo</a>
                <a href="/Italicious/catalogo" class="block py-2 text-gray-800 hover:text-green-600 transition">Catalogo</a>
                <!-- <a href="#" class="block py-2 text-gray-800 hover:text-green-600 transition">Cerca</a> -->
              
					
					  <%if (!isLoggedIn) {
					%>
                <a href="/Italicious/login" class="block py-2 text-gray-800 hover:text-green-600 transition">Accedi</a>
            	<%
					    }
					%>
					     
            </div>
        </div>
    </nav>
    <script>
    const profileBtn = document.getElementById('profileBtn');
    const profileMenu = document.getElementById('profileMenu');

    profileBtn.addEventListener('click', function(e) {
      e.preventDefault();
      profileMenu.classList.toggle('show');
    });

 
    document.addEventListener('click', function(e) {
      if (!profileBtn.contains(e.target) && !profileMenu.contains(e.target)) {
        profileMenu.classList.remove('show');
      }
    });
    </script>