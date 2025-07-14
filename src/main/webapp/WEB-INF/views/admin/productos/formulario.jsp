<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${empty producto.id ? 'Nuevo Producto' : 'Editar Producto'}</title>
        <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
        
        <div class="container-fluid mt-4">
            <div class="row">
                <main class="col-md-9 m-auto col-lg-10 px-md-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h2>
                            <i class="bi bi-box2"></i> ${empty producto.id ? 'Nuevo Producto' : 'Editar Producto'}
                        </h2>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <a href="${pageContext.request.contextPath}/admin/productos" class="btn btn-sm btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                        </div>
                    </div>
                                
                    <c:if test="${not empty mensajeExito}">
                        <div class="alert alert-success alert-dismissible fade show">
                            ${mensajeExito}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="mensajeExito" scope="session"/>
                    </c:if>
                                
                    <c:if test="${not empty mensajeError}">
                        <div class="alert alert-danger alert-dismissible fade show">
                            ${mensajeError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="mensajeError" scope="session"/>
                    </c:if>
                    
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Datos del producto</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/productos" 
                                  method="POST" enctype="multipart/form-data">

                                <input type="hidden" name="id" value="${producto.id}">

                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" 
                                           value="${producto.nombre}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción</label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" 
                                              rows="3">${producto.descripcion}</textarea>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="precio" class="form-label">Precio</label>
                                        <div class="input-group">
                                            <span class="input-group-text">S/ </span>
                                            <input type="number" class="form-control" id="precio" name="precio" 
                                                   step="0.01" min="0" value="${producto.precio}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="stock" class="form-label">Stock</label>
                                        <input type="number" class="form-control" id="stock" name="stock" 
                                               min="0" value="${producto.stock}" required>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="categoriaId" class="form-label">Categoría</label>
                                        <select class="form-select" id="categoriaId" name="categoriaId" required>
                                            <option value="">Seleccione una categoría</option>
                                            <c:forEach items="${categorias}" var="categoria">
                                                <option value="${categoria.id}" 
                                                    ${producto.categoriaId == categoria.id ? 'selected' : ''}>
                                                    ${categoria.nombre}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="proveedorId" class="form-label">Proveedor</label>
                                        <select class="form-select" id="proveedorId" name="proveedorId" required>
                                            <option value="">Seleccione un proveedor</option>
                                            <c:forEach items="${proveedores}" var="proveedor">
                                                <option value="${proveedor.id}" 
                                                    ${producto.proveedorId == proveedor.id ? 'selected' : ''}>
                                                    ${proveedor.nombre}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="imagen" class="form-label">Imagen</label>
                                    <input class="form-control" type="file" id="imagen" name="imagen" 
                                           ${empty producto.id ? 'required' : ''}>

                                    <c:if test="${not empty producto.imagen}">
                                        <div class="mt-2">
                                            <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                                                 alt="Imagen actual" style="max-height: 200px;">
                                            <p class="text-muted mt-1">Imagen actual</p>
                                        </div>
                                    </c:if>
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    ${empty producto.id ? 'Crear Producto' : 'Actualizar Producto'}
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/productos" class="btn btn-secondary">
                                    Cancelar
                                </a>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>