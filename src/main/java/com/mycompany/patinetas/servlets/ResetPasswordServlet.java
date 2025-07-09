package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.models.Usuario;
import com.mycompany.patinetas.util.PasswordUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        
        if (token == null || token.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Usuario usuario = usuarioDAO.obtenerPorResetToken(token);
        
        if (usuario == null) {
            request.setAttribute("error", "El enlace de recuperación no es válido o ha expirado");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        request.setAttribute("token", token);
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String nuevaContraseña = request.getParameter("nuevaContraseña");
        String confirmarContraseña = request.getParameter("confirmarContraseña");
        
        // Validaciones
        if (!nuevaContraseña.equals(confirmarContraseña)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!PasswordUtil.esContraseñaFuerte(nuevaContraseña)) {
            request.setAttribute("error", 
                "La contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y caracteres especiales");
            request.setAttribute("token", token);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }
        
        Usuario usuario = usuarioDAO.obtenerPorResetToken(token);
        
        if (usuario != null && usuarioDAO.actualizarContraseña(usuario.getId(), nuevaContraseña)) {
            request.setAttribute("success", "¡Contraseña actualizada correctamente! Por favor inicia sesión");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "No se pudo actualizar la contraseña. El enlace puede haber expirado");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        usuarioDAO.cerrarConexion();
    }

}
