
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Seleziona una regione - Italicious</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
    }
    object {
      width: 100%;
      max-width: 900px;
      display: block;
      margin: 20px auto;
    }
  </style>
</head>
<body>

<h2>Seleziona una regione</h2>

<!-- Cartina Italia in SVG -->
<object id="mappaItalia" type="image/svg+xml" data="img/italia.svg"></object>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const obj = document.getElementById("mappaItalia");

    obj.addEventListener("load", function () {
      const svgDoc = obj.contentDocument;

      // Seleziona tutti i path che rappresentano le regioni
      svgDoc.querySelectorAll("path").forEach(region => {
        const id = region.getAttribute("id");
        if (!id) return; // salta se manca l'id

        // Applica interazione
        region.style.cursor = "pointer";
        region.addEventListener("click", function () {
          const nomeRegione = nomeRegioneDaId(id);
          window.location.href = "catalogo.jsp?regione=" + encodeURIComponent(nomeRegione);
        });

        // Effetto hover
        region.addEventListener("mouseover", () => region.style.fill = "#ff9900");
        region.addEventListener("mouseout", () => region.style.fill = "");
      });
    });
  });

  // Mappa ID SVG → Nome Regione leggibile
  function nomeRegioneDaId(id) {
    const mappa = {
      "r_ABR": "Abruzzo",
      "r_BAS": "Basilicata",
      "r_CAL": "Calabria",
      "r_CAM": "Campania",
      "r_EMR": "Emilia-Romagna",
      "r_FVG": "Friuli-Venezia Giulia",
      "r_LAZ": "Lazio",
      "r_LIG": "Liguria",
      "r_LOM": "Lombardia",
      "r_MAR": "Marche",
      "r_MOL": "Molise",
      "r_PMN": "Piemonte",
      "r_PUG": "Puglia",
      "r_SAR": "Sardegna",
      "r_SIC": "Sicilia",
      "r_TOS": "Toscana",
      "r_TAA": "Trentino-Alto Adige",
      "r_UMB": "Umbria",
      "r_VEN": "Veneto",
      "r_VDA": "Valle d'Aosta"
    };
    return mappa[id] || id; // fallback se manca nella mappa
  }
</script>

</body>
</html>
