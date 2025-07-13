package com.mycompany.patinetas.servlets;

import com.google.gson.Gson;
import com.mycompany.patinetas.models.Carrito;
import com.mycompany.patinetas.models.ItemCarrito;
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

@WebServlet(name = "CarritoApiServlet", urlPatterns = {"/api/carrito"})
public class CarritoApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Map<String, Object> cartData = new HashMap<>();
        
        if (carrito == null || carrito.getItems().isEmpty()) {
            cartData.put("items", new ItemCarrito[0]);
            cartData.put("total", 0);
        } else {
            cartData.put("items", carrito.getItems().toArray());
            cartData.put("total", carrito.getTotal());
        }
        
        try (PrintWriter out = response.getWriter()) {
            out.print(new Gson().toJson(cartData));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
