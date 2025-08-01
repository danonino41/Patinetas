package com.mycompany.patinetas.dao;

import com.mycompany.patinetas.models.Categoria;
import com.mycompany.patinetas.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CategoriaDAO {
    private Connection con;
    private static final Logger logger = Logger.getLogger(ProductoDAO.class.getName());
    
    public CategoriaDAO() {
        try {
            con = DatabaseConnection.getConnection();
            System.out.println("[DEBUG]: Se creo la conexión a la base de datos para CategoriaDAO");
        } catch (SQLException ex) {
            System.out.println("[DEBUG]: No creo la conexión a la base de datos para CategoriaDAO");
            logger.log(Level.SEVERE, "Error al obtener conexión", ex);
        }
    }
    
    public List<Categoria> listarTodas() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT * FROM categoria";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                c.setDescripcion(rs.getString("descripcion"));
                categorias.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return categorias;
    }
    
    public Categoria obtenerPorId(int id) {
        String sql = "SELECT * FROM categoria WHERE id = ?";
        Categoria categoria = null;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    categoria = new Categoria();
                    categoria.setId(rs.getInt("id"));
                    categoria.setNombre(rs.getString("nombre"));
                    categoria.setDescripcion(rs.getString("descripcion"));
                }
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al obtener categoria", ex);
            return null;
        }
        return categoria;
    }
    
    public boolean guardar(Categoria categoria) {
        String sql = categoria.getId() == null ?
            "INSERT INTO categoria (nombre, descripcion) VALUES (?, ?)" :
            "UPDATE categoria SET nombre = ?, descripcion = ? WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            
            if (categoria.getId() != null) {
                ps.setInt(3, categoria.getId());
            }
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                return false;
            }
            
            if (categoria.getId() == null) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        categoria.setId(generatedKeys.getInt(1));
                    }
                }
            }
            
            return true;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al guardar categoria", ex);
            return false;
        }
    }
    
    public boolean eliminar(int id) {
        String sql = "DELETE FROM categoria WHERE id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al eliminar categoria", ex);
            return false;
        }
    }
    
    public int contarCategorias() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM categoria";
        
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
                System.out.println("[DEBUG]: Se cerro la conecion a la base de datos para CategoriaDAO");
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Error al cerrar conexión", ex);
        }
    }

}
