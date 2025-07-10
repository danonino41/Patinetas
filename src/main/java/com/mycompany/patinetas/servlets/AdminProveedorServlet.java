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
            // Editar proveedor
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("proveedor", proveedorDAO.obtenerPorId(id));
            request.getRequestDispatcher("/WEB-INF/views/admin/proveedores/formulario.jsp").forward(request, response);
        } else if (action.equals("/eliminar")) {
            // Eliminar proveedor
            int id = Integer.parseInt(request.getParameter("id"));
            proveedorDAO.eliminar(id);
            response.sendRedirect(request.getContextPath() + "/admin/proveedores");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Proveedor proveedor = new Proveedor();
        proveedor.setNombre(request.getParameter("nombre"));
        proveedor.setDireccion(request.getParameter("direccion"));
        proveedor.setTelefono(request.getParameter("telefono"));
        proveedor.setEmail(request.getParameter("email"));
        
        // Obtener parámetros del formulario
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            proveedor.setId(Integer.parseInt(idParam));
        }
        
        // Guardar el producto
        if (proveedorDAO.guardar(proveedor)) {
            request.getSession().setAttribute("success", 
                proveedor.getId() == 0 ? "Proveedor creado correctamente" : "Proveedor actualizado correctamente");
        } else {
            request.getSession().setAttribute("error", 
                "No se pudo guardar el proveedor");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/proveedores");

    }
    
    @Override
    public void destroy() {
        proveedorDAO.cerrarConexion();
    }

}
