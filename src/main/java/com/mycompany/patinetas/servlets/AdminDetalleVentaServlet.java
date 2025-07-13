package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Venta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminDetalleVentaServlet", urlPatterns = {"/admin/detalle-venta"})
public class AdminDetalleVentaServlet extends HttpServlet {
    
    private VentaDAO ventaDAO;
    
    @Override
    public void init() {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String ventaIdParam = request.getParameter("id");
        
        if (ventaIdParam == null || ventaIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/reportes-ventas");
            return;
        }
        
        try {
            int ventaId = Integer.parseInt(ventaIdParam);
            Venta venta = ventaDAO.obtenerVentaPorId(ventaId);
            List<DetalleVenta> detalles = ventaDAO.obtenerDetallesVenta(ventaId);
            
            if (venta == null) {
                response.sendRedirect(request.getContextPath() + "/admin/reportes-ventas");
                return;
            }
            
            request.setAttribute("venta", venta);
            request.setAttribute("detalles", detalles);
            request.getRequestDispatcher("/WEB-INF/views/admin/ventas/detalle_venta.jsp").forward(request, response);
            
        } catch (NumberFormatException | SQLException ex) {
            throw new ServletException("Error al cargar el detalle de venta", ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    public void destroy() {
        if (ventaDAO != null) {
            ventaDAO.cerrarConexion();
        }
    }

}
