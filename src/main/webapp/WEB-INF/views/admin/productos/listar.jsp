<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>Gestión de Productos</h1>
            <a href="${pageContext.request.contextPath}/admin/productos/nuevo" 
               class="btn btn-success">
                <i class="bi bi-plus-lg"></i> Nuevo Producto
            </a>
        </div>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Imagen</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.id}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                                     alt="${producto.nombre}" 
                                     style="width: 50px; height: 50px; object-fit: cover;">
                            </td>
                            <td>${producto.nombre}</td>
                            <td>$${producto.precio}</td>
                            <td>${producto.stock}</td>
                            <td>
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/productos/editar?id=${producto.id}" 
                                       class="btn btn-sm btn-primary">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/productos/eliminar?id=${producto.id}" 
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('¿Estás seguro de eliminar este producto?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>