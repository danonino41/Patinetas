package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Usuario;
import com.mycompany.patinetas.models.Venta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DetalleVentaServlet", urlPatterns = {"/detalle-venta"})
public class DetalleVentaServlet extends HttpServlet {
    
    private VentaDAO ventaDAO;
    
    @Override
    public void init() {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String ventaIdParam = request.getParameter("id");
        
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (ventaIdParam == null || ventaIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/perfil");
            return;
        }
        
        try {
            int ventaId = Integer.parseInt(ventaIdParam);
            Venta venta = ventaDAO.obtenerVentaPorId(ventaId);
            
            // Verificar que la venta pertenece al usuario
            if (venta == null || venta.getUsuarioId() != usuario.getId()) {
                response.sendRedirect(request.getContextPath() + "/perfil");
                return;
            }
            
            List<DetalleVenta> detalles = ventaDAO.obtenerDetallesVenta(ventaId);
            
            request.setAttribute("venta", venta);
            request.setAttribute("detalles", detalles);
            request.getRequestDispatcher("/WEB-INF/views/cliente/perfil/detalle-venta.jsp").forward(request, response);
            
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
