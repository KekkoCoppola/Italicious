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
</style>

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
                    <a href="#" class="text-gray-800 hover:text-green-600 font-medium transition">Cerca</a>
                    <a href="/Italicious/login" class="text-gray-800 hover:text-green-600 font-medium transition">Accedi</a>
                </div>
                
                <!-- Icona carrello -->
                <div class="flex items-center space-x-4">
                    <a href="#" class="text-gray-800 hover:text-green-600 transition">
                        <i class="fas fa-shopping-cart text-xl"></i>
                    </a>
                    
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
                <a href="#" class="block py-2 text-gray-800 hover:text-green-600 transition">Cerca</a>
                <a href="/Italicious/login" class="block py-2 text-gray-800 hover:text-green-600 transition">Accedi</a>
            </div>
        </div>
    </nav>