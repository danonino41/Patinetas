package com.mycompany.patinetas.dao;

import com.mycompany.patinetas.models.Producto;
import com.mycompany.patinetas.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductoDAO {
    private Connection con;
    private static final Logger logger = Logger.getLogger(ProductoDAO.class.getName());
    
    public ProductoDAO() {
        try {
            con = DatabaseConnection.getConnection();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener conexión", ex);
        }
    }
    
    public List<Producto> listarTodos() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM producto";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setStock(rs.getInt("stock"));
                p.setImagen(rs.getString("imagen"));
                p.setCategoriaId(rs.getInt("categoria_id"));
                p.setProveedorId(rs.getInt("proveedor_id"));
                
                productos.add(p);
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al listar productos", ex);
        }
        return productos;
    }
    
    public Producto obtenerPorId(int id) {
        String sql = "SELECT * FROM producto WHERE id = ?";
        Producto producto = null;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getBigDecimal("precio"));
                    producto.setStock(rs.getInt("stock"));
                    producto.setImagen(rs.getString("imagen"));
                    producto.setCategoriaId(rs.getInt("categoria_id"));
                    producto.setProveedorId(rs.getInt("proveedor_id"));
                }
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener producto", ex);
        }
        return producto;
    }
    
    public boolean guardar(Producto producto) {
        String sql = producto.getId() == 0 ?
            "INSERT INTO producto (nombre, descripcion, precio, stock, imagen, categoria_id, proveedor_id) VALUES (?, ?, ?, ?, ?, ?, ?)" :
            "UPDATE producto SET nombre = ?, descripcion = ?, precio = ?, stock = ?, imagen = ?, categoria_id = ?, proveedor_id = ? WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getDescripcion());
            ps.setBigDecimal(3, producto.getPrecio());
            ps.setInt(4, producto.getStock());
            ps.setString(5, producto.getImagen());
            ps.setInt(6, producto.getCategoriaId());
            ps.setInt(7, producto.getProveedorId());
            
            if (producto.getId() != 0) {
                ps.setInt(8, producto.getId());
            }
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                return false;
            }
            
            if (producto.getId() == 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        producto.setId(generatedKeys.getInt(1));
                    }
                }
            }
            
            return true;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al guardar producto", ex);
            return false;
        }
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM producto WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al eliminar producto", ex);
            return false;
        }
    }
    
    public List<Producto> listarDestacados(int limite) {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM producto ORDER BY id DESC LIMIT ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limite);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setId(rs.getInt("id"));
                    p.setNombre(rs.getString("nombre"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setStock(rs.getInt("stock"));
                    p.setImagen(rs.getString("imagen"));
                    p.setCategoriaId(rs.getInt("categoria_id"));
                    p.setProveedorId(rs.getInt("proveedor_id"));

                    productos.add(p);
                }
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al listar productos destacados", ex);
        }
        return productos;
    }
    
    public List<Producto> listarEnOferta(int limite) {
        List<Producto> productos = new ArrayList<>();
        // Suponiendo que tenemos un campo 'descuento' en la tabla producto
        // String sql = "SELECT * FROM producto WHERE descuento > 0 ORDER BY descuento DESC LIMIT ?";
        String sql = "SELECT * FROM producto ORDER BY id DESC LIMIT ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limite);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setId(rs.getInt("id"));
                    p.setNombre(rs.getString("nombre"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setPrecio(rs.getBigDecimal("precio"));
                    p.setStock(rs.getInt("stock"));
                    p.setImagen(rs.getString("imagen"));
                    p.setCategoriaId(rs.getInt("categoria_id"));
                    p.setProveedorId(rs.getInt("proveedor_id"));
                    // p.setDescuento(rs.getInt("descuento"));

                    productos.add(p);
                }
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al listar productos en oferta", ex);
        }
        return productos;
    }
    
    public int obtenerStock(int productoId) {
        String sql = "SELECT stock FROM producto WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productoId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("stock") : 0;
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener stock", ex);
            return 0;
        }
    }

    public boolean reducirStock(int productoId, int cantidad) {
        String sql = "UPDATE producto SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cantidad);
            ps.setInt(2, productoId);
            ps.setInt(3, cantidad);

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al reducir stock", ex);
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
