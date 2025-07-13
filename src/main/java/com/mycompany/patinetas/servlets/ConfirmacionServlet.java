package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Usuario;
import com.mycompany.patinetas.models.Venta;
import com.mycompany.patinetas.util.EmailService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;

@WebServlet(name = "ConfirmacionServlet", urlPatterns = {"/confirmacion"})
public class ConfirmacionServlet extends HttpServlet {
    
    private VentaDAO ventaDAO;
    private ProductoDAO productoDAO;
    private EmailService emailService;
    
    @Override
    public void init() {
        ventaDAO = new VentaDAO();
        productoDAO = new ProductoDAO();
        emailService = new EmailService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String ventaIdParam = request.getParameter("id");
        
        // Validar usuario autenticado
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Validar parámetro ID
        if (ventaIdParam == null || ventaIdParam.trim().isEmpty()) {
            request.setAttribute("error", "Venta no especificada");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            return;
        }
        
        try {
            int ventaId = Integer.parseInt(ventaIdParam);
            
            // Obtener datos de la venta para mostrar en la confirmación
            Venta venta = ventaDAO.obtenerVentaPorId(ventaId);
            
            List<DetalleVenta> detalles = ventaDAO.obtenerDetallesVenta(ventaId);
            
            // Validar que la venta pertenece al usuario
            if (venta == null || venta.getUsuarioId() != usuario.getId()) {
                request.setAttribute("error", "Venta no encontrada o no autorizada");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }
            
            // Enviar correo de confirmación
            try {
                emailService.enviarConfirmacionVenta(usuario.getEmail(), venta, detalles);
            } catch (MessagingException e) {
                System.err.println("Error al enviar correo de confirmación: " + e.getMessage());
                // Puedes continuar aunque falle el correo
            }
            
            request.setAttribute("venta", venta);
            request.setAttribute("detalles", detalles);
            request.getRequestDispatcher("/WEB-INF/views/cliente/confirmacion.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de venta inválido");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ConfirmacionServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    public void destroy() {
        if (ventaDAO != null) ventaDAO.cerrarConexion();
        if (productoDAO != null) productoDAO.cerrarConexion();
    }

}
