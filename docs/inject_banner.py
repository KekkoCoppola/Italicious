import os
import glob

docs_dir = r"c:\Users\Master\Documents\GitHub\Italicious\docs"
files = glob.glob(os.path.join(docs_dir, "*.html"))

banner = """
<!-- BANNER DEMO -->
<div class="fixed bottom-0 left-0 w-full bg-red-600/90 backdrop-blur text-white text-center py-3 z-[10000] font-bold shadow-lg text-sm sm:text-base tracking-wide border-t-4 border-red-700">
    🚨 AREA DEMO: Questa è una versione dimostrativa statica. I dati sono mockati e le funzionalità limitate. 🚨
</div>
<!-- FINE BANNER DEMO -->
"""

header_padding = "<style>body { padding-bottom: 60px; }</style>\n"

for val in files:
    with open(val, "r", encoding="utf-8") as f:
        content = f.read()
    
    if "AREA DEMO" not in content:
        content = content.replace("</head>", header_padding + "</head>")
        content = content.replace("</body>", banner + "</body>")
        
        with open(val, "w", encoding="utf-8") as f:
            f.write(content)

print(f"Aggiornati {len(files)} file con il banner demo.")
