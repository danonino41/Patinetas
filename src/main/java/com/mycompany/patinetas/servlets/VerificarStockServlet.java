package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "VerificarStockServlet", urlPatterns = {"/api/verificar-stock"})
public class VerificarStockServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Leer el cuerpo de la solicitud JSON
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }
        JSONArray cartItems = new JSONArray(sb.toString());
        
        ProductoDAO productoDAO = new ProductoDAO();
        List<JSONObject> updatedCart = new ArrayList<>();
        boolean allItemsAvailable = true;
        String errorMessage = null;
        
        try {
            for (int i = 0; i < cartItems.length(); i++) {
                JSONObject item = cartItems.getJSONObject(i);
                int productoId = item.getInt("id");
                int cantidadDeseada = item.getInt("quantity");
                
                int stockDisponible = productoDAO.obtenerStock(productoId);
                
                if (stockDisponible < cantidadDeseada) {
                    allItemsAvailable = false;
                    errorMessage = "No hay suficiente stock para " + item.getString("name");
                    
                    // Ajustar cantidad al máximo disponible
                    if (stockDisponible > 0) {
                        item.put("quantity", stockDisponible);
                        updatedCart.add(item);
                    }
                } else {
                    updatedCart.add(item);
                }
            }
            
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", allItemsAvailable);
            
            if (!allItemsAvailable) {
                responseJson.put("message", errorMessage);
                responseJson.put("updatedCart", updatedCart);
            }
            
            response.setContentType("application/json");
            response.getWriter().write(responseJson.toString());
            
        } catch (Exception e) {
            JSONObject errorJson = new JSONObject();
            errorJson.put("success", false);
            errorJson.put("message", "Error al verificar stock");
            
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write(errorJson.toString());
        } finally {
            productoDAO.cerrarConexion();
        }
    }

}
