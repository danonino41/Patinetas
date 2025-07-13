package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.models.Carrito;
import com.mycompany.patinetas.models.Producto;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        
        if (carrito == null) {
            carrito = new Carrito();
            session.setAttribute("carrito", carrito);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/cliente/checkout.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        
        if (carrito == null) {
            carrito = new Carrito();
            session.setAttribute("carrito", carrito);
        }
        
        ProductoDAO productoDAO = new ProductoDAO();
        if ("add".equals(action)) {
            int productoId = Integer.parseInt(request.getParameter("id"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            
            Producto producto = productoDAO.obtenerPorId(productoId);
            if (producto != null) {
                carrito.agregarItem(producto, cantidad);
            }
            
            if (cantidad > producto.getStock()) {
                return;
            }
            
        } else if ("remove".equals(action)) {
            int productoId = Integer.parseInt(request.getParameter("id"));
            carrito.eliminarItem(productoId);
            
        } else if ("update".equals(action)) {
            int productoId = Integer.parseInt(request.getParameter("id"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            carrito.actualizarCantidad(productoId, cantidad);
        }
        response.sendRedirect(request.getContextPath() + "/checkout");

    }

}
