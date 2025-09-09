<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordine Non Effettuato</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .checkmark-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: scaleIn 0.5s ease-out;
        }
        @keyframes scaleIn {
            0% { transform: scale(0); opacity: 0; }
            80% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">
    <main class="flex-grow flex items-center justify-center px-4 py-12">
        <div class="max-w-md w-full bg-white rounded-xl shadow-sm p-8 text-center" data-aos="zoom-in">
            <div class="checkmark-circle bg-red-100 text-red-600 mx-auto mb-6">
                <i class="fas fa-xmark" class="w-12 h-12"></i>
            </div>
            <h1 class="text-2xl font-bold text-gray-900 mb-4">Ordine non effettuato!</h1>
            <p class="text-gray-600 mb-6"><%=request.getAttribute("errore") %></p>


            <div class="flex flex-col sm:flex-row gap-3 justify-center">
                <a href="<%=request.getContextPath() %>/carrello" class="px-6 py-3 bg-green-600 text-white rounded-lg font-medium hover:bg-green-700 transition flex items-center justify-center gap-2">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Torna al carrello</span>
                </a>
                <a href="<%=request.getContextPath() %>/home" class="px-6 py-3 bg-white border border-gray-300 rounded-lg font-medium hover:bg-gray-50 transition flex items-center justify-center gap-2">
                    <i class="fas fa-house"></i>
                    <span>Torna alla home</span>
                </a>
            </div>
        </div>
    </main>

</body>
</html>