package com.mycompany.patinetas.servlets;

import com.mycompany.patinetas.dao.CategoriaDAO;
import com.mycompany.patinetas.dao.ProductoDAO;
import com.mycompany.patinetas.dao.ProveedorDAO;
import com.mycompany.patinetas.models.Producto;
import com.mycompany.patinetas.util.FileUploadUtil;
import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "AdminProductoServlet", urlPatterns = {"/admin/productos/*"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 5,   // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class AdminProductoServlet extends HttpServlet {
    private ProductoDAO productoDAO;
    
    @Override
    public void init() {
        productoDAO = new ProductoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        ProveedorDAO proveedorDAO = new ProveedorDAO();
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            // Listar productos
            request.setAttribute("productos", productoDAO.listarTodos());
            request.getRequestDispatcher("/WEB-INF/views/admin/productos/listar.jsp").forward(request, response);
        } else if (action.equals("/nuevo")) {
            // Mostrar formulario para nuevo producto
            request.setAttribute("producto", new Producto());
            request.setAttribute("categorias", categoriaDAO.listarTodas());
            request.setAttribute("proveedores", proveedorDAO.listarTodos());
            request.getRequestDispatcher("/WEB-INF/views/admin/productos/formulario.jsp").forward(request, response);
        } else if (action.equals("/editar")) {
            // Mostrar formulario para editar producto
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = productoDAO.obtenerPorId(id);
            
            if (producto != null) {
                request.setAttribute("producto", producto);
                request.setAttribute("categorias", categoriaDAO.listarTodas());
                request.setAttribute("proveedores", proveedorDAO.listarTodos());
                request.getRequestDispatcher("/WEB-INF/views/admin/productos/formulario.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else if (action.equals("/eliminar")) {
            // Eliminar producto
            int id = Integer.parseInt(request.getParameter("id"));
            if (productoDAO.eliminar(id)) {
                request.getSession().setAttribute("success", "Producto eliminado correctamente");
            } else {
                request.getSession().setAttribute("error", "No se pudo eliminar el producto");
            }
            response.sendRedirect(request.getContextPath() + "/admin/productos");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/")) {
            // Procesar formulario (crear o actualizar)
            Producto producto = new Producto();
            
            // Obtener parámetros del formulario
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                producto.setId(Integer.parseInt(idParam));
            }
            
            producto.setNombre(request.getParameter("nombre"));
            producto.setDescripcion(request.getParameter("descripcion"));
            producto.setPrecio(new BigDecimal(request.getParameter("precio")));
            producto.setStock(Integer.parseInt(request.getParameter("stock")));
            producto.setCategoriaId(Integer.parseInt(request.getParameter("categoriaId")));
            producto.setProveedorId(Integer.parseInt(request.getParameter("proveedorId")));
            
            // Manejar la imagen
            Part filePart = request.getPart("imagen");
            String fileName = FileUploadUtil.guardarArchivo(filePart, getServletContext().getRealPath("/"));
            
            if (fileName != null && !fileName.isEmpty()) {
                producto.setImagen(fileName);
            } else if (producto.getId() != 0) {
                // Mantener la imagen existente si no se subió una nueva
                Producto existente = productoDAO.obtenerPorId(producto.getId());
                producto.setImagen(existente.getImagen());
            }
            
            // Guardar el producto
            if (productoDAO.guardar(producto)) {
                request.getSession().setAttribute("success", 
                    producto.getId() == 0 ? "Producto creado correctamente" : "Producto actualizado correctamente");
            } else {
                request.getSession().setAttribute("error", 
                    "No se pudo guardar el producto");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/productos");
        }

    }
    
    @Override
    public void destroy() {
        productoDAO.cerrarConexion();
    }

}
