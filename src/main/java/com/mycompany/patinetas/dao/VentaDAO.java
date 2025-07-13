package com.mycompany.patinetas.dao;

import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Venta;
import com.mycompany.patinetas.util.DatabaseConnection;
import java.sql.*;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


public class VentaDAO {
    private Connection con;
    private static final Logger logger = Logger.getLogger(ProductoDAO.class.getName());
    
    public VentaDAO() {
        try {
            con = DatabaseConnection.getConnection();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener conexión", ex);
        }
    }
    
    public int registrarVenta(Venta venta, List<DetalleVenta> detalles) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmtVenta = null;
        PreparedStatement pstmtDetalle = null;
        ResultSet generatedKeys = null;
        
        try {
            con.setAutoCommit(false);
            
            // Insertar venta
            String sqlVenta = "INSERT INTO venta (usuario_id, fecha, total) VALUES (?, NOW(), ?)";
            pstmtVenta = con.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS);
            pstmtVenta.setInt(1, venta.getUsuarioId());
            pstmtVenta.setDouble(2, venta.getTotal());
            pstmtVenta.executeUpdate();
            
            // Obtener ID de la venta insertada
            generatedKeys = pstmtVenta.getGeneratedKeys();
            int ventaId = 0;
            if (generatedKeys.next()) {
                ventaId = generatedKeys.getInt(1);
            }
            
            // Insertar detalles
            String sqlDetalle = "INSERT INTO detalle_venta (venta_id, producto_id, cantidad, subtotal) VALUES (?, ?, ?, ?)";
            pstmtDetalle = con.prepareStatement(sqlDetalle);
            
            for (DetalleVenta detalle : detalles) {
                pstmtDetalle.setInt(1, ventaId);
                pstmtDetalle.setInt(2, detalle.getProductoId());
                pstmtDetalle.setInt(3, detalle.getCantidad());
                pstmtDetalle.setDouble(4, detalle.getSubtotal());
                pstmtDetalle.addBatch();
            }
            
            pstmtDetalle.executeBatch();
            con.commit();
            
