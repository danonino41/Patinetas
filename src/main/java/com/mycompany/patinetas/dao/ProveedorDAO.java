package com.mycompany.patinetas.dao;

import com.mycompany.patinetas.models.Proveedor;
import com.mycompany.patinetas.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProveedorDAO {
    private Connection con;
    private static final Logger logger = Logger.getLogger(ProductoDAO.class.getName());
    
    public ProveedorDAO() {
        try {
            con = DatabaseConnection.getConnection();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener conexión", ex);
        }
    }
    
    public List<Proveedor> listarTodos() {
        List<Proveedor> proveedores = new ArrayList<>();
        String sql = "SELECT * FROM proveedor";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setDireccion(rs.getString("direccion"));
                p.setTelefono(rs.getString("telefono"));
                p.setEmail(rs.getString("email"));
                proveedores.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return proveedores;
    }
    
    public Proveedor obtenerPorId(int id) {
        String sql = "SELECT * FROM proveedor WHERE id = ?";
        Proveedor proveedor = null;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    proveedor = new Proveedor();
                    proveedor.setId(rs.getInt("id"));
                    proveedor.setNombre(rs.getString("nombre"));
                    proveedor.setTelefono(rs.getString("telefono"));
                    proveedor.setEmail(rs.getString("email"));
                }
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener proveedor", ex);
        }
        return proveedor;
    }
    
    public boolean guardar(Proveedor proveedor) {
        String sql = proveedor.getId() == 0 ?
            "INSERT INTO proveedor (nombre, direccion, telefono, email) VALUES (?, ?, ?, ?)" :
            "UPDATE proveedor SET nombre = ?, direccion = ?, telefono = ?, email = ? WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, proveedor.getNombre());
            ps.setString(2, proveedor.getDireccion());
            ps.setString(3, proveedor.getTelefono());
            ps.setString(4, proveedor.getEmail());
            
            
            if (proveedor.getId() != 0) {
                ps.setInt(8, proveedor.getId());
            }
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                return false;
            }
            
            if (proveedor.getId() == 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        proveedor.setId(generatedKeys.getInt(1));
                    }
                }
            }
            
            return true;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al guardar proveedor", ex);
            return false;
        }
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM proveedor WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al eliminar proveedor", ex);
            return false;
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
