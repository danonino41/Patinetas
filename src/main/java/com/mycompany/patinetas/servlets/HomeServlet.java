package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        // Obtener productos destacados (por ejemplo, los 6 más recientes)
        request.setAttribute("productosDestacados", productoDAO.listarDestacados(6));

        // Obtener productos en oferta (si aplica)
        request.setAttribute("productosOferta", productoDAO.listarEnOferta(4));

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    public void destroy() {
        productoDAO.cerrarConexion();
    }

}
