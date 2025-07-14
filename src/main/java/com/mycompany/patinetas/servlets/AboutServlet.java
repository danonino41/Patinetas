package com.mycompany.patinetas.servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AboutServlet", urlPatterns = {"/about"})
public class AboutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            // Datos estáticos que podrías cargar desde una base de datos o properties
            request.setAttribute("titulo", "Sobre Nosotros");
            request.setAttribute("mision", "Ofrecer las mejores patinetas del mercado con calidad y seguridad.");
            request.setAttribute("vision", "Ser líderes en venta de patinetas a nivel nacional.");
            request.setAttribute("historia", "Fundada en 2020, comenzamos como un pequeño emprendimiento y hoy somos referencia en el sector.");

            // Equipo (podría ser una lista de objetos desde una base de datos)
            String[] equipo = {
                "Juan Pérez - Fundador",
                "María García - Gerente Comercial",
                "Carlos López - Jefe de Ventas"
            };
            request.setAttribute("equipo", equipo);

            // Redirigir a la vista
            request.getRequestDispatcher("/WEB-INF/views/cliente/nosotros.jsp").forward(request, response);
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
