import re
import os

base_dir = r"c:\Users\Master\Documents\GitHub\Italicious\docs"

# Leggi index.html per estrarre nav e script
with open(os.path.join(base_dir, 'index.html'), 'r', encoding='utf-8') as f:
    index_content = f.read()

# Trova nav
nav_match = re.search(r'(<nav.*?</nav>)', index_content, re.DOTALL)
if nav_match:
    nav_html = nav_match.group(1)

# Trova il blocco script menu mobile e profileMenu
script_match = re.search(r'(<script>.*?const profileBtn =.*?</script>)', index_content, re.DOTALL)
if script_match:
    script_html = script_match.group(1)

# Funzione per iniettare in auth pages
def inject_to_auth(filename):
    path = os.path.join(base_dir, filename)
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Se c'è già la nav, non raddoppiare
    if '<nav ' not in content:
        # Inserisci nav subito dopo <body ...>
        content = re.sub(r'(<body[^>]*>)', r'\1\n' + nav_html, content)
    
    # Se c'è già lo script, non raddoppiare
    if 'profileBtn.addEventListener' not in content:
        # Inserisci script prima della chiusura </body>, ma tieni i tag script preesistenti
        content = content.replace('</body>', script_html + '\n</body>')

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

inject_to_auth('login.html')
inject_to_auth('register.html')

print("Navbar e script iniettati con successo in login e register.")
