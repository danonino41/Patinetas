<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Categorías</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1>Categorías</h1>
        <a href="${pageContext.request.contextPath}/admin/categorias/nuevo" class="btn btn-primary mb-3">Nueva Categoría</a>
        
        <table class="table">
            <thead>
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
</body>
</html>