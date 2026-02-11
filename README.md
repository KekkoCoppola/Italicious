
# Italicious

<div align="center">
  <img src="src/main/webapp/img/loghi/logo.png" alt="Italicious Logo" width="400" />
  
  <h3>Il gusto dell'italia a portata di click.</h3>
  
  <p align="center">
    <a href="#-descrizione">Descrizione</a> •
    <a href="#-come-funziona">Come Funziona</a> •
    <a href="#-installazione">Installazione</a> •
    <a href="#-struttura">Struttura</a> •
    <a href="#-risultati">Risultati</a> •
    <a href="#-limiti">Limiti</a>
  </p>
</div>

![Python](https://img.shields.io/badge/Python-3.9%2B-blue)
![Streamlit](https://img.shields.io/badge/Streamlit-App-red)
![ML](https://img.shields.io/badge/ML-Logistic%20Regression-green)

---

E-commerce di prodotti tipici italiani, navigabili per Regione (homepage con mappa interattiva) e catalogo con filtri/ricerca.
Stack: Java (JSP/Servlets), Tomcat, JDBC, MySQL, HTML/CSS/JS.

Requisiti

JDK 17+ (consigliato)

Apache Tomcat 10.x

MySQL 8.x

Eclipse (il progetto contiene .project e .classpath, non usa Maven/Gradle)

La repo contiene le cartelle e i file di progetto Eclipse: .settings/, build/classes/, src/main/, .classpath, .project 
GitHub

Struttura progetto
Italicious/
├─ .settings/
├─ build/
│  └─ classes/                # output compilato (Eclipse)
├─ src/
│  └─ main/
│     ├─ java/                # sorgenti Java: Servlets, DAO, model (*vedi nota*)
│     └─ webapp/              # JSP, asset statici (CSS/JS/img)
├─ .classpath
└─ .project


N.B. La vista web di GitHub per src/main/... potrebbe non caricare l’elenco file senza login; i percorsi sopra derivano dall’albero radice visibile pubblicamente. 
GitHub
+1

Import in Eclipse (senza Maven)

File → Import… → Existing Projects into Workspace

Seleziona la cartella clonata della repo.

Imposta il Targeted Runtime su Apache Tomcat 10.x (Project → Properties → Targeted Runtimes).

Imposta Java 17 come JRE del progetto (Project → Properties → Java Build Path → Libraries).

Configurazione Tomcat

Aggiungi il progetto a Tomcat (Eclipse → Servers → Add and Remove…).

Context path suggerito: /Italicious.

Avvio: Run on Server.

Database Setup (MySQL)

Al momento nella repo non è presente uno script SQL ma puoi cambiare le credenziali di accesso al db in DBConnection.java

Build & Run

Avvia MySQL e assicurati che il DB italiciousdb esista.

In Eclipse: Project → Clean per ricompilare in build/classes/.

Run on Server su Tomcat 10.x.

Apri: http://localhost:8080/Italicious/

Struttura Web

src/main/webapp/

index.jsp (mappa Italia / selezione regione)

catalogo.jsp (lista prodotti con filtri/ricerca)

admin/*.jsp (gestione prodotti)

assets/ (CSS, JS, immagini)

(I nomi specifici possono variare: aggiorna dopo aver aggiunto i file definitivi.)

Convenzioni & Note

Encoding: UTF-8 ovunque.

Locale: it-IT (formati data/prezzi).

Dipendenze front-end: JS vanilla, CSS (eventuale Tailwind/utility CSS se aggiunto manualmente).

Logging: se non presente, consigliato log via java.util.logging o SLF4J.

Roadmap (idee)

Pagina Regione → Prodotti (filtri: categoria, prezzo, rating, disponibilità).

Carrello/Checkout (sessione + persistenza).

Pannello Admin (CRUD prodotti/regioni).

Integrazione RICETTE regionali collegate ai prodotti.

Esportazioni (CSV/Excel) dal catalogo.

Licenza

TBD
