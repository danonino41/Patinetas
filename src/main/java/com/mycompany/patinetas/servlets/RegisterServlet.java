package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.models.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("contraseña");
        String confirmarContraseña = request.getParameter("confirmarContraseña");
        
        // Validaciones
        if (nombre == null || nombre.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            contraseña == null || contraseña.trim().isEmpty() ||
            confirmarContraseña == null || confirmarContraseña.trim().isEmpty()) {
            request.setAttribute("error", "Todos los datos son requeridos");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
                
        if (!contraseña.equals(confirmarContraseña)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        if (usuarioDAO.existeEmail(email)) {
            request.setAttribute("error", "El email ya está registrado");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        if (!esContraseñaFuerte(contraseña)) {
            request.setAttribute("error", 
                "La contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y caracteres especiales");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Crear nuevo usuario con rol de usuario por defecto
        Usuario nuevoUsuario = new Usuario(nombre, email, contraseña, "usuario");
        
        try {
            if (usuarioDAO.registrarUsuario(nuevoUsuario)) {
                request.setAttribute("success", "Usuario registrado exitosamente");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Error al registrar el usuario");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private boolean esContraseñaFuerte(String contraseña) {
        if (contraseña == null || contraseña.length() < 8) {
            return false;
        }

        // Requerir mezcla de caracteres
        boolean tieneMayus = !contraseña.equals(contraseña.toLowerCase());
        boolean tieneMinus = !contraseña.equals(contraseña.toUpperCase());
        boolean tieneNumero = contraseña.matches(".*\\d.*");
        boolean tieneEspecial = !contraseña.matches("[A-Za-z0-9]*");

        return tieneMayus && tieneMinus && tieneNumero && tieneEspecial;
    }

}
