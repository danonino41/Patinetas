package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.models.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminUsuariosServlet", urlPatterns = {"/admin/usuarios"})
public class AdminUsuariosServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String accion = request.getParameter("accion");
            
            if ("nuevo".equals(accion)) {
                mostrarFormularioRegistro(request, response);
                return;
            }
            
            if ("editar".equals(accion)) {
                mostrarFormularioEdicion(request, response);
                return;
            }
            
            if ("eliminar".equals(accion)) {
                eliminarUsuario(request, response);
                return;
            }
            
            // Listado por defecto
            List<Usuario> usuarios = usuarioDAO.listarTodosUsuarios();
            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/usuarios.jsp").forward(request, response);
            
        } catch (SQLException ex) {
            throw new ServletException("Error al gestionar usuarios", ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String accion = request.getParameter("accion");
            
            if ("registrar".equals(accion)) {
                registrarUsuario(request, response);
                return;
            }
            
            if ("actualizar".equals(accion)) {
                actualizarUsuario(request, response);
                return;
            }
            
            if ("buscar".equals(accion)) {
                buscarUsuarios(request, response);
                return;
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/usuarios");
            
        } catch (SQLException ex) {
            throw new ServletException("Error al procesar solicitud", ex);
        }

    }
    
    private void mostrarFormularioRegistro(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {

        Usuario usuario = new Usuario();
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/formulario.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario usuario = usuarioDAO.obtenerPorId(id);
        
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/formulario.jsp").forward(request, response);
    }
    
    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("contraseña");
        String rol = request.getParameter("rol");

        // Validaciones de campos
        if (nombre.isEmpty() || email.isEmpty() || rol.isEmpty()) {
            request.getSession().setAttribute("mensajeError", "Nombre, email y rol son obligatorios");
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?accion=nuevo");
            return;
        }
        
        // Validar si existe el email en la base de datos
        if (usuarioDAO.existeEmail(email)) {
            request.getSession().setAttribute("mensajeError", "El email ya está registrado");
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?accion=nuevo");
            return;
        }

        // Validación de contraseña si se proporciona
        if (contraseña != null && !contraseña.trim().isEmpty()) {
            if (contraseña.length() < 8) {
                request.getSession().setAttribute("mensajeError", "La contraseña debe tener al menos 8 caracteres");
                response.sendRedirect(request.getContextPath() + "/admin/usuarios?accion=nuevo");
                return;
            }
        }
        
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setContraseña(contraseña);
        usuario.setRol(rol);
        
        try {
            usuarioDAO.registrarUsuario(usuario);
            request.getSession().setAttribute("mensajeExito", "Usuario registrado correctamente");
            response.sendRedirect(request.getContextPath() + "/admin/usuarios");
        } catch (SQLException e) {
            request.getSession().setAttribute("mensajeError", "Error al registrar el usuario");
            e.printStackTrace();
        }
  
    }
    
    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("contraseña");
        String rol = request.getParameter("rol");
        
        Usuario usuario = new Usuario();
        usuario.setId(id);
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setRol(rol);
        
        // Obtener el usuario actual para comparar emails
        Usuario usuarioActual = usuarioDAO.obtenerPorId(id);
        
        // Validaciones de campos
        if (nombre.isEmpty() || email.isEmpty() || rol.isEmpty()) {
            request.getSession().setAttribute("mensajeError", "Nombre, email y rol son obligatorios");
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?accion=editar&id=" + id);
            return;
        }
        
        // Validar si el email ya existe (excluyendo al usuario actual)
        if (usuarioDAO.existeEmailForUpdate(email, id)) {
            request.getSession().setAttribute("mensajeError", "El email ya está registrado");
            response.sendRedirect(request.getContextPath() + "/admin/usuarios?accion=editar&id=" + id);
            return;
        }

        // Validación de contraseña si se proporciona
        if (contraseña != null && !contraseña.trim().isEmpty()) {
            if (contraseña.length() < 8) {
                request.getSession().setAttribute("mensajeError", "La contraseña debe tener al menos 8 caracteres");
                response.sendRedirect(request.getContextPath() + "/admin/usuarios?accion=editar&id=" + id);
                return;
            }
        }

        // Solo actualizar contraseña si se proporcionó
        if (contraseña != null && !contraseña.trim().isEmpty()) {
            usuario.setContraseña(contraseña);
        }
        
        try {
            usuarioDAO.actualizarUsuario(usuario);
            request.getSession().setAttribute("mensajeExito", "Usuario actualizado correctamente");
            response.sendRedirect(request.getContextPath() + "/admin/usuarios");
        } catch (SQLException e) {
            request.getSession().setAttribute("mensajeError", "Error al actualizar el usuario");
            e.printStackTrace();
        }

    }
    
    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        usuarioDAO.eliminarUsuario(id);
        
        request.getSession().setAttribute("mensajeExito", "Usuario eliminado correctamente");
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }
    
    private void buscarUsuarios(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String busqueda = request.getParameter("busqueda");
        List<Usuario> usuarios = usuarioDAO.buscarUsuarios(busqueda);
        
        request.setAttribute("usuarios", usuarios);
        request.setAttribute("busqueda", busqueda);
        request.getRequestDispatcher("/WEB-INF/views/admin/usuarios/usuarios.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        if (usuarioDAO != null) {
            usuarioDAO.cerrarConexion();
        }
    }

}
