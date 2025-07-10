package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Venta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "ProcesarPagoServlet", urlPatterns = {"/procesar-pago"})
public class ProcesarPagoServlet extends HttpServlet {

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
        JSONObject json = new JSONObject(sb.toString());
        
        JSONArray items = json.getJSONArray("items");
        String paymentMethod = json.getString("paymentMethod");
        BigDecimal subtotal = json.getBigDecimal("subtotal");
        BigDecimal igv = json.getBigDecimal("igv");
        BigDecimal total = json.getBigDecimal("total");
        
        // Obtener ID de usuario de la sesión
        Integer usuarioId = (Integer) request.getSession().getAttribute("usuarioId");
        
        if (usuarioId == null) {
            // sendErrorResponse(response, "Debe iniciar sesión para realizar una compra");
            request.getSession().setAttribute("error", "Debe iniciar sesión para realizar una compra");
            return;
        }
        
        VentaDAO ventaDAO = new VentaDAO();
        ProductoDAO productoDAO = new ProductoDAO();
        
        try {
            // Crear la venta
            Venta venta = new Venta();
            venta.setUsuarioId(usuarioId);
            venta.setFecha(LocalDateTime.now());
            venta.setTotal(total);
            
            // Guardar la venta
            int ventaId = ventaDAO.crearVenta(venta);
            
            // Procesar cada item
            for (int i = 0; i < items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                int productoId = item.getInt("id");
                int cantidad = item.getInt("quantity");
                BigDecimal precio = item.getBigDecimal("price");
                BigDecimal descuento = new BigDecimal(item.getDouble("discount"));
                BigDecimal subtotala = precio.multiply(BigDecimal.valueOf(cantidad));

                
                // Crear detalle de venta
                DetalleVenta detalle = new DetalleVenta();
                detalle.setVentaId(ventaId);
                detalle.setProductoId(productoId);
                detalle.setCantidad(cantidad);
                detalle.setSubtotal(subtotal);
                
                // Guardar detalle
                ventaDAO.crearDetalleVenta(detalle);
                
                // Actualizar stock
                productoDAO.reducirStock(productoId, cantidad);
            }
            
            // Generar código de confirmación
            String codigo = "PED-" + ventaId + "-" + System.currentTimeMillis();
            
            // Enviar respuesta exitosa
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", true);
            responseJson.put("codigo", codigo);
            
            response.setContentType("application/json");
            response.getWriter().write(responseJson.toString());
            
        } catch (Exception e) {
            // sendErrorResponse(response, "Error al procesar el pago: " + e.getMessage());
            request.getSession().setAttribute("error", "Error al procesar el pago");
        } finally {
            ventaDAO.cerrarConexion();
            productoDAO.cerrarConexion();
        }

    }

}
