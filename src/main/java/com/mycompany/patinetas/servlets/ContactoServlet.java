package com.mycompany.patinetas.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ContactoServlet", urlPatterns = {"/contact"})
public class ContactoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Configurar datos de contacto
        request.setAttribute("direccion", "Av. Principal 123, Lima, Perú");
        request.setAttribute("telefono", "+51 987 654 321");
        request.setAttribute("email", "contacto@patinetasshop.com");
        request.setAttribute("horario", "Lunes a Viernes: 9:00 AM - 6:00 PM");
        
        // Redirigir a la vista
        request.getRequestDispatcher("/WEB-INF/views/cliente/contacto.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            // Procesar formulario de contacto
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String asunto = request.getParameter("asunto");
            String mensaje = request.getParameter("mensaje");

            // Simulación de éxito
            request.getSession().setAttribute("mensajeExito", "Gracias por contactarnos, " + nombre + ". Te responderemos pronto.");

            // Redirigir de vuelta a contacto
            response.sendRedirect(request.getContextPath() + "/contact");
    }

}
