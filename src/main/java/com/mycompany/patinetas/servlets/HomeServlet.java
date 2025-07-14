package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.CategoriaDAO;
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
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
        categoriaDAO = new CategoriaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener todas las categorías para mostrar en el home
        request.setAttribute("categorias", categoriaDAO.listarTodas());

        // Obtener productos destacados (por ejemplo, los 6 más recientes)
        request.setAttribute("productosDestacados", productoDAO.listarDestacados(8));

        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);

    }
    
    @Override
    public void destroy() {
        productoDAO.cerrarConexion();
    }

}
