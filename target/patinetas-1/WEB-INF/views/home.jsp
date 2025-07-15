<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>PatinetasShop - Inicio</title>
            <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
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
                    background-attachment: fixed;
                    color: white;
                    padding: 100px 0;
                    margin-bottom: 50px;
                }

                .hero-section h1 {
                    font-size: 3rem;
                    font-weight: bold;
                }

                .hero-section p {
                    font-size: 1.2rem;
                }

                .card-producto,
                .hover-shadow {
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .card-producto:hover,
                .hover-shadow:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
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

                .categoria-img-placeholder:hover {
                    background: linear-gradient(135deg, #6610f2, #0d6efd);
                }

                .card-producto img {
                    height: 200px;
                    object-fit: cover;
                }

                .card-body h5,
                .card-body p {
                    text-align: center;
                }

                .btn-outline-primary,
                .btn-primary {
                    transition: background-color 0.3s ease, color 0.3s ease;
                }

                .btn-outline-primary:hover {
                    background-color: #39fd0d;
                    color: white;
                }

                .btn-primary:hover {
                    background-color: #8b1a1a;
                    color: white;
                }

                .card {
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .card-footer {
                    background-color: white;
                    border-top: 1px solid #f1f1f1;
                }

                .container {
                    padding-left: 15px;
                    padding-right: 15px;
                }

                @media (max-width: 768px) {
                    .hero-section {
                        padding: 50px 0;
                    }

                    .hero-section h1 {
                        font-size: 2rem;
                    }

                    .hero-section p {
                        font-size: 1rem;
                    }
                }
            </style>
        </head>
        <body>

            <jsp:include page="/WEB-INF/includes/navbar.jsp" />

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
                <h2 class="text-center mb-4">Nuestras <span style="color: red;">Categorías</span></h2>
                <div class="row row-cols-2 row-cols-md-4 g-4">
                    <c:forEach items="${categorias}" var="categoria">
                        <div class="col">
                            <div class="card h-100 border-0 shadow-sm hover-shadow">
                                <a href="${pageContext.request.contextPath}/busqueda?categoria=${categoria.id}"
                                    class="text-decoration-none text-dark">
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
                    <h2 class="mb-0">Productos <span style="color: red;">Destacados</span></h2>
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
                                    <h5 class="text-success">S/ ${producto.precio}</h5>
                                </div>
                                <div class="card-footer bg-white border-0">
                                    <a href="${pageContext.request.contextPath}/productos?id=${producto.id}"
                                        class="btn btn-success w-100">
                                        <i class="bi bi-eye"></i> Ver Detalles
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <jsp:include page="/WEB-INF/includes/footer.jsp" />

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>