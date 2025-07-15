<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Gestión de Patinetas</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-body {
            padding: 2rem;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 500;
        }
        .display-4 {
            font-size: 2rem;
            font-weight: 700;
        }
        .btn-light {
            background-color: rgba(255, 255, 255, 0.8);
            color: #6f42c1;
            border-radius: 5px;
        }
        .btn-light:hover {
            background-color: #f8f9fa;
        }
        .header {
            margin-bottom: 20px;
        }
        .header h2 {
            font-size: 1.75rem;
            color: #495057;
            font-weight: bold;
        }
        .icon {
            font-size: 1.5rem;
            margin-right: 8px;
        }
        .card .card-body i {
            font-size: 2rem;
        }
        .row {
            margin-top: 30px;
        }
        .bg-primary {
            background-color: #6f42c1 !important;
        }

        @media (max-width: 768px) {
            .display-4 {
                font-size: 1.5rem;
            }
            .card-body {
                padding: 1.5rem;
            }
            .card-title {
                font-size: 1.1rem;
            }
            .col-md-4 {
                margin-bottom: 20px;
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .header h2 {
                font-size: 1.5rem;
            }
            .btn-light {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
    
    <div class="container mt-4">
        <div class="header d-flex justify-content-between align-items-center">
            <h2><i class="bi bi-speedometer"></i> Panel de Administración</h2>
        </div>
        <div class="row">
            <div class="col-md-4 col-12">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title"><i class="bi bi-people-fill me-2"></i> Usuarios</h5>
                            <p class="card-text mb-0">Gestionar usuarios del sistema</p>
                            <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalUsuarios}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-12">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title"><i class="bi bi-box2"></i> Productos</h5>
                            <p class="card-text mb-0">Gestionar catálogo de patinetas</p>
                            <a href="${pageContext.request.contextPath}/admin/productos" class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalProductos}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-12">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title"><i class="bi bi-tags-fill me-2"></i> Categorías</h5>
                            <p class="card-text mb-0">Gestionar categorías</p>
                            <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalCategorias}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-12">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title"><i class="bi bi-building-gear me-2"></i> Proveedores</h5>
                            <p class="card-text mb-0">Gestionar proveedores</p>
                            <a href="${pageContext.request.contextPath}/admin/proveedores" class="btn btn-light btn-sm mt-2">Administrar</a>
                        </div>
                        <div class="display-4 fw-bold ms-3">${totalProveedores}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-12">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <h5 class="card-title"><i class="bi bi-cart-check-fill me-2"></i> Ventas</h5>
                            <p class="card-text mb-0">Ver reportes de ventas</p>
                            <a href="${pageContext.request.contextPath}/admin/reportes-ventas" class="btn btn-light btn-sm mt-2">Administrar</a>
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
