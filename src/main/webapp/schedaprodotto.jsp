<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prodotti Tipici Italiani - Dettaglio Prodotto</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-gallery {
            scroll-snap-type: x mandatory;
        }
        .product-gallery img {
            scroll-snap-align: start;
        }
        .flag-italy {
            background: linear-gradient(to right, #009246 33%, #FFFFFF 33%, #FFFFFF 66%, #CE2B37 66%);
        }
        .heart-animation {
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        .origin-map {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 60" fill="none" stroke="%23e5e7eb"><path d="M50,5 C60,15 70,10 80,15 C90,20 95,30 80,40 C65,50 60,45 50,55 C40,45 35,50 20,40 C5,30 10,20 20,15 C30,10 40,15 50,5 Z"/></svg>');
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
        }
    </style>
</head>
<body class="bg-gray-50 font-sans">
    <div class="container mx-auto px-4 py-8 max-w-6xl">
    		<% Prodotto p = (Prodotto)request.getAttribute("prodotto"); %>
        <!-- Breadcrumb -->
        <nav class="flex mb-6" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a href="#" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-amber-600">
                        <i class="fas fa-home mr-2"></i>
                        Home
                    </a>
                </li>
                <li>
                    <div class="flex items-center">
                        <i class="fas fa-chevron-right text-gray-400"></i>
                        <a href="#" class="ml-1 text-sm font-medium text-gray-700 hover:text-amber-600 md:ml-2"><%=p.getRegione() %></a>
                    </div>
                </li>
                <li aria-current="page">
                    <div class="flex items-center">
                        <i class="fas fa-chevron-right text-gray-400"></i>
                        <span class="ml-1 text-sm font-medium text-amber-600 md:ml-2"><%=p.getNome() %></span>
                    </div>
                </li>
            </ol>
        </nav>

        <div class="bg-white rounded-xl shadow-lg overflow-hidden">
            <div class="md:flex">
                <!-- Gallery -->
                <div class="md:w-1/2 p-6">
                    <div class="relative mb-4">
                        <div class="flex overflow-x-auto product-gallery space-x-4 rounded-lg snap-mandatory snap-x">
                            <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                 alt="Aceto Balsamico di Modena" 
                                 class="w-full h-80 object-cover rounded-lg flex-shrink-0">
                            <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                 alt="Aceto Balsamico di Modena - confezione" 
                                 class="w-full h-80 object-cover rounded-lg flex-shrink-0">
                            <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                                 alt="Aceto Balsamico di Modena - produzione" 
                                 class="w-full h-80 object-cover rounded-lg flex-shrink-0">
                        </div>
                        <div class="absolute top-4 left-4">
                            <span class="bg-amber-500 text-white text-xs font-semibold px-2.5 py-0.5 rounded-full">DOP</span>
                        </div>
                        <button class="absolute top-4 right-4 bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                            <i class="far fa-heart text-gray-600 text-xl"></i>
                        </button>
                    </div>
                    <div class="grid grid-cols-4 gap-2">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 1" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-amber-400">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 2" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-amber-400">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 3" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-amber-400">
                        <img src="https://images.unsplash.com/photo-1608039755401-742074f0545e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Thumbnail 4" 
                             class="h-20 object-cover rounded cursor-pointer border-2 border-transparent hover:border-amber-400">
                    </div>
                </div>
		
                <!-- Product Info -->
                <div class="md:w-1/2 p-6">
                    <div class="mb-4">
                        <div class="flex items-center justify-between">
                            <h1 class="text-3xl font-bold text-gray-900"><%= p.getNome() %></h1>
                            <div class="flag-italy w-8 h-6 rounded-sm"></div>
                        </div>
                        <p class="text-gray-500 mt-1"><%=p.getRegione() %></p>
                    </div>

                    <div class="flex items-center mb-4">
                        <div class="flex items-center">
                            <i class="fas fa-star text-amber-400"></i>
                            <i class="fas fa-star text-amber-400"></i>
                            <i class="fas fa-star text-amber-400"></i>
                            <i class="fas fa-star text-amber-400"></i>
                            <i class="fas fa-star-half-alt text-amber-400"></i>
                            <span class="text-gray-600 ml-2">4.7 (128 recensioni)</span>
                        </div>
                        <span class="mx-2 text-gray-300">|</span>
                        <div class="flex items-center text-green-600">
                            <i class="fas fa-check-circle mr-1"></i>
                            <span>Disponibile</span>
                        </div>
                    </div>

                    <div class="mb-6">
                        <span class="text-3xl font-bold text-gray-900"><%=p.getPrezzo() %></span>
                        <span class="text-sm text-gray-500 ml-1">IVA inclusa</span>
                    </div>

                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-2">Descrizione</h3>
                        <p class="text-gray-700"><%=p.getDescrizione() %></p>
                    </div>

                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-2">Origine</h3>
                        <div class="flex items-center">
                            <div class="origin-map w-16 h-16 mr-4"></div>
                            <div>
                                <p class="font-medium">Prodotto a Modena, Emilia-Romagna</p>
                                <p class="text-sm text-gray-600">Da una piccola azienda familiare con tradizione secolare</p>
                            </div>
                        </div>
                    </div>

                    <div class="mb-6">
                        <h3 class="text-lg font-semibold mb-2">Caratteristiche</h3>
                        <div class="grid grid-cols-2 gap-2">
                            <div class="flex items-center">
                                <i class="fas fa-wine-bottle text-gray-500 mr-2"></i>
                                <span>250ml</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-leaf text-gray-500 mr-2"></i>
                                <span>Biologico</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-clock text-gray-500 mr-2"></i>
                                <span>12 anni</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-certificate text-gray-500 mr-2"></i>
                                <span>DOP</span>
                            </div>
                        </div>
                    </div>

                    <div class="mb-6">
                        <div class="flex items-center mb-4">
                            <button class="bg-gray-200 hover:bg-gray-300 rounded-l-lg p-2">
                                <i class="fas fa-minus"></i>
                            </button>
                            <input type="number" value="1" min="1" class="w-16 text-center border-t border-b border-gray-200 py-2">
                            <button class="bg-gray-200 hover:bg-gray-300 rounded-r-lg p-2">
                                <i class="fas fa-plus"></i>
                            </button>
                            <span class="ml-4 text-sm text-gray-500">Disponibili: <%=p.getDisponibilita() %></span>
                        </div>

                        <div class="flex space-x-4">
                            <button class="bg-amber-600 hover:bg-amber-700 text-white font-bold py-3 px-6 rounded-lg flex-1 flex items-center justify-center">
                                <i class="fas fa-shopping-cart mr-2"></i>
                                Aggiungi al carrello
                            </button>
                            <button class="bg-white border border-amber-600 text-amber-600 hover:bg-amber-50 font-bold py-3 px-4 rounded-lg flex items-center justify-center">
                                <i class="fas fa-heart heart-animation mr-2"></i>
                            </button>
                        </div>
                    </div>

                    <div class="border-t border-gray-200 pt-4">
                        <div class="flex items-center text-sm text-gray-600">
                            <i class="fas fa-truck mr-2"></i>
                            <span>Spedizione gratuita per ordini superiori a â¬50</span>
                        </div>
                        <div class="flex items-center text-sm text-gray-600 mt-2">
                            <i class="fas fa-undo mr-2"></i>
                            <span>Reso gratuito entro 30 giorni</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Tabs -->
        <div class="mt-8 bg-white rounded-xl shadow-lg overflow-hidden">
            <div class="border-b border-gray-200">
                <nav class="flex -mb-px">
                    <button class="tab-button active py-4 px-6 text-center border-b-2 font-medium text-sm border-amber-500 text-amber-600">
                        <i class="fas fa-info-circle mr-2"></i>Dettagli
                    </button>
                    <button class="tab-button py-4 px-6 text-center border-b-2 font-medium text-sm border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        <i class="fas fa-list-ul mr-2"></i>Specifiche
                    </button>
                    <button class="tab-button py-4 px-6 text-center border-b-2 font-medium text-sm border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        <i class="fas fa-star mr-2"></i>Recensioni
                    </button>
                    <button class="tab-button py-4 px-6 text-center border-b-2 font-medium text-sm border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300">
                        <i class="fas fa-question-circle mr-2"></i>Domande
                    </button>
                </nav>
            </div>
            <div class="p-6">
                <div class="tab-content active">
                    <h3 class="text-lg font-semibold mb-4">La tradizione dell'Aceto Balsamico di Modena</h3>
                    <p class="mb-4 text-gray-700">L'Aceto Balsamico di Modena DOP Ã¨ un prodotto unico al mondo, frutto di una tradizione secolare che si tramanda di generazione in generazione nelle acetaie della provincia di Modena. Questo aceto nasce dalla sapiente combinazione di mosto d'uva cotto e aceto di vino, che viene poi fatto invecchiare in una serie di botti di legni diversi (rovere, castagno, ciliegio, gelso e ginepro) per un periodo minimo di 12 anni.</p>
                    <p class="mb-4 text-gray-700">Il processo di produzione Ã¨ rigorosamente regolamentato dal disciplinare DOP e ogni fase, dalla selezione delle uve all'invecchiamento, avviene esclusivamente nella zona geografica delimitata. Il risultato Ã¨ un condimento pregiato dal sapore inconfondibile, perfetto per esaltare piatti di carne, formaggi stagionati, fragole e persino gelato.</p>
                    <div class="bg-amber-50 border-l-4 border-amber-400 p-4 mb-4">
                        <div class="flex">
                            <div class="flex-shrink-0">
                                <i class="fas fa-lightbulb text-amber-400"></i>
                            </div>
                            <div class="ml-3">
                                <p class="text-sm text-amber-700">
                                    <strong>Consiglio dello chef:</strong> Per apprezzare al meglio l'Aceto Balsamico di Modena DOP, versane qualche goccia su un cucchiaino di parmigiano reggiano stagionato 36 mesi. L'abbinamento perfetto tra due eccellenze dell'Emilia-Romagna!
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Products -->
        <div class="mt-12">
            <h2 class="text-2xl font-bold mb-6">Altri prodotti della regione</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                <!-- Product 1 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1603569283847-aa6e0a0806a3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Parmigiano Reggiano" 
                             class="w-full h-48 object-cover">
                        <div class="absolute top-2 right-2">
                            <button class="bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                                <i class="far fa-heart text-gray-600"></i>
                            </button>
                        </div>
                    </div>
                    <div class="p-4">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm text-gray-500">Emilia-Romagna</span>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded">DOP</span>
                        </div>
                        <h3 class="text-lg font-semibold mb-1">Parmigiano Reggiano 36 mesi</h3>
                        <div class="flex items-center mb-2">
                            <div class="flex items-center">
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <span class="text-gray-600 ml-1 text-sm">4.9</span>
                            </div>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-lg font-bold">â¬12,90</span>
                            <button class="bg-amber-600 hover:bg-amber-700 text-white p-2 rounded-full">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1603569283847-aa6e0a0806a3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Prosciutto di Parma" 
                             class="w-full h-48 object-cover">
                        <div class="absolute top-2 right-2">
                            <button class="bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                                <i class="far fa-heart text-gray-600"></i>
                            </button>
                        </div>
                    </div>
                    <div class="p-4">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm text-gray-500">Emilia-Romagna</span>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded">DOP</span>
                        </div>
                        <h3 class="text-lg font-semibold mb-1">Prosciutto di Parma 24 mesi</h3>
                        <div class="flex items-center mb-2">
                            <div class="flex items-center">
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star-half-alt text-amber-400 text-sm"></i>
                                <span class="text-gray-600 ml-1 text-sm">4.6</span>
                            </div>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-lg font-bold">â¬18,50</span>
                            <button class="bg-amber-600 hover:bg-amber-700 text-white p-2 rounded-full">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1603569283847-aa6e0a0806a3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Tortellini" 
                             class="w-full h-48 object-cover">
                        <div class="absolute top-2 right-2">
                            <button class="bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                                <i class="far fa-heart text-gray-600"></i>
                            </button>
                        </div>
                    </div>
                    <div class="p-4">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm text-gray-500">Emilia-Romagna</span>
                            <span class="bg-blue-100 text-blue-800 text-xs font-medium px-2.5 py-0.5 rounded">IGP</span>
                        </div>
                        <h3 class="text-lg font-semibold mb-1">Tortellini alla Bolognese</h3>
                        <div class="flex items-center mb-2">
                            <div class="flex items-center">
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <span class="text-gray-600 ml-1 text-sm">4.8</span>
                            </div>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-lg font-bold">â¬6,90</span>
                            <button class="bg-amber-600 hover:bg-amber-700 text-white p-2 rounded-full">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300">
                    <div class="relative">
                        <img src="https://images.unsplash.com/photo-1603569283847-aa6e0a0806a3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" 
                             alt="Lambrusco" 
                             class="w-full h-48 object-cover">
                        <div class="absolute top-2 right-2">
                            <button class="bg-white p-2 rounded-full shadow-md hover:bg-gray-100">
                                <i class="far fa-heart text-gray-600"></i>
                            </button>
                        </div>
                    </div>
                    <div class="p-4">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm text-gray-500">Emilia-Romagna</span>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded">DOC</span>
                        </div>
                        <h3 class="text-lg font-semibold mb-1">Lambrusco Grasparossa</h3>
                        <div class="flex items-center mb-2">
                            <div class="flex items-center">
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="fas fa-star text-amber-400 text-sm"></i>
                                <i class="far fa-star text-amber-400 text-sm"></i>
                                <span class="text-gray-600 ml-1 text-sm">4.2</span>
                            </div>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-lg font-bold">â¬9,50</span>
                            <button class="bg-amber-600 hover:bg-amber-700 text-white p-2 rounded-full">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Tab functionality
        document.addEventListener('DOMContentLoaded', function() {
            const tabButtons = document.querySelectorAll('.tab-button');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabButtons.forEach(button => {
                button.addEventListener('click', () => {
                    // Remove active class from all buttons and contents
                    tabButtons.forEach(btn => btn.classList.remove('active', 'border-amber-500', 'text-amber-600'));
                    tabContents.forEach(content => content.classList.remove('active'));
                    
                    // Add active class to clicked button and corresponding content
                    button.classList.add('active', 'border-amber-500', 'text-amber-600');
                    const tabId = button.getAttribute('data-tab');
                    if (tabId) {
                        document.getElementById(tabId).classList.add('active');
                    }
                });
            });

            // Quantity buttons
            const minusBtn = document.querySelector('.fa-minus').parentNode;
            const plusBtn = document.querySelector('.fa-plus').parentNode;
            const quantityInput = document.querySelector('input[type="number"]');
            
            minusBtn.addEventListener('click', () => {
                let value = parseInt(quantityInput.value);
                if (value > 1) {
                    quantityInput.value = value - 1;
                }
            });
            
            plusBtn.addEventListener('click', () => {
                let value = parseInt(quantityInput.value);
                quantityInput.value = value + 1;
            });

            // Wishlist button
            const wishlistBtn = document.querySelector('.fa-heart').parentNode;
            wishlistBtn.addEventListener('click', function() {
                const icon = this.querySelector('i');
                if (icon.classList.contains('far')) {
                    icon.classList.remove('far');
                    icon.classList.add('fas', 'text-red-500');
                } else {
                    icon.classList.remove('fas', 'text-red-500');
                    icon.classList.add('far');
                }
            });
        });
    </script>
</body>
</html>