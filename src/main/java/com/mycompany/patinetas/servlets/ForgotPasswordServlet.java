package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.models.Usuario;
import com.mycompany.patinetas.util.EmailService;
import com.mycompany.patinetas.util.PasswordUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    private EmailService emailService;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
        emailService = new EmailService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        try {
            Usuario usuario = usuarioDAO.obtenerPorEmail(email);
            
            if (usuario != null) {
                String token = PasswordUtil.generateResetToken();
                usuarioDAO.guardarResetToken(usuario.getId(), token);
                
                String resetLink = request.getScheme() + "://" + request.getServerName() + 
                                 ":" + request.getServerPort() + request.getContextPath() + 
                                 "/reset-password?token=" + token;
                
                emailService.enviarEmailReset(usuario.getEmail(), resetLink);
            }
            
            // Mostrar mismo mensaje aunque el email no exista (por seguridad)
            request.setAttribute("success", "Si el email existe en nuestro sistema, recibirás un enlace para restablecer tu contraseña");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Ocurrió un error al procesar tu solicitud");
            request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        usuarioDAO.cerrarConexion();
    }

}
