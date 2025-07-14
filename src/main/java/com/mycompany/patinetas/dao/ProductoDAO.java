package com.mycompany.patinetas.dao;

import com.mycompany.patinetas.models.Categoria;
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
            System.out.println("[DEBUG]: Se creo la conexión a la base de datos para ProductoDAO");
        } catch (SQLException ex) {
            System.out.println("[DEBUG]: No creo la conexión a la base de datos para ProductoDAO");
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
    
    public void actualizarStock(int productoId, int cantidad) throws SQLException {
        String sql = "UPDATE producto SET stock = stock - ? WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, cantidad);
            ps.setInt(2, productoId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al actualizar stock", ex);
        }
    }
    
    public List<Producto> obtenerProductosPorCategoriaId(int categoriaId) {
        List<Producto> productos = new ArrayList<>();
        String sql =
            "SELECT p.id, p.nombre, p.descripcion, p.precio, p.stock, p.imagen " +
            "FROM producto p " +
            "WHERE p.categoria_id = ? " +
            "ORDER BY p.nombre";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoriaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Producto producto = new Producto();
                    producto.setId(rs.getInt("id"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getBigDecimal("precio"));
                    producto.setStock(rs.getInt("stock"));
                    producto.setImagen(rs.getString("imagen"));
                    
                    productos.add(producto);
                }
            }
            
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener los productos", ex);
            return null;
        }
        return productos;
    }
    
    public List<Producto> filtrarProductos(Integer categoriaId, Double precioMin, Double precioMax, String nombre) throws SQLException {
        List<Producto> productos = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT p.id, p.nombre, p.descripcion, p.precio, p.stock, p.imagen, p.categoria_id, c.nombre as categoria_nombre " +
                                            "FROM producto p LEFT JOIN categoria c ON p.categoria_id = c.id WHERE 1=1");

        // Parámetros para la consulta preparada
        List<Object> parametros = new ArrayList<>();

        if (categoriaId != null) {
            sql.append(" AND p.categoria_id = ?");
            parametros.add(categoriaId);
        }

        if (precioMin != null) {
            sql.append(" AND p.precio >= ?");
            parametros.add(precioMin);
        }

        if (precioMax != null) {
            sql.append(" AND p.precio <= ?");
            parametros.add(precioMax);
        }

        if (nombre != null && !nombre.trim().isEmpty()) {
            sql.append(" AND p.nombre LIKE ?");
            parametros.add("%" + nombre + "%");
        }

        sql.append(" ORDER BY p.nombre");

        try (PreparedStatement ps = con.prepareStatement(sql.toString())) {

            // Asignar parámetros
            for (int i = 0; i < parametros.size(); i++) {
                ps.setObject(i + 1, parametros.get(i));
            }

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
                    p.setCategoriaNombre(rs.getString("categoria_nombre"));

                    productos.add(p);
                }
            }
        }
        return productos;
    }

    public List<Categoria> obtenerTodasCategorias() throws SQLException {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT id, nombre FROM categoria ORDER BY nombre";

        try (PreparedStatement ps = con.prepareStatement(sql);
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                categorias.add(c);
            }
        }
        return categorias;
    }
    
    public int contarProductos() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM producto";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            return 0;
        }
    }
    
    public void cerrarConexion() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("[DEBUG]: Se cerro la conecion a la base de datos para ProductoDAO");
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al cerrar conexión", ex);
        }
    }
}
