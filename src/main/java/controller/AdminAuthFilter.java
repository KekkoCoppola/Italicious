package controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class AdminAuthFilter implements Filter {

    private Set<String> protectedSet;   // esatte: /admin.jsp
    private Set<String> prefixSet;      // cartelle: /admin/* (opzionale)
    private String forbiddenPage;       // es: /403.jsp

    @Override
    public void init(FilterConfig cfg) {
        protectedSet = new HashSet<>();
        prefixSet = new HashSet<>();

        String csv = cfg.getInitParameter("protectedPaths");
        if (csv != null && !csv.isBlank()) {
            Arrays.stream(csv.split(","))
                  .map(String::trim)
                  .filter(s -> !s.isEmpty())
                  .forEach(s -> {
                      if (s.endsWith("/*")) {
                          prefixSet.add(s.substring(0, s.length() - 1)); // tiene "/admin/"
                      } else {
                          protectedSet.add(s); // "/admin.jsp"
                      }
                  });
        }

    }

    @Override
    public void doFilter(ServletRequest r, ServletResponse p, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest) r;
        HttpServletResponse resp = (HttpServletResponse) p;

        String ctx  = req.getContextPath();             // es: /italicious
        String uri  = req.getRequestURI();              // es: /italicious/admin.jsp
        String path = uri.substring(ctx.length());      // es: /admin.jsp

        if (!isProtected(path)) {
            chain.doFilter(r, p);
            return;
        }

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        boolean isAdmin = "admin".equalsIgnoreCase(role);

        if (isAdmin) {
            resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            resp.setHeader("Pragma", "no-cache");
            resp.setDateHeader("Expires", 0);
            chain.doFilter(r, p);
        } else {
        	resp.sendError(HttpServletResponse.SC_FORBIDDEN);
        }
    }

    private boolean isProtected(String path) {
        if (protectedSet.contains(path)) return true;
        for (String prefix : prefixSet) {
            if (path.startsWith(prefix)) return true;
        }
        return false;
    }
}
