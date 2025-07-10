package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.CategoriaDAO;
import com.mycompany.patinetas.models.Categoria;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCategoriaServlet", urlPatterns = {"/admin/categorias/*"})
public class AdminCategoriaServlet extends HttpServlet {
    private CategoriaDAO categoriaDAO;
    
    @Override
    public void init() {
        categoriaDAO = new CategoriaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            // Listar categorías
            request.setAttribute("categorias", categoriaDAO.listarTodas());
            request.getRequestDispatcher("/WEB-INF/views/admin/categorias/listar.jsp").forward(request, response);
        } else if (action.equals("/nuevo")) {
            // Mostrar formulario
            request.setAttribute("categoria", new Categoria());
            request.getRequestDispatcher("/WEB-INF/views/admin/categorias/formulario.jsp").forward(request, response);
        } else if (action.equals("/editar")) {
            // Editar categoría
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("categoria", categoriaDAO.obtenerPorId(id));
            request.getRequestDispatcher("/WEB-INF/views/admin/categorias/formulario.jsp").forward(request, response);
        } else if (action.equals("/eliminar")) {
            // Eliminar categoría
            int id = Integer.parseInt(request.getParameter("id"));
            categoriaDAO.eliminar(id);
            response.sendRedirect(request.getContextPath() + "/admin/categorias");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Categoria categoria = new Categoria();
        categoria.setNombre(request.getParameter("nombre"));
        categoria.setDescripcion(request.getParameter("descripcion"));
        
        // Obtener parámetros del formulario
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            categoria.setId(Integer.parseInt(idParam));
        }
        
        // Guardar el producto
        if (categoriaDAO.guardar(categoria)) {
            request.getSession().setAttribute("success", 
                categoria.getId() == 0 ? "Categoria creado correctamente" : "Categoria actualizado correctamente");
        } else {
            request.getSession().setAttribute("error", 
                "No se pudo guardar la categoria");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/categorias");

    }
    
    @Override
    public void destroy() {
        categoriaDAO.cerrarConexion();
    }

}
