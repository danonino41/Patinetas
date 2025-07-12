<%@page contentType="text/html" pageEncoding="UTF-8" %>
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

        <jsp:include page="/WEB-INF/includes/navbar.jsp" />

        <div class="main-content">
            <div class="container mt-4">
                <h1 class="mb-4 text-center">Nuestros Productos</h1>
                <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
                    <c:forEach var="producto" items="${productos}">
                        <div class="col">
                            <div class="card h-100 shadow-sm rounded-3">
                                <img src="${producto.imagen}" class="card-img-top" alt="${producto.nombre}" 
                                     style="height: 250px; object-fit: cover; border-radius: 0.75rem 0.75rem 0 0;">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title mb-3">${producto.nombre}</h5>
                                    <p class="card-text text-muted" style="font-size: 0.9rem; flex-grow: 1;">${producto.descripcion}</p>
                                    <h6 class="text-success font-weight-bold">S/${producto.precio}</h6>
                                </div>
                                <div class="card-footer bg-white border-0">
                                    <a href="${pageContext.request.contextPath}/productos?id=${producto.id}" 
                                       class="btn btn-success w-100 rounded-pill shadow-sm">
                                        Ver Detalles
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>


        <jsp:include page="/WEB-INF/includes/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>