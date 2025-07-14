<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Categorías</title>
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
                        <i class="bi bi-tags-fill me-2"></i> Gestión de Categorías
                    </h2>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/categorias/nuevo" class="btn btn-sm btn-primary">
                                <i class="bi bi-plus-circle"></i> Nueva categoría
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-secondary ms-3">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                </div>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <c:if test="${not empty mensajeError}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${mensajeError}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:remove var="mensajeError" scope="session"/>
                </c:if>

                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${categorias}" var="categoria">
                                <tr>
                                    <td>${categoria.id}</td>
                                    <td>${categoria.nombre}</td>
                                    <td>${categoria.descripcion}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/categorias/editar?id=${categoria.id}" class="btn btn-sm btn-warning">Editar</a>
                                        <a href="${pageContext.request.contextPath}/admin/categorias/eliminar?id=${categoria.id}" class="btn btn-sm btn-danger" onclick="return confirm('¿Eliminar esta categoría?')">Eliminar</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>
        
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>