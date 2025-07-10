<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${producto.nombre}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                     class="img-fluid rounded" alt="${producto.nombre}">
            </div>
            <div class="col-md-6">
                <h1>${producto.nombre}</h1>
                <h3 class="text-primary">$${producto.precio}</h3>
                <p class="lead">${producto.descripcion}</p>
                
                <c:if test="${producto.stock > 0}">
                    <p class="text-success">Disponible (${producto.stock} unidades)</p>
                    <button class="btn btn-primary btn-lg">Agregar al carrito</button>
                </c:if>
                <c:if test="${producto.stock <= 0}">
                    <p class="text-danger">Agotado</p>
                    <button class="btn btn-secondary btn-lg" disabled>No disponible</button>
                </c:if>
                
                <a href="${pageContext.request.contextPath}/productos" class="btn btn-link">
                    Volver al catálogo
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>