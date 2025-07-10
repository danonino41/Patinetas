package com.mycompany.patinetas.dao;

import com.mycompany.patinetas.models.DetalleVenta;
import com.mycompany.patinetas.models.Venta;
import com.mycompany.patinetas.util.DatabaseConnection;
import java.sql.*;
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
    
    public int crearVenta(Venta venta) throws SQLException {
        String sql = "INSERT INTO venta (usuario_id, fecha, total) VALUES (?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, venta.getUsuarioId());
            ps.setObject(2, venta.getFecha());
            ps.setBigDecimal(3, venta.getTotal());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        throw new SQLException("No se pudo obtener el ID de la venta");
    }

    public boolean crearDetalleVenta(DetalleVenta detalle) throws SQLException {
        String sql = "INSERT INTO detalle_venta (venta_id, producto_id, cantidad, subtotal) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, detalle.getVentaId());
            ps.setInt(2, detalle.getProductoId());
            ps.setInt(3, detalle.getCantidad());
            ps.setBigDecimal(4, detalle.getSubtotal());

            return ps.executeUpdate() > 0;
        }
    }
    
    public void cerrarConexion() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al cerrar conexión", ex);
        }
    }
    
}
