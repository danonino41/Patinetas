<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard - Gestión de Patinetas</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
    
    <div class="container mt-4">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h2>
                <i class="bi bi-speedometer"></i> Panel de Administración
            </h2>
        </div>
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title">
                                <i class="bi bi-people-fill me-2"></i> Usuarios
                            </h5>
                            <p class="card-text mb-0">Gestionar usuarios del sistema</p>
                            <a href="${pageContext.request.contextPath}/admin/usuarios" 
                               class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalUsuarios}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title">
                                <i class="bi bi-box2"></i> Productos
                            </h5>
                            <p class="card-text mb-0">Gestionar catálogo de patinetas</p>
                            <a href="${pageContext.request.contextPath}/admin/productos" 
                               class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalProductos}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title">
                                <i class="bi bi-tags-fill me-2"></i> Categorias
                            </h5>
                            <p class="card-text mb-0">Gestionar categorías</p>
                            <a href="${pageContext.request.contextPath}/admin/categorias" 
                               class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalCategorias}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title">
                                <i class="bi bi-building-gear me-2"></i> Proveedores
                            </h5>
                            <p class="card-text mb-0">Gestionar proveedores</p>
                            <a href="${pageContext.request.contextPath}/admin/proveedores" 
                               class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalProveedores}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title">
                                <i class="bi bi-cart-check-fill me-2"></i> Ventas
                            </h5>
                            <p class="card-text mb-0">Ver reportes de ventas</p>
                            <a href="${pageContext.request.contextPath}/admin/reportes-ventas" 
                               class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalVentas}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>