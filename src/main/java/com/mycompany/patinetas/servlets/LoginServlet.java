package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.models.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String contraseña = request.getParameter("contraseña");
        
        // Validaciones
        if (email == null || email.trim().isEmpty() || 
            contraseña == null || contraseña.trim().isEmpty()) {
            request.setAttribute("error", "Email y contraseña son requeridos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Obtener usuario
        Usuario usuario = usuarioDAO.obtenerUsuario(email, contraseña);
        
        if (usuario != null) {
            // Crear sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            String contextPath = request.getContextPath();
            
            // Redirigir según el rol
            switch (usuario.getRol()) {
                case "admin":
                    response.sendRedirect(contextPath + "/admin/dashboard.jsp");
                    break;
                case "vendedor":
                    response.sendRedirect(contextPath + "/vendedor/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect(contextPath + "/cliente/dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Email o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        usuarioDAO.cerrarConexion();
    }

}
