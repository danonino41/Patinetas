package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.CategoriaDAO;
import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.dao.ProveedorDAO;
import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.dao.VentaDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    private CategoriaDAO categoriaDAO;
    private ProductoDAO productoDAO;
    private ProveedorDAO proveedorDAO;
    private VentaDAO ventaDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
        categoriaDAO = new CategoriaDAO();
        productoDAO = new ProductoDAO();
        proveedorDAO = new ProveedorDAO();
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("totalUsuarios", usuarioDAO.contarUsuarios());
            request.setAttribute("totalCategorias", categoriaDAO.contarCategorias());
            request.setAttribute("totalProductos", productoDAO.contarProductos());
            request.setAttribute("totalProveedores", proveedorDAO.contarProveedores());
            request.setAttribute("totalVentas", ventaDAO.contarVentas());
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException ex) {
            throw new ServletException("Error al procesar solicitud", ex);
        }
    }
    
    @Override
    public void destroy() {
        if (usuarioDAO != null) {
            usuarioDAO.cerrarConexion();
        }
    }

}
