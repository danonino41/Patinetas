<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard - Gestión de Patinetas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Gestión de Patinetas</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                </ul>
                <div class="d-flex">
                    <span class="navbar-text me-3">Bienvenido, ${usuario.nombre}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <h2>Panel de Administración</h2>
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Usuarios</h5>
                        <p class="card-text">Gestionar usuarios del sistema</p>
                        <a href="#" class="btn btn-light">Administrar</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Productos</h5>
                        <p class="card-text">Gestionar catálogo de patinetas</p>
                        <a href="${pageContext.request.contextPath}/admin/productos" class="btn btn-light">Administrar</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Categorias</h5>
                        <p class="card-text">Gestionar categorías</p>
                        <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-light">Administrar</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Proveedores</h5>
                        <p class="card-text">Gestionar proveedores</p>
                        <a href="${pageContext.request.contextPath}/admin/proveedores" class="btn btn-light">Administrar</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-info mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Ventas</h5>
                        <p class="card-text">Ver reportes de ventas</p>
                        <a href="#" class="btn btn-light">Ver Reportes</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>