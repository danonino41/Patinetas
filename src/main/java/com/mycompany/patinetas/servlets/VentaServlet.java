package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.Carrito;
import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.ItemCarrito;
import com.mycompany.patinetas.models.Producto;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "VentaServlet", urlPatterns = {"/venta"})
public class VentaServlet extends HttpServlet {
    
    private VentaDAO ventaDAO;
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        ventaDAO = new VentaDAO();
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        // Validaciones iniciales
        if (carrito == null || carrito.getItems().isEmpty()) {
            
            session.setAttribute("mensajeError", "El carrito está vacío");
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        
        if (usuario == null) {
            session.setAttribute("mensajeError", "Debe iniciar sesión para finalizar la compra");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Validar stock antes de procesar
            if (!validarStockDisponible(carrito)) {
                session.setAttribute("mensajeError", "Algunos productos no tienen suficiente stock");
                response.sendRedirect(request.getContextPath() + "/checkout");
                return;
            }
            
            // Crear y registrar venta
            int ventaId = procesarVenta(usuario.getId(), carrito);
            
            // Limpiar carrito solo si todo salió bien
            carrito.vaciar();
            
            // Redirigir a confirmación con ID de venta
            response.sendRedirect(request.getContextPath() + "/confirmacion?id=" + ventaId);
            
        } catch (SQLException ex) {
            session.setAttribute("mensajeError", "Error al procesar la venta. Intente nuevamente.");
            response.sendRedirect(request.getContextPath() + "/checkout");
            // Log the error properly in production
            ex.printStackTrace();
        }
    }
    
    private boolean validarStockDisponible(Carrito carrito) throws SQLException {
        for (ItemCarrito item : carrito.getItems()) {
            Producto producto = productoDAO.obtenerPorId(item.getProducto().getId());
            if (producto == null || producto.getStock() < item.getCantidad()) {
                return false;
            }
        }
        return true;
    }
    
    private int procesarVenta(int usuarioId, Carrito carrito) throws SQLException {
        // Crear venta
        Venta venta = new Venta();
        venta.setUsuarioId(usuarioId);
        venta.setTotal(carrito.getTotal());
        
        // Crear detalles
        List<DetalleVenta> detalles = new ArrayList<>();
        for (ItemCarrito item : carrito.getItems()) {
            DetalleVenta detalle = new DetalleVenta();
            detalle.setProductoId(item.getProducto().getId());
            detalle.setNombreProducto(item.getProducto().getNombre());
            detalle.setCantidad(item.getCantidad());
            detalle.setSubtotal(item.getSubtotal());
            detalles.add(detalle);
        }
        
        // Registrar en BD
        int ventaId = ventaDAO.registrarVenta(venta, detalles);
        
        // Actualizar stock
        for (ItemCarrito item : carrito.getItems()) {
            productoDAO.actualizarStock(item.getProducto().getId(), item.getCantidad());
        }
        
        return ventaId;
    }
    
    @Override
    public void destroy() {
        if (ventaDAO != null) {
            ventaDAO.cerrarConexion();
        }
        if (productoDAO != null) {
            productoDAO.cerrarConexion();
        }
    }
}