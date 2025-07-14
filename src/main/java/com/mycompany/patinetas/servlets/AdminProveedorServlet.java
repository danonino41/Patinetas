package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.ProveedorDAO;
import com.mycompany.patinetas.models.Proveedor;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminProveedorServlet", urlPatterns = {"/admin/proveedores/*"})
public class AdminProveedorServlet extends HttpServlet {
    private ProveedorDAO proveedorDAO;
    
    @Override
    public void init() {
        proveedorDAO = new ProveedorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            // Listar proveedores
            request.setAttribute("proveedores", proveedorDAO.listarTodos());
            request.getRequestDispatcher("/WEB-INF/views/admin/proveedores/listar.jsp").forward(request, response);
        } else if (action.equals("/nuevo")) {
            // Mostrar formulario
            request.setAttribute("proveedor", new Proveedor());
            request.getRequestDispatcher("/WEB-INF/views/admin/proveedores/formulario.jsp").forward(request, response);
        } else if (action.equals("/editar")) {
            // Mostrar formulario para editar proveedor
            int id = Integer.parseInt(request.getParameter("id"));
            Proveedor proveedor = proveedorDAO.obtenerPorId(id);
            
            if (proveedor != null) {
                request.setAttribute("proveedor", proveedor);
                request.getRequestDispatcher("/WEB-INF/views/admin/proveedores/formulario.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else if (action.equals("/eliminar")) {
            // Eliminar proveedor
            int id = Integer.parseInt(request.getParameter("id"));
            if (proveedorDAO.eliminar(id)) {
                request.getSession().setAttribute("success", "Proveedor eliminado correctamente");
            } else {
                request.getSession().setAttribute("error", "No se pudo eliminar el proveedor");
            }
            response.sendRedirect(request.getContextPath() + "/admin/proveedores");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            Proveedor proveedor = new Proveedor();
            
            // Obtener parámetros del formulario
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                proveedor.setId(Integer.parseInt(idParam));
            }
            
            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            
            // Validaciones de campos
            if (nombre.isEmpty() || direccion.isEmpty() || telefono.isEmpty() || email.isEmpty()) {
                request.getSession().setAttribute("mensajeError", "Nombre, dirección, teléfono y correo son obligatorios");
                response.sendRedirect(request.getContextPath() + "/admin/proveedores/nuevo");
                return;
            }
            
            proveedor.setNombre(nombre);
            proveedor.setDireccion(direccion);
            proveedor.setTelefono(telefono);
            proveedor.setEmail(email);
            
            // Guardar el proveedor
            if (proveedorDAO.guardar(proveedor)) {
                request.getSession().setAttribute("success", 
                    proveedor.getId() == null ? "Proveedor creado correctamente" : "Proveedor actualizado correctamente");
            } else {
                request.getSession().setAttribute("error", 
                    "No se pudo guardar el proveedor");
            }

            response.sendRedirect(request.getContextPath() + "/admin/proveedores");
        }

    }
    
    @Override
    public void destroy() {
        proveedorDAO.cerrarConexion();
    }

}
