package com.mycompany.patinetas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mycompany.patinetas.models.Usuario;
import com.mycompany.patinetas.util.DatabaseConnection;
import com.mycompany.patinetas.util.PasswordUtil;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsuarioDAO {
    
    private Connection con;
    
    public UsuarioDAO() {
        try {
            con = DatabaseConnection.getConnection();
            System.out.println("[DEBUG]: Se creo la conexión a la base de datos");
        } catch (SQLException ex) {
            System.out.println("[DEBUG]: No se establecion conexión a la base de datos.");
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    // Registrar nuevo usuario
    public boolean registrarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuario (nombre, email, contraseña, rol) VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            
            // Generar hash de la contraseña
            String hashedPassword = PasswordUtil.hashPassword(usuario.getContraseña());
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, hashedPassword); // Almacenar el hash, no la contraseña en texto plano
            ps.setString(4, usuario.getRol());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // Obtener usuario por email y contraseña
    public Usuario obtenerUsuario(String email, String plainPassword) {
        String sql = "SELECT * FROM usuario WHERE email = ? LIMIT 1";
        Usuario usuario = null;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    String storedHash = rs.getString("contraseña");
                    usuario.setRol(rs.getString("rol"));
                    
                    // Verificar contraseña
                    if (!PasswordUtil.checkPassword(plainPassword, storedHash)) {
                        return null; // Contraseña incorrecta
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return usuario;
    }
    
        // Obtener usuario por email y contraseña
    public Usuario obtenerPorEmail(String email) {
        String sql = "SELECT * FROM usuario WHERE email = ? LIMIT 1";
        Usuario usuario = null;
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    String storedHash = rs.getString("contraseña");
                    usuario.setRol(rs.getString("rol"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return usuario;
    }
    
    // Verificar si el email ya existe
    public boolean existeEmail(String email) {
        String sql = "SELECT id FROM usuario WHERE email = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public boolean guardarResetToken(int usuarioId, String token) {
        String sql = "UPDATE usuario SET reset_token = ?, token_expiration = DATE_ADD(NOW(), INTERVAL 1 HOUR) WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.setInt(2, usuarioId);

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Usuario obtenerPorResetToken(String token) {
        String sql = "SELECT id, nombre, email FROM usuario WHERE reset_token = ? AND token_expiration > NOW()";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, token);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    return usuario;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean actualizarContraseña(int usuarioId, String nuevaContraseña) {
        String sql = "UPDATE usuario SET contraseña = ?, reset_token = NULL, token_expiration = NULL WHERE id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, PasswordUtil.hashPassword(nuevaContraseña));
            ps.setInt(2, usuarioId);

            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
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
}
