package com.mycompany.patinetas.filter;

import com.mycompany.patinetas.models.Usuario;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/admin/*", "/vendedor/*", "/cliente/*"})
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización del filtro
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        boolean loggedIn = (session != null && session.getAttribute("usuario") != null);
        
        if (!loggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
        
        // Verificar roles para rutas protegidas
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        if (path.startsWith("/admin/") && !usuario.getRol().equals("admin")) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        if (path.startsWith("/vendedor/") && !usuario.getRol().equals("vendedor")) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Limpieza del filtro
    }
}