<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PatinetasShop - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('https://thumbs.dreamstime.com/z/monopatines-de-colores-en-nuestra-tienda-patinetas-la-214855506.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            margin-bottom: 50px;
        }

        .hero-section h1 {
            font-size: 3rem;
        }

        .card-producto {
            transition: transform 0.3s;
        }

        .card-producto:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .hover-shadow {
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .hover-shadow:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }

        .object-fit-cover {
            object-fit: cover;
        }

        .categoria-img-placeholder {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<!-- Hero Section -->
<section class="hero-section text-center">
    <div class="container">
        <h1 class="fw-bold mb-3">Las mejores patinetas del mercado</h1>
        <p class="lead mb-4">Encuentra tu patineta perfecta para moverte por la ciudad</p>
        <a href="${pageContext.request.contextPath}/busqueda" class="btn btn-lg btn-light shadow">
            <i class="bi bi-search"></i> Ver Catálogo
        </a>
    </div>
</section>

<!-- Sección de Categorías -->
<section class="container my-5">
    <h2 class="text-center mb-4">Nuestras Categorías</h2>
    <div class="row row-cols-2 row-cols-md-4 g-4">
        <c:forEach items="${categorias}" var="categoria">
            <div class="col">
                <div class="card h-100 border-0 shadow-sm hover-shadow">
                    <a href="${pageContext.request.contextPath}/busqueda?categoria=${categoria.id}" class="text-decoration-none text-dark">
                        <div class="categoria-img-placeholder">
                            ${categoria.nombre}
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<!-- Productos Destacados -->
<section class="container mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">Productos Destacados</h2>
        <a href="${pageContext.request.contextPath}/busqueda" class="btn btn-outline-primary">
            <i class="bi bi-arrow-right-circle"></i> Ver todos
        </a>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
        <c:forEach items="${productosDestacados}" var="producto">
            <div class="col">
                <div class="card h-100 card-producto border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/${producto.imagen}"
                         class="card-img-top object-fit-cover" alt="${producto.nombre}"
                         style="height: 200px;">
                    <div class="card-body">
                        <h5 class="card-title">${producto.nombre}</h5>
                        <p class="card-text text-truncate">${producto.descripcion}</p>
                        <h5 class="text-primary">$${producto.precio}</h5>
                    </div>
                    <div class="card-footer bg-white border-0">
                        <a href="${pageContext.request.contextPath}/productos?id=${producto.id}"
                           class="btn btn-primary w-100">
                            <i class="bi bi-eye"></i> Ver Detalles
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
