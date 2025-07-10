<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Catálogo de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">Nuestros Productos</h1>
        
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach var="producto" items="${productos}">
                <div class="col">
                    <div class="card h-100">
                        <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                             class="card-img-top" alt="${producto.nombre}" 
                             style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">${producto.nombre}</h5>
                            <p class="card-text">${producto.descripcion}</p>
                            <h6 class="text-primary">$${producto.precio}</h6>
                        </div>
                        <div class="card-footer bg-white">
                            <a href="${pageContext.request.contextPath}/productos?id=${producto.id}" 
                               class="btn btn-primary w-100">
                                Ver Detalles
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>