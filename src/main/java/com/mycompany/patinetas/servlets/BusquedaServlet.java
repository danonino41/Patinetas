package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.models.Categoria;
import com.mycompany.patinetas.models.Producto;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "BusquedaServlet", urlPatterns = {"/busqueda"})
public class BusquedaServlet extends HttpServlet {
    
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Obtener parámetros de búsqueda
            String nombre = request.getParameter("nombre");
            String categoriaIdParam = request.getParameter("categoria");
            String precioMinParam = request.getParameter("precioMin");
            String precioMaxParam = request.getParameter("precioMax");
            
            // Parsear parámetros
            Integer categoriaId = null;
            Double precioMin = null;
            Double precioMax = null;
            
            if (categoriaIdParam != null && !categoriaIdParam.isEmpty()) {
                categoriaId = Integer.parseInt(categoriaIdParam);
            }
            
            if (precioMinParam != null && !precioMinParam.isEmpty()) {
                precioMin = Double.parseDouble(precioMinParam);
            }
            
            if (precioMaxParam != null && !precioMaxParam.isEmpty()) {
                precioMax = Double.parseDouble(precioMaxParam);
            }
            
            // Obtener productos filtrados
            List<Producto> productos = productoDAO.filtrarProductos(categoriaId, precioMin, precioMax, nombre);
            List<Categoria> categorias = productoDAO.obtenerTodasCategorias();
            
            // Pasar datos a la vista
            request.setAttribute("productos", productos);
            request.setAttribute("categorias", categorias);
            request.setAttribute("filtroNombre", nombre);
            request.setAttribute("filtroCategoria", categoriaId);
            request.setAttribute("filtroPrecioMin", precioMin);
            request.setAttribute("filtroPrecioMax", precioMax);
            
            request.getRequestDispatcher("/WEB-INF/views/cliente/productos/productos.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Los valores de precio deben ser números válidos");
            request.getRequestDispatcher("/WEB-INF/views/productos.jsp").forward(request, response);
        } catch (SQLException ex) {
            throw new ServletException("Error al buscar productos", ex);
        }

    }
    
    @Override
    public void destroy() {
        if (productoDAO != null) {
            productoDAO.cerrarConexion();
        }
    }

}
