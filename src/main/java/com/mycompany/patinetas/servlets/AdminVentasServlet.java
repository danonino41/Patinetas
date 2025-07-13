package com.mycompany.patinetas.servlets;

import com.google.gson.Gson;
import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.Venta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminVentasServlet", urlPatterns = {"/admin/reportes-ventas"})
public class AdminVentasServlet extends HttpServlet {
    
    private VentaDAO ventaDAO;
    
    @Override
    public void init() {
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener parámetros de filtro
            String fechaInicioStr = request.getParameter("fechaInicio");
            String fechaFinStr = request.getParameter("fechaFin");
            String ordenarPor = request.getParameter("ordenarPor");
            
            // Parsear fechas
            Date fechaInicio = null;
            Date fechaFin = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            if (fechaInicioStr != null && !fechaInicioStr.isEmpty()) {
                fechaInicio = sdf.parse(fechaInicioStr);
            }
            if (fechaFinStr != null && !fechaFinStr.isEmpty()) {
                fechaFin = sdf.parse(fechaFinStr);
            }
            
            // Obtener reportes
            List<Venta> ventas = ventaDAO.obtenerReporteVentas(fechaInicio, fechaFin, ordenarPor);
            double totalVentas = ventas.stream().mapToDouble(Venta::getTotal).sum();
            int totalVentasCount = ventas.size();
            
            // Estadísticas adicionales
            Map<String, Object> estadisticas = ventaDAO.obtenerEstadisticasVentas(fechaInicio, fechaFin);
            
            // Pasar datos a la vista
            request.setAttribute("ventas", ventas);
            request.setAttribute("totalVentas", totalVentas);
            request.setAttribute("totalVentasCount", totalVentasCount);
            request.setAttribute("estadisticas", estadisticas);
            request.setAttribute("fechaInicio", fechaInicioStr);
            request.setAttribute("fechaFin", fechaFinStr);
            request.setAttribute("ordenarPor", ordenarPor);
            
            // En el método doGet, después de obtener los datos:
            Map<String, Double> ventasPorDia = ventaDAO.obtenerVentasPorDia(fechaInicio, fechaFin);

            // Convertir a listas para JSON
            List<String> labels = new ArrayList<>(ventasPorDia.keySet());
            List<Double> data = new ArrayList<>(ventasPorDia.values());

            // Usar Gson para serialización segura
            Gson gson = new Gson();
            request.setAttribute("ventasPorDiaLabels", gson.toJson(labels));
            request.setAttribute("ventasPorDiaData", gson.toJson(data));
            request.getRequestDispatcher("/WEB-INF/views/admin/ventas/reportes_ventas.jsp").forward(request, response);
            
        } catch (ParseException | SQLException ex) {
            throw new ServletException("Error al generar reportes", ex);
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
