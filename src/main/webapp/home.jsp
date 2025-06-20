<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Italicious - Prodotti Tipici Italiani</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .region {
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .region:hover {
            opacity: 0.8;
            transform: scale(1.02);
        }
        .region-tooltip {
            position: absolute;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
            z-index: 10;
        }
        .region:hover + .region-tooltip {
            opacity: 1;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://images.unsplash.com/photo-1532634922-8fe0b757fb13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            animation: fadeIn 1s ease-out;
        }
        
        .review-card {
            transition: all 0.3s ease;
        }
        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-gray-50 font-sans">
    <!-- home.jsp -->



    <!-- Hero Section -->
    <section class="hero-section text-white py-16">
        <div class="container mx-auto px-4 text-center">
            <h1 class="text-4xl md:text-5xl font-bold mb-6">Scopri i Sapori d'Italia</h1>
            <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto">Autentici prodotti regionali direttamente dalla terra italiana alla tua tavola</p>
            <a href="/Italicious/catalogo" class="bg-white text-green-700 hover:bg-gray-100 font-bold py-3 px-8 rounded-full text-lg transition transform hover:scale-105">
                Esplora il Catalogo
            </a>
        </div>
    </section>


    <!-- Mappa Italia -->
    <section class="py-12 bg-white">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12 text-gray-800">Scopri le Regioni Italiane</h2>
            
            <div class="relative max-w-4xl mx-auto">
                <!-- Mappa SVG dell'Italia con regioni cliccabili -->
                <svg viewBox="0 0 800 1000" xmlns="http://www.w3.org/2000/svg" class="w-full h-auto">
		  <!-- Nord Italia -->
		  <path id="piemonte" class="region fill-green-100 hover:fill-green-300 stroke-white stroke-1" d="M200,100 L250,120 L270,150 L240,180 L220,160 L200,170 L180,150 Z" onclick="showRegion('Piemonte')" />
		  <path id="valle-aosta" class="region fill-green-200 hover:fill-green-400 stroke-white stroke-1" d="M180,80 L200,100 L180,150 L160,130 Z" onclick="showRegion('Valle d&apos;Aosta')" />
		  <path id="lombardia" class="region fill-green-300 hover:fill-green-500 stroke-white stroke-1" d="M240,180 L270,150 L300,180 L320,200 L300,220 L280,210 L260,230 L240,200 Z" onclick="showRegion('Lombardia')" />
		  <path id="trentino" class="region fill-green-400 hover:fill-green-600 stroke-white stroke-1" d="M260,230 L280,210 L300,220 L320,240 L300,260 L280,250 Z" onclick="showRegion('Trentino-Alto Adige')" />
		  <path id="veneto" class="region fill-green-500 hover:fill-green-700 stroke-white stroke-1" d="M300,260 L320,240 L340,260 L360,280 L340,300 L320,290 L300,280 Z" onclick="showRegion('Veneto')" />
		  <path id="friuli" class="region fill-green-600 hover:fill-green-800 stroke-white stroke-1" d="M360,280 L380,300 L360,320 L340,300 Z" onclick="showRegion('Friuli-Venezia Giulia')" />
		  <path id="liguria" class="region fill-green-700 hover:fill-green-900 stroke-white stroke-1" d="M200,170 L220,160 L240,180 L260,230 L240,250 L220,230 L200,250 L180,220 L160,200 L180,180 Z" onclick="showRegion('Liguria')" />
		  <path id="emilia" class="region fill-red-100 hover:fill-red-300 stroke-white stroke-1" d="M240,250 L260,230 L280,250 L300,260 L320,290 L340,300 L360,320 L340,340 L320,330 L300,350 L280,330 L260,350 L240,330 L220,310 L240,290 Z" onclick="showRegion('Emilia-Romagna')" />
		
		  <!-- Centro Italia -->
		  <path id="toscana" class="region fill-red-200 hover:fill-red-400 stroke-white stroke-1" d="M240,290 L220,310 L240,330 L260,350 L240,370 L220,350 L200,370 L180,350 L160,330 L180,310 L200,330 L220,310 L240,290 Z" onclick="showRegion('Toscana')" />
		  <path id="marche" class="region fill-red-300 hover:fill-red-500 stroke-white stroke-1" d="M280,330 L300,350 L320,330 L340,340 L360,360 L340,380 L320,370 L300,390 L280,370 L260,350 Z" onclick="showRegion('Marche')" />
		  <path id="umbria" class="region fill-red-400 hover:fill-red-600 stroke-white stroke-1" d="M260,350 L280,370 L300,390 L280,410 L260,390 L240,370 Z" onclick="showRegion('Umbria')" />
		  <path id="lazio" class="region fill-red-500 hover:fill-red-700 stroke-white stroke-1" d="M240,370 L260,390 L280,410 L260,430 L240,410 L220,390 L200,410 L180,390 L200,370 L220,350 Z" onclick="showRegion('Lazio')" />
		  <path id="abruzzo" class="region fill-red-600 hover:fill-red-800 stroke-white stroke-1" d="M280,410 L300,390 L320,370 L340,380 L360,400 L340,420 L320,410 L300,430 L280,410 Z" onclick="showRegion('Abruzzo')" />
		  <path id="molise" class="region fill-red-700 hover:fill-red-900 stroke-white stroke-1" d="M300,430 L320,410 L340,420 L360,440 L340,460 L320,450 L300,470 Z" onclick="showRegion('Molise')" />
		
		  <!-- Sud Italia -->
		  <path id="campania" class="region fill-white hover:fill-gray-200 stroke-gray-400 stroke-1" d="M240,410 L260,430 L280,410 L300,430 L320,450 L340,460 L320,480 L300,460 L280,480 L260,460 L240,480 L220,460 L200,440 L220,420 Z" onclick="showRegion('Campania')" />
		  <path id="puglia" class="region fill-white hover:fill-gray-300 stroke-gray-400 stroke-1" d="M320,450 L340,460 L360,440 L380,460 L360,480 L340,470 L320,490 L300,510 L280,490 L300,470 Z" onclick="showRegion('Puglia')" />
		  <path id="basilicata" class="region fill-gray-100 hover:fill-gray-400 stroke-gray-400 stroke-1" d="M300,460 L320,480 L340,470 L360,480 L340,500 L320,490 L300,510 L280,490 Z" onclick="showRegion('Basilicata')" />
		  <path id="calabria" class="region fill-gray-200 hover:fill-gray-500 stroke-gray-400 stroke-1" d="M280,490 L300,510 L280,530 L260,510 L240,530 L220,510 L240,490 Z" onclick="showRegion('Calabria')" />
		
		  <!-- Isole -->
		  <path id="sicilia" class="region fill-gray-300 hover:fill-gray-600 stroke-gray-400 stroke-1" d="M200,560 L220,540 L240,560 L260,540 L280,560 L260,580 L240,560 L220,580 L200,560 Z" onclick="showRegion('Sicilia')" />
		  <path id="sardegna" class="region fill-gray-400 hover:fill-gray-700 stroke-gray-400 stroke-1" d="M100,400 L120,380 L140,400 L160,380 L180,400 L160,420 L140,400 L120,420 L100,400 Z" onclick="showRegion('Sardegna')" />
		
		  <!-- Tooltip placeholder -->
		  <foreignObject x="0" y="0" width="100%" height="100%">
    <div class="region-tooltip" id="region-tooltip"></div>
  </foreignObject>
</svg>
                
                <!-- Info regione selezionata -->
                <div id="region-info" class="hidden mt-8 p-6 bg-gray-50 rounded-lg shadow-md">
                    <div class="flex flex-col md:flex-row items-center">
                        <div class="md:w-1/3 mb-4 md:mb-0">
                            <img id="region-image" src="" alt="" class="w-full h-48 object-cover rounded-lg">
                        </div>
                        <div class="md:w-2/3 md:pl-8">
                            <h3 id="region-name" class="text-2xl font-bold mb-2"></h3>
                            <p id="region-description" class="text-gray-700 mb-4"></p>
                            <div id="region-products" class="flex flex-wrap gap-2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Prodotti in evidenza -->
    <section class="py-12 bg-gray-50">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12 text-gray-800">I Nostri Prodotti in Evidenza</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Prodotto 1 -->
                <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="https://images.unsplash.com/photo-1603569283847-aa6f53b5a7d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" alt="Parmigiano Reggiano" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2">Parmigiano Reggiano</h3>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded">Emilia-Romagna</span>
                        </div>
                        <p class="text-gray-600 mb-4">Formaggio stagionato 24 mesi, prodotto con latte crudo di vacche alimentate con foraggi locali.</p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">&euro;12,90</span>
                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition">
                                <i class="fas fa-cart-plus mr-2"></i>Aggiungi
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Prodotto 2 -->
                <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="https://images.unsplash.com/photo-1592417817098-8fd3d9eb14a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" alt="Olio Extra Vergine di Oliva" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2">Olio EVO Toscano</h3>
                            <span class="bg-red-100 text-red-800 text-xs font-medium px-2.5 py-0.5 rounded">Toscana</span>
                        </div>
                        <p class="text-gray-600 mb-4">Olio extra vergine di oliva DOP, fruttato medio con sentori di carciofo e mandorla.</p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">€9,50</span>
                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition">
                                <i class="fas fa-cart-plus mr-2"></i>Aggiungi
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Prodotto 3 -->
                <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-xl transition transform hover:-translate-y-1">
                    <img src="https://images.unsplash.com/photo-1611270634121-85658e60e122?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" alt="Prosciutto di Parma" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-xl font-bold mb-2">Prosciutto di Parma</h3>
                            <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded">Emilia-Romagna</span>
                        </div>
                        <p class="text-gray-600 mb-4">Prosciutto crudo stagionato 24 meses, dolce e profumato, tagliato a mano al momento.</p>
                        <div class="flex justify-between items-center">
                            <span class="text-xl font-bold">€18,50</span>
                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-full transition">
                                <i class="fas fa-cart-plus mr-2"></i>Aggiungi
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-10">
                <a href="/Italicious/catalogo" class="bg-white text-green-600 border-2 border-green-600 hover:bg-green-600 hover:text-white font-bold py-3 px-8 rounded-full text-lg transition transform hover:scale-105">
                    Vedi Tutti i Prodotti
                </a>
            </div>
        </div>
    </section>

    <!-- Recensioni Clienti -->
    <section class="py-16 bg-white">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-12 text-gray-800">Cosa Dicono i Nostri Clienti</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Recensione 1 -->
                <div class="review-card bg-gray-50 p-6 rounded-lg shadow-md">
                    <div class="flex items-center mb-4">
                        <div class="flex-shrink-0">
                            <img class="h-10 w-10 rounded-full" src="https://randomuser.me/api/portraits/women/32.jpg" alt="Maria Rossi">
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900">Maria Rossi</p>
                            <div class="flex">
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                            </div>
                        </div>
                    </div>
                    <p class="text-gray-600 italic">"Ho ricevuto il pacco con i prodotti della Toscana e sono rimasta stupita dalla qualità. L'olio EVO ha un profumo incredibile e il pecorino è perfetto. Consiglio Italicious a tutti gli amanti della vera cucina italiana!"</p>
                </div>
                
                <!-- Recensione 2 -->
                <div class="review-card bg-gray-50 p-6 rounded-lg shadow-md">
                    <div class="flex items-center mb-4">
                        <div class="flex-shrink-0">
                            <img class="h-10 w-10 rounded-full" src="https://randomuser.me/api/portraits/men/45.jpg" alt="Luigi Bianchi">
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900">Luigi Bianchi</p>
                            <div class="flex">
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                            </div>
                        </div>
                    </div>
                    <p class="text-gray-600 italic">"Finalmente un sito che porta i veri sapori della mia terra (il Piemonte) direttamente a casa. Il tartufo era fresco e profumatissimo, e il Barolo era imballato con cura. Servizio impeccabile!"</p>
                </div>
                
                <!-- Recensione 3 -->
                <div class="review-card bg-gray-50 p-6 rounded-lg shadow-md">
                    <div class="flex items-center mb-4">
                        <div class="flex-shrink-0">
                            <img class="h-10 w-10 rounded-full" src="https://randomuser.me/api/portraits/women/68.jpg" alt="Anna Verdi">
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900">Anna Verdi</p>
                            <div class="flex">
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                                <i class="fas fa-star text-yellow-400"></i>
                            </div>
                        </div>
                    </div>
                    <p class="text-gray-600 italic">"Ho ordinato il cesto regalo con prodotti siciliani per un'amica e sono rimasta entusiasta della presentazione e della qualità. I cannoli erano deliziosi e il pistacchio di Bronte aveva un sapore unico. Tornerò sicuramente a fare acquisti!"</p>
                </div>
            </div>
            
            <div class="text-center mt-12">
                <button class="bg-green-600 hover:bg-green-700 text-white font-bold py-3 px-8 rounded-full text-lg transition transform hover:scale-105">
                    Leggi Altre Recensioni
                </button>
            </div>
        </div>
    </section>

    <script>
        // Menu mobile toggle
        document.getElementById('mobile-menu-button').addEventListener('click', function() {
            const menu = document.getElementById('mobile-menu');
            menu.classList.toggle('hidden');
        });

        // Dati delle regioni
        const regionsData = {
            'Piemonte': {
                description: 'Il Piemonte è una regione ricca di tradizioni enogastronomiche, famosa per i suoi vini pregiati come Barolo e Barbaresco, e per prodotti come il tartufo bianco di Alba e la bagna cauda.',
                image: 'https://images.unsplash.com/photo-1603569283847-aa6f53b5a7d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Tartufo Bianco di Alba', 'Barolo DOCG', 'Gianduiotti', 'Risotto al Barolo']
            },
            'Valle d\'Aosta': {
                description: 'La più piccola regione d\'Italia offre prodotti di montagna come la Fontina DOP, i vini di montagna e i salumi tipici come il mocetta.',
                image: 'https://images.unsplash.com/photo-1514933651103-005eec06c04d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Fontina DOP', 'Mocetta', 'Tè delle Alpi', 'Polenta concia']
            },
            'Lombardia': {
                description: 'Terra di risaie e grandi formaggi, la Lombardia è famosa per il risotto alla milanese, il panettone, il gorgonzola e i vini della Franciacorta.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Gorgonzola DOP', 'Panettone', 'Risotto alla Milanese', 'Bresaola della Valtellina']
            },
            'Trentino-Alto Adige': {
                description: 'Regione alpina dove si fondono tradizioni italiane e mitteleuropee, famosa per le mele, i vini bianchi, lo speck e i canederli.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Speck Alto Adige', 'Mele della Val di Non', 'Vino Gewürztraminer', 'Canederli']
            },
            'Veneto': {
                description: 'Terra del prosecco, del radicchio e del riso vialone nano, il Veneto offre anche prodotti come l\'asiago e il baccalà alla vicentina.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Prosecco DOCG', 'Radicchio di Treviso', 'Asiago DOP', 'Baccalà alla Vicentina']
            },
            'Friuli-Venezia Giulia': {
                description: 'Regione di confine con influenze slave e austriache, famosa per il prosciutto di San Daniele, i vini bianchi e la gubana.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Prosciutto di San Daniele', 'Vino Friulano', 'Gubana', 'Frico']
            },
            'Liguria': {
                description: 'Terra del pesto alla genovese, della focaccia e dei vini delle Cinque Terre, la Liguria offre anche ottimi oli d\'oliva e acciughe del Mar Ligure.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Pesto alla Genovese', 'Focaccia', 'Olio Taggiasca', 'Sciacchetrà DOC']
            },
            'Emilia-Romagna': {
                description: 'Considerata la capitale gastronomica d\'Italia, offre prodotti come il parmigiano reggiano, il prosciutto di Parma, l\'aceto balsamico e le paste fresche.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Parmigiano Reggiano', 'Prosciutto di Parma', 'Aceto Balsamico', 'Tortellini']
            },
            'Toscana': {
                description: 'Terra del Chianti, dell\'olio extravergine e della bistecca alla fiorentina, la Toscana è anche famosa per il pecorino e i salumi come il finocchiona.',
                image: 'https://images.unsplash.com/photo-1592417817098-8fd3d9eb14a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Olio EVO Toscano', 'Chianti Classico', 'Pecorino Toscano', 'Finocchiona']
            },
            'Umbria': {
                description: 'Regione verde d\'Italia, famosa per il tartufo nero di Norcia, i vini Sagrantino e i salumi come la porchetta.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Tartufo Nero di Norcia', 'Sagrantino di Montefalco', 'Porchetta', 'Lenticchie di Castelluccio']
            },
            'Marche': {
                description: 'Terra di vini come il Verdicchio e di prodotti come il brodetto alla marchigiana e la casciotta d\'Urbino.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Verdicchio dei Castelli di Jesi', 'Oliva Ascolana', 'Ciauscolo', 'Brodetto alla Marchigiana']
            },
            'Lazio': {
                description: 'Terra della cucina romana con piatti come la carbonara e l\'abbacchio, e prodotti come il pecorino romano e i vini dei Castelli Romani.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Pecorino Romano', 'Guanciale', 'Vino Frascati', 'Maritozzi']
            },
            'Abruzzo': {
                description: 'Regione di montagne e mare, famosa per lo zafferano dell\'Aquila, il montepulciano d\'Abruzzo e la ventricina.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Zafferano dell\'Aquila', 'Montepulciano d\'Abruzzo', 'Ventricina', 'Confetti di Sulmona']
            },
            'Molise': {
                description: 'Piccola regione con grandi tradizioni, come i cavatelli molisani, i formaggi podolici e l\'olio extravergine.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Caciocavallo di Agnone', 'Olio Molise DOP', 'Cavatelli Molisani', 'Pampanella']
            },
            'Campania': {
                description: 'Terra della pizza napoletana, della mozzarella di bufala e dei limoni di Sorrento, la Campania è anche famosa per il limoncello e il ragù napoletano.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Mozzarella di Bufala', 'Pomodoro San Marzano', 'Limoncello', 'Pasta di Gragnano']
            },
            'Puglia': {
                description: 'Granai d\'Italia, famosa per l\'olio extravergine, il pane di Altamura, i vini primitivo e i formaggi come il burrata.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Olio Puglia DOP', 'Burrata', 'Pane di Altamura', 'Pasticciotto Leccese']
            },
            'Basilicata': {
                description: 'Terra del peperone di Senise, del pane di Matera e dei vini aglianico, la Basilicata offre anche ottimi salumi e formaggi.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Peperone di Senise', 'Pane di Matera', 'Aglianico del Vulture', 'Soppressata']
            },
            'Calabria': {
                description: 'Terra del peperoncino, della \'nduja e dei vini gaglioppo, la Calabria è anche famosa per i fichi d\'india e la cipolla rossa di Tropea.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['\'Nduja', 'Cipolla Rossa di Tropea', 'Peperoncino Calabrese', 'Fileja']
            },
            'Sicilia': {
                description: 'Isola dai sapori intensi, famosa per i cannoli, la pasta alla norma, il pistacchio di Bronte e i vini come il nero d\'avola.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Cannoli Siciliani', 'Pistacchio di Bronte', 'Nero d\'Avola', 'Pasta di Mandorla']
            },
            'Sardegna': {
                description: 'Isola con tradizioni uniche, famosa per il pecorino sardo, il pane carasau, il mirto e i vini cannonau.',
                image: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80',
                products: ['Pecorino Sardo', 'Pane Carasau', 'Cannonau di Sardegna', 'Bottarga']
            }
        };

        // Mostra informazioni regione
        function showRegion(regionName) {
            const regionInfo = document.getElementById('region-info');
            const regionData = regionsData[regionName];
            
            document.getElementById('region-name').textContent = regionName;
            document.getElementById('region-description').textContent = regionData.description;
            document.getElementById('region-image').src = regionData.image;
            document.getElementById('region-image').alt = `Prodotti tipici della ${regionName}`;
            
            const productsContainer = document.getElementById('region-products');
            productsContainer.innerHTML = '';
            
            regionData.products.forEach(product => {
                const badge = document.createElement('span');
                badge.className = 'bg-green-100 text-green-800 text-sm font-medium px-3 py-1 rounded-full';
                badge.textContent = product;
                productsContainer.appendChild(badge);
            });
            
            regionInfo.classList.remove('hidden');
            regionInfo.scrollIntoView({ behavior: 'smooth' });
        }

        // Tooltip per le regioni
        document.querySelectorAll('.region').forEach(region => {
            region.addEventListener('mouseover', function() {
                const tooltip = document.getElementById('region-tooltip');
                const regionId = this.id.replace('-', ' ');
                tooltip.textContent = regionId.charAt(0).toUpperCase() + regionId.slice(1);
                
                const rect = this.getBoundingClientRect();
                tooltip.style.left = `${rect.left + window.scrollX + rect.width/2 - 50}px`;
                tooltip.style.top = `${rect.top + window.scrollY - 40}px`;
            });
        });
    </script>
</body>
</html>