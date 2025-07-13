package com.mycompany.patinetas.servlets;

import com.google.gson.Gson;
import com.mycompany.patinetas.models.Carrito;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "EliminarCarritoServlet", urlPatterns = {"/api/carrito/eliminar"})
public class EliminarCarritoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        
        if (carrito == null) {
            carrito = new Carrito();
            session.setAttribute("carrito", carrito);
        }
        
        try {
            int productoId = Integer.parseInt(request.getParameter("productoId"));
            carrito.eliminarItem(productoId);
            
            // Devolver el carrito actualizado
            Map<String, Object> cartData = new HashMap<>();
            cartData.put("items", carrito.getItems().toArray());
            cartData.put("total", carrito.getTotal());
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.print(new Gson().toJson(cartData));
            }
            
        } catch (NumberFormatException ex) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de producto inválido");
        }

    }

}
