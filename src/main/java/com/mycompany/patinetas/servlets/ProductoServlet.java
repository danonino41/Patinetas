package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.models.Producto;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/productos"})
public class ProductoServlet extends HttpServlet {
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            // Mostrar detalle de un producto
            int id = Integer.parseInt(idParam);
            Producto producto = productoDAO.obtenerPorId(id);
            
            if (producto != null) {
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("/WEB-INF/views/cliente/productos/detalle.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            // Listar todos los productos
            List<Producto> productos = productoDAO.listarTodos();
            request.setAttribute("productos", productos);
            request.getRequestDispatcher("/WEB-INF/views/productos/listar.jsp").forward(request, response);
        }

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
