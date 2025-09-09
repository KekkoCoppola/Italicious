<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Montserrat:wght@300;400;600&display=swap');
       
        .hero-pattern {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxkZWZzPjxwYXR0ZXJuIGlkPSJwYXR0ZXJuIiB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHBhdHRlcm5Vbml0cz0idXNlclNwYWNlT25Vc2UiIHBhdHRlcm5UcmFuc2Zvcm09InJvdGF0ZSg0NSkiPjxyZWN0IHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgZmlsbD0iI2ZmZmZmZiIgb3BhY2l0eT0iMC4xIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI3BhdHRlcm4pIi8+PC9zdmc+');
        }
        
        .flag-wave {
            position: relative;
            height: 15px;
            background: linear-gradient(90deg, #008C45 33.33%, #F4F5F0 33.33%, #F4F5F0 66.66%, #CD212A 66.66%);
        }
        
        .flag-wave::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            right: 0;
            height: 10px;
            background: linear-gradient(90deg, #008C45 33.33%, #F4F5F0 33.33%, #F4F5F0 66.66%, #CD212A 66.66%);
            opacity: 0.7;
        }
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://www.venditaprodottitipici.net/wp-content/uploads/2022/06/prodotti-enogastronomici-1080x675.jpg');
            background-size: cover;
            background-position: center;
            animation: fadeIn 1s ease-out;
        }
        .team-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .product-card {
            transition: all 0.3s ease;
        }
        
        .product-card:hover {
            transform: scale(1.03);
        }
    </style>
</head>
<body class="bg-white">

 <!-- Hero Section -->
    <section class="hero-section text-white py-16">
        <div class="container mx-auto px-4 text-center">
            <h1 class="text-4xl md:text-5xl font-bold mb-6">La nostra <span class="text-green-600">passione</span> per l'<span class="text-red-600">Italia</span>
            </h1>
            <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto">Scopri la storia dietro Italicious e la nostra missione per portare i sapori autentici della tradizione italiana direttamente a casa tua.</p>
        </div>
    </section>
    <section class="py-16 bg-white">
        <div class="container mx-auto px-4">
            <div class="flex flex-col md:flex-row items-center">
                <div class="md:w-1/2 mb-10 md:mb-0 md:pr-10">
                    <img src="img/chisiamoimg.webp" 
                         alt="Italian countryside" 
                         class="rounded-lg shadow-xl w-full h-auto object-cover">
                </div>
                <div class="md:w-1/2">
                    <h2 class="text-3xl md:text-4xl font-bold title-font mb-6 text-gray-800">
                        La nostra <span class="text-red-600">storia</span>
                    </h2>
                    <p class="text-gray-600 mb-4">
                        Italicious nasce nel 2015 dall'incontro di quattro amici con una passione comune: 
                        l'autenticità dei prodotti italiani regionali. Dopo anni trascorsi a viaggiare 
                        per lo Stivale, abbiamo deciso di condividere queste prelibatezze con il mondo.
                    </p>
                    <p class="text-gray-600 mb-4">
                        Partiti da un piccolo magazzino a Bologna, oggi collaboriamo con oltre 200 
                        piccoli produttori in tutte le 20 regioni italiane, selezionando con cura 
                        solo i prodotti che rispettano le tradizioni e la qualità che l'Italia sa offrire.
                    </p>
                    <p class="text-gray-600">
                        Il nostro nome, Italicious, unisce "Italy" e "delicious", perché crediamo che 
                        la vera essenza dell'Italia sia nella sua straordinaria capacità di unire 
                        bellezza e bontà in ogni suo angolo.
                    </p>
                </div>
            </div>
        </div>
    </section>
    <section id="mission" class="py-16 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="text-center mb-16">
                <h2 class="text-3xl md:text-4xl font-bold title-font mb-4 text-gray-800">
                    La nostra <span class="text-green-600">missione</span>
                </h2>
                <div class="w-24 h-1 bg-red-600 mx-auto mb-6"></div>
                <p class="text-xl text-gray-600 max-w-3xl mx-auto">
                    Valorizzare le eccellenze regionali italiane, sostenere i piccoli produttori e 
                    diffondere la cultura del buon cibo autentico in tutto il mondo.
                </p>
            </div>
            
            <div class="grid md:grid-cols-3 gap-8">
                <div class="bg-white p-8 rounded-lg shadow-md text-center">
                    <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <i class="fas fa-map-marked-alt text-red-600 text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-800">Scoperta del territorio</h3>
                    <p class="text-gray-600">
                        Viaggiamo personalmente per scoprire produttori locali che mantengono vivi 
                        i metodi tradizionali di produzione.
                    </p>
                </div>
                
                <div class="bg-white p-8 rounded-lg shadow-md text-center">
                    <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <i class="fas fa-hand-holding-heart text-green-600 text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-800">Commercio equo</h3>
                    <p class="text-gray-600">
                        Paghiamo un prezzo equo ai produttori, sostenendo le economie locali e 
                        incentivando la qualità rispetto alla quantità.
                    </p>
                </div>
                
                <div class="bg-white p-8 rounded-lg shadow-md text-center">
                    <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <i class="fas fa-truck text-red-600 text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-bold mb-3 text-gray-800">Consegna attenta</h3>
                    <p class="text-gray-600">
                        Imballiamo e spediamo con cura ogni prodotto per garantire che arrivi 
                        nelle vostre case come se lo aveste acquistato direttamente dal produttore.
                    </p>
                </div>
            </div>
        </div>
    </section>

</body>
</html>