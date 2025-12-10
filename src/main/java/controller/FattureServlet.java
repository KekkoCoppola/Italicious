package controller;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import Dao.FatturaDAO;
import Dao.OrdineDAO;
import Dao.ProdottoDAO;
import Model.Ordine;
import Model.OrdineProdotto;
import Model.Prodotto;
import Model.UserService;
import Model.Utente;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class FattureServlet extends HttpServlet {

    // --- formattatori per le date e l'euro (it-IT) ---
    private static final DateTimeFormatter DATE_IT = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final DecimalFormat CURRENCY_IT;
    static {
        DecimalFormatSymbols sym = new DecimalFormatSymbols(Locale.ITALY);
        sym.setDecimalSeparator(',');
        sym.setGroupingSeparator('.');
        CURRENCY_IT = new DecimalFormat("#,##0.00", sym);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	 HttpSession session = request.getSession(false);
         if (session == null || session.getAttribute("username") == null) {
             response.sendRedirect("login");
             return;
        }
         String richiedente = request.getParameter("richiedente"); // CF o PARTITA IVA
         String ordineIdStr = request.getParameter("ordineId");
         if (ordineIdStr == null) {
             response.sendRedirect("ordini");
             return;
         }

         int idOrdine;
         try {
             idOrdine = Integer.parseInt(ordineIdStr);
         } catch (NumberFormatException e) {
             response.sendRedirect("ordini");
             return;
         }
         Ordine ordine;
         try {
             ordine = OrdineDAO.findByIdWithRighe(idOrdine);
             if (ordine == null) {
                 response.sendRedirect("ordini");
                 return;
             }
  
         

         } catch (SQLException e) {
             e.printStackTrace();
             response.sendRedirect("ordini");
             return;
         }
         Utente u = UserService.getUserById((Integer) session.getAttribute("userId"), (String) session.getAttribute("role"));
         u.setFatturazione(richiedente);
         UserService.updateUtente(u, (String) session.getAttribute("role"));
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=fattura.pdf");

        try (OutputStream out = response.getOutputStream()) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=Fattura_ORD" + ordine.getId() + ".pdf");

            Document doc = new Document(PageSize.A4, 36, 36, 40, 36); // margini: sx, dx, top, bottom
            PdfWriter.getInstance(doc, out);
            doc.open();

            try {
                Image logo = Image.getInstance(getServletContext().getRealPath("/img/loghi/logo.png"));
                logo.scaleToFit(130, 80);
                logo.setAlignment(Image.ALIGN_LEFT);
                doc.add(logo);
            } catch (Exception ig) {
                // Se il logo non esiste, ignora
            }

            Paragraph titolo = new Paragraph("FATTURA",
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20));
            titolo.setAlignment(Element.ALIGN_CENTER);
            titolo.setSpacingBefore(10f);
            titolo.setSpacingAfter(14f);
            doc.add(titolo);

            // =========================
            // 2) DATI VENDITORE / CLIENTE
            // =========================
            PdfPTable info = new PdfPTable(2);
            info.setWidthPercentage(100);
            info.setSpacingAfter(12f);
            info.setWidths(new float[]{1, 1});

            // --- VENDITORE  ---
            PdfPTable venditore = new PdfPTable(1);
            venditore.setWidthPercentage(100);

            venditore.addCell(boxHeader("VENDITORE"));
            venditore.addCell(boxRow("Ragione Sociale", "ITALICIOUS S.R.L."));               // TODO: tua ragione sociale
            venditore.addCell(boxRow("Indirizzo", "Via Giovanni Paolo II, 132, 84084 Fisciano SA"));           // TODO: tuo indirizzo
            venditore.addCell(boxRow("P.IVA", "IT12345678901"));                              // TODO: tua P.IVA
            venditore.addCell(boxRow("Email", "info@italicious.it"));                         // TODO: tua email


            // --- CLIENTE / RICHIEDENTE ---
            PdfPTable cliente = new PdfPTable(1);
            cliente.setWidthPercentage(100);

            cliente.addCell(boxHeader("CLIENTE"));
            
            
            // DATI RICEVENTE
            cliente.addCell(boxRow("Denominazione", u.getNome()));                          
            cliente.addCell(boxRow("Indirizzo", u.getIndirizzo()));        
            cliente.addCell(boxRow("CF / P.IVA", safeAscii(richiedente)));  
            cliente.addCell(boxRow("Email", u.getMail()));  
            cliente.addCell(boxRow("Telefono", u.getTelefono()));  
                      												

            // Inserisco le 2 colonne nella tabella “info”
            PdfPCell cVend = new PdfPCell(venditore);
            cVend.setPadding(0); cVend.setBorder(PdfPCell.NO_BORDER);
            PdfPCell cCli = new PdfPCell(cliente);
            cCli.setPadding(0); cCli.setBorder(PdfPCell.NO_BORDER);

            info.addCell(cVend);
            info.addCell(cCli);
            doc.add(info);

            // =========================
            // 3) DATI DOCUMENTO
            // =========================
            PdfPTable meta = new PdfPTable(3);
            meta.setWidthPercentage(100);
            meta.setSpacingAfter(10f);
            meta.setWidths(new float[]{1, 1, 1});

            meta.addCell(metaCell("Numero", "#" + ordine.getId()));
            meta.addCell(metaCell("Data", (ordine.getDataOrdine() != null ? DATE_IT.format(ordine.getDataOrdine()) : "")));
            meta.addCell(metaCell("Stato Ordine", ordine.getStato() != null ? ordine.getStato().getValue() : "-"));
            doc.add(meta);

            // =========================
            // 4) TABELLA ARTICOLI
            // =========================
            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{4, 1.2f, 1.6f, 1.2f, 1.8f});
            table.setHeaderRows(1);

    
            table.addCell(th("Articolo"));
            table.addCell(th("Q.tà"));
            table.addCell(th("Prezzo"));
            table.addCell(th("IVA%"));
            table.addCell(th("Totale"));

            boolean zebra = false;
            for (OrdineProdotto r : ordine.getRighe()) {
            	Prodotto p = ProdottoDAO.getProdottoById(r.getIdProdotto());
                String nomeArticolo = p.getNome();
             

                table.addCell(td(nomeArticolo, zebra));
                table.addCell(tdCenter(String.valueOf(r.getQuantita()), zebra));
                table.addCell(tdRight("€ " + CURRENCY_IT.format(r.getPrezzo()), zebra));
                table.addCell(tdCenter(CURRENCY_IT.format(r.getIva()), zebra));
                table.addCell(tdRight("€ " + CURRENCY_IT.format(r.getTotaleRigaIvato()), zebra));

                zebra = !zebra;
            }
            doc.add(table);

            // =========================
            // 5) TOTALI IN EURO
            // =========================
            BigDecimal totImp = ordine.getTotaleImponibile();
            BigDecimal totIva = ordine.getTotaleIva();
            BigDecimal totDoc = ordine.getTotaleIvato();

            PdfPTable totali = new PdfPTable(2);
            totali.setWidthPercentage(50);
            totali.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totali.setSpacingBefore(12f);
            totali.setWidths(new float[]{1, 1});

            totali.addCell(totalLabel("Totale Imponibile:"));
            totali.addCell(totalValue("€ " + CURRENCY_IT.format(totImp)));

            totali.addCell(totalLabel("Di cui IVA:"));
            totali.addCell(totalValue("€ " + CURRENCY_IT.format(totIva)));

            PdfPCell labTot = totalLabelStrong("TOTALE DOCUMENTO:");
            PdfPCell valTot = totalValueStrong("€ " + CURRENCY_IT.format(totDoc));
            labTot.setBackgroundColor(new Color(245, 247, 250)); 
            valTot.setBackgroundColor(new Color(245, 247, 250));
            totali.addCell(labTot);
            totali.addCell(valTot);

            doc.add(totali);

            // =========================
            // 6) FOOTER
            // =========================
            Paragraph note = new Paragraph(
                "Note:\n" +
                "- I prezzi si intendono in Euro.\n" +
                "- Documento generato automaticamente da Italicious.",
                FontFactory.getFont(FontFactory.HELVETICA, 9)
            );
            note.setSpacingBefore(16f);
            doc.add(note);
            FatturaDAO.saveOrUpdateFattura(idOrdine, richiedente, totDoc, totImp);
            doc.close();
        } catch (SQLException e) {
		
			e.printStackTrace();
		}

    }

 // ====== CELLE CLIENTE E VENDITORE ======
    private PdfPCell boxHeader(String title){
        PdfPCell c = new PdfPCell(new Phrase(title, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11)));
        c.setBackgroundColor(new Color(240, 243, 247));
        c.setPadding(6);
        c.setBorderColor(new Color(220, 224, 229));
        return c;
    }
    private PdfPCell boxRow(String label, String value){
        Phrase ph = new Phrase();
        ph.add(new Chunk(label + ": ", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));
        ph.add(new Chunk(safeAscii(value), FontFactory.getFont(FontFactory.HELVETICA, 10)));
        PdfPCell c = new PdfPCell(ph);
        c.setPadding(6);
        c.setBorderColor(new Color(225, 229, 234));
        return c;
    }

    // ====== DATI DOCUMENTI ======
    private PdfPCell metaCell(String label, String value){
        Phrase ph = new Phrase();
        ph.add(new Chunk(label + "\n", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));
        ph.add(new Chunk(safeAscii(value), FontFactory.getFont(FontFactory.HELVETICA, 10)));
        PdfPCell c = new PdfPCell(ph);
        c.setPadding(8);
        c.setBorderColor(new Color(230, 234, 239));
        return c;
    }
    private PdfPCell metaCell(String labelValue){
        return metaCell("", labelValue);
    }

    // ====== INTESTAZIONI TABELLA ARTICOLI ======
    private PdfPCell th(String text){
        PdfPCell c = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11)));
        c.setBackgroundColor(new Color(235, 238, 242));
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setPadding(8);
        c.setBorderColor(new Color(210, 214, 220));
        return c;
    }

    // ====== CELLE ======
    private PdfPCell td(String text, boolean zebra){
        PdfPCell c = new PdfPCell(new Phrase(safeAscii(text), FontFactory.getFont(FontFactory.HELVETICA, 10)));
        if (zebra) c.setBackgroundColor(new Color(250, 250, 250));
        c.setPadding(7);
        c.setBorderColor(new Color(230, 233, 238));
        return c;
    }
    private PdfPCell tdCenter(String text, boolean zebra){
        PdfPCell c = td(text, zebra);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        return c;
    }
    private PdfPCell tdRight(String text, boolean zebra){
        PdfPCell c = td(text, zebra);
        c.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return c;
    }

    // ====== TOTALI ======
    private PdfPCell totalLabel(String text){
        PdfPCell c = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA, 11)));
        c.setBorderColor(new Color(220, 224, 229));
        c.setPadding(6);
        c.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return c;
    }
    private PdfPCell totalValue(String text){
        PdfPCell c = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA, 11)));
        c.setBorderColor(new Color(220, 224, 229));
        c.setPadding(6);
        c.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return c;
    }
    private PdfPCell totalLabelStrong(String text){
        PdfPCell c = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
        c.setBorderColor(new Color(200, 205, 210));
        c.setPadding(7);
        c.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return c;
    }
    private PdfPCell totalValueStrong(String text){
        PdfPCell c = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
        c.setBorderColor(new Color(200, 205, 210));
        c.setPadding(7);
        c.setHorizontalAlignment(Element.ALIGN_RIGHT);
        return c;
    }
    private String safeAscii(String s) {
        if (s == null) return "";
        return s
            .replace('à','a').replace('á','a')
            .replace('è','e').replace('é','e')
            .replace('ì','i')
            .replace('ò','o').replace('ó','o')
            .replace('ù','u').replace('ú','u');
       
    }

}