            return ventaId;
        } catch (SQLException ex) {
            if (conn != null) {
                conn.rollback();
            }
            throw ex;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (pstmtDetalle != null) pstmtDetalle.close();
            if (pstmtVenta != null) pstmtVenta.close();
            if (conn != null) conn.close();
        }
    }
    
    public Venta obtenerVentaPorId(int id) throws SQLException {
        // Modificamos la consulta SQL para incluir un JOIN con la tabla usuario
        String sql = "SELECT v.id, v.usuario_id, v.fecha, v.total, u.nombre as cliente_nombre " +
                     "FROM venta v JOIN usuario u ON v.usuario_id = u.id " +
                     "WHERE v.id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Venta venta = new Venta();
                    venta.setId(rs.getInt("id"));
                    venta.setUsuarioId(rs.getInt("usuario_id"));
                    venta.setFecha(rs.getTimestamp("fecha"));
                    venta.setTotal(rs.getDouble("total"));
                    venta.setClienteNombre(rs.getString("cliente_nombre"));
                    return venta;
                }
            }
        }
        return null;
    }

    public List<DetalleVenta> obtenerDetallesVenta(int ventaId) throws SQLException {
        List<DetalleVenta> detalles = new ArrayList<>();
        String sql = "SELECT dv.id, dv.producto_id, p.nombre as producto_nombre, "
                   + "dv.cantidad, dv.subtotal FROM detalle_venta dv "
                   + "JOIN producto p ON dv.producto_id = p.id "
                   + "WHERE dv.venta_id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, ventaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DetalleVenta detalle = new DetalleVenta();
                    detalle.setId(rs.getInt("id"));
                    detalle.setProductoId(rs.getInt("producto_id"));
                    detalle.setNombreProducto(rs.getString("producto_nombre"));
                    detalle.setCantidad(rs.getInt("cantidad"));
                    detalle.setSubtotal(rs.getDouble("subtotal"));
                    detalles.add(detalle);
                }
            }
        }
        return detalles;
    }
    
    public List<Venta> obtenerVentasPorUsuario(int usuarioId) throws SQLException {
        List<Venta> ventas = new ArrayList<>();
        String sql = "SELECT id, fecha, total FROM venta WHERE usuario_id = ? ORDER BY fecha DESC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Venta venta = new Venta();
                    venta.setId(rs.getInt("id"));
                    venta.setFecha(rs.getTimestamp("fecha"));
                    venta.setTotal(rs.getDouble("total"));
                    ventas.add(venta);
                }
            }
        }
        return ventas;
    }
    
    // Cerrar conexión
    public void cerrarConexion() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public List<Venta> obtenerReporteVentas(Date fechaInicio, Date fechaFin, String ordenarPor) throws SQLException {
        List<Venta> ventas = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT v.id, v.fecha, v.total, u.nombre as cliente_nombre " +
            "FROM venta v JOIN usuario u ON v.usuario_id = u.id WHERE 1=1"
        );

        // Aplicar filtros de fecha
        if (fechaInicio != null) {
            sql.append(" AND v.fecha >= ?");
        }
        if (fechaFin != null) {
            sql.append(" AND v.fecha <= ?");
        }

        // Ordenar
        if (ordenarPor != null) {
            switch (ordenarPor) {
                case "fecha_asc":
                    sql.append(" ORDER BY v.fecha ASC");
                    break;
                case "total_desc":
                    sql.append(" ORDER BY v.total DESC");
                    break;
                default: // fecha_desc
                    sql.append(" ORDER BY v.fecha DESC");
            }
        } else {
            sql.append(" ORDER BY v.fecha DESC");
        }

        try (PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (fechaInicio != null) {
                ps.setTimestamp(paramIndex++, new Timestamp(fechaInicio.getTime()));
            }
            if (fechaFin != null) {
                ps.setTimestamp(paramIndex++, new Timestamp(fechaFin.getTime()));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Venta venta = new Venta();
                    venta.setId(rs.getInt("id"));
                    venta.setFecha(rs.getTimestamp("fecha"));
                    venta.setTotal(rs.getDouble("total"));
                    venta.setClienteNombre(rs.getString("cliente_nombre"));
                    ventas.add(venta);
                }
            }
        }
        return ventas;
    }

    public Map<String, Object> obtenerEstadisticasVentas(Date fechaInicio, Date fechaFin) throws SQLException {
        Map<String, Object> estadisticas = new HashMap<>();

        String sql = "SELECT " +
                     "COUNT(*) as total_ventas, " +
                     "SUM(total) as monto_total, " +
                     "AVG(total) as promedio_venta, " +
                     "MIN(total) as venta_minima, " +
                     "MAX(total) as venta_maxima " +
                     "FROM venta WHERE 1=1";

        if (fechaInicio != null) {
            sql += " AND fecha >= ?";
        }
        if (fechaFin != null) {
            sql += " AND fecha <= ?";
        }

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            int paramIndex = 1;
            if (fechaInicio != null) {
                ps.setTimestamp(paramIndex++, new Timestamp(fechaInicio.getTime()));
            }
            if (fechaFin != null) {
                ps.setTimestamp(paramIndex++, new Timestamp(fechaFin.getTime()));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    estadisticas.put("totalVentas", rs.getInt("total_ventas"));
                    estadisticas.put("montoTotal", rs.getDouble("monto_total"));
                    estadisticas.put("promedioVenta", rs.getDouble("promedio_venta"));
                    estadisticas.put("ventaMinima", rs.getDouble("venta_minima"));
                    estadisticas.put("ventaMaxima", rs.getDouble("venta_maxima"));
                }
            }
        }

        // Productos más vendidos
        String sqlProductos = "SELECT p.nombre, SUM(dv.cantidad) as total_vendido " +
                              "FROM detalle_venta dv JOIN producto p ON dv.producto_id = p.id " +
                              "JOIN venta v ON dv.venta_id = v.id WHERE 1=1";

        if (fechaInicio != null) {
            sqlProductos += " AND v.fecha >= ?";
        }
        if (fechaFin != null) {
            sqlProductos += " AND v.fecha <= ?";
        }

        sqlProductos += " GROUP BY p.nombre ORDER BY total_vendido DESC LIMIT 5";

        try (PreparedStatement ps = con.prepareStatement(sqlProductos)) {

            int paramIndex = 1;
            if (fechaInicio != null) {
                ps.setTimestamp(paramIndex++, new Timestamp(fechaInicio.getTime()));
            }
            if (fechaFin != null) {
                ps.setTimestamp(paramIndex++, new Timestamp(fechaFin.getTime()));
            }

            List<Map<String, Object>> productosMasVendidos = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> producto = new HashMap<>();
                    producto.put("nombre", rs.getString("nombre"));
                    producto.put("totalVendido", rs.getInt("total_vendido"));
                    productosMasVendidos.add(producto);
                }
            }
            estadisticas.put("productosMasVendidos", productosMasVendidos);
        }

        return estadisticas;
    }
    
    public Map<String, Double> obtenerVentasPorDia(Date fechaInicio, Date fechaFin) throws SQLException {
        Map<String, Double> ventasPorDia = new LinkedHashMap<>();

        String sql = "SELECT DATE(fecha) as dia, SUM(total) as total_dia " +
                     "FROM venta " +
                     "WHERE fecha BETWEEN ? AND ? " +
                     "GROUP BY DATE(fecha) " +
                     "ORDER BY DATE(fecha)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            // Establecer rango de fechas (últimos 7 días si no se especifica)
            if (fechaInicio == null) {
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.DAY_OF_MONTH, -7);
                fechaInicio = cal.getTime();
            }
            if (fechaFin == null) {
                fechaFin = new Date();
            }

            ps.setTimestamp(1, new Timestamp(fechaInicio.getTime()));
            ps.setTimestamp(2, new Timestamp(fechaFin.getTime()));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Date dia = rs.getDate("dia");
                    double totalDia = rs.getDouble("total_dia");

                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM");
                    String nombreDia = sdf.format(dia);

                    ventasPorDia.put(nombreDia, totalDia);
                }
            }
        }

        return ventasPorDia;
    }
}