package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.UsuarioDAO;
import com.mycompany.patinetas.dao.VentaDAO;
import com.mycompany.patinetas.models.Usuario;
import com.mycompany.patinetas.models.Venta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "PerfilServlet", urlPatterns = {"/perfil"})
public class PerfilServlet extends HttpServlet {
    
    private UsuarioDAO usuarioDAO;
    private VentaDAO ventaDAO;
    
    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
        ventaDAO = new VentaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            
            if (usuario == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            // Obtener datos actualizados del usuario
            Usuario usuarioActualizado = usuarioDAO.obtenerPorId(usuario.getId());
            // Obtener historial de compras
            List<Venta> historialCompras = ventaDAO.obtenerVentasPorUsuario(usuario.getId());
            // Actualizar usuario en sesión
            session.setAttribute("usuario", usuarioActualizado);
            // Pasar datos a la vista
            request.setAttribute("usuario", usuarioActualizado);
            request.setAttribute("historialCompras", historialCompras);
            request.getRequestDispatcher("/WEB-INF/views/cliente/perfil/perfil.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(PerfilServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    @Override
    public void destroy() {
        if (usuarioDAO != null) {
            usuarioDAO.cerrarConexion();
        }
        if (ventaDAO != null) {
            ventaDAO.cerrarConexion();
        }
    }


}
