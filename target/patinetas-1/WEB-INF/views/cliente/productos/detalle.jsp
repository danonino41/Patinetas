<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${producto.nombre} - PatinetasShop</title>
        <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            .product-image {
                max-height: 500px;
                object-fit: contain;
                width: 100%;
            }

            .quantity-control .form-control {
                text-align: center;
                max-width: 60px;
            }

            .quantity-control .btn {
                width: 40px;
            }

            .added-to-cart-alert {
                transition: opacity 0.3s ease;
            }

            .hero-section {
                background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
                    url('https://m.media-amazon.com/images/S/aplus-media-library-service-media/0c3ac075-b815-4f32-b014-dcffff472fbd.__CR0,0,970,300_PT0_SX970_V1___.jpg');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 6rem 0;
                margin-bottom: 3rem;
            }

            .hero-section h1 {
                font-size: 3rem;
                font-weight: 700;
            }

            .hero-section p {
                font-size: 1.2rem;
                font-weight: 400;
            }

            @media (max-width: 767px) {
                .hero-section {
                    padding: 4rem 0;
                }

                .hero-section h1 {
                    font-size: 2.5rem;
                }

                .hero-section p {
                    font-size: 1rem;
                }

                .product-image {
                    max-height: 300px;
                }

                .quantity-control .form-control {
                    max-width: 50px;
                }

                .quantity-control .btn {
                    width: 30px;
                }

                .btn-primary.add-to-cart {
                    font-size: 0.9rem;
                }

                .lead {
                    font-size: 1rem;
                }

                .product-image-col {
                    order: 1;
                    margin-bottom: 1.5rem;
                }

                .product-info-col {
                    order: 2;
                }

                .card-body {
                    padding: 1rem;
                }

                .card-footer {
                    padding: 1rem;
                    display: flex;
                    flex-direction: column;
                }
            }

            @media (max-width: 576px) {
                .hero-section h1 {
                    font-size: 2rem;
                }

                .hero-section p {
                    font-size: 1rem;
                }

                .product-image {
                    max-height: 200px;
                }

                .quantity-control .form-control {
                    max-width: 40px;
                }

                .quantity-control .btn {
                    width: 30px;
                }

                .btn-primary.add-to-cart {
                    font-size: 0.8rem;
                }

                .product-info-col {
                    order: 1;
                }

                .product-image-col {
                    order: 2;
                }
            }

            .btn-primary.add-to-cart {
                background-color: #FF0000; /* Rojo */
                border: none;
            }

            .btn-primary.add-to-cart:hover {
                background-color: #000000; 
                color: white;
            }

        </style>
    </head>
    <body>

        <jsp:include page="/WEB-INF/includes/navbar.jsp"/>

        <div class="container my-5">
            <div class="row gy-4 align-items-center">
                <!-- Imagen del producto -->
                <div class="col-12 col-md-6 text-center product-image-col">
                    <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                         class="img-fluid rounded product-image border" alt="${producto.nombre}">
                </div>

                <div class="col-12 col-md-6 product-info-col">
                    <h1 class="fw-bold">${producto.nombre}</h1>
                    <p class="text-muted mb-1">Código: <strong>${producto.id}</strong></p>
                    <h4 class="text-primary mb-3">S/ ${producto.precio}</h4>
                    <p class="lead">${fn:replace(fn:escapeXml(producto.descripcion), '\\n', '<br>')}</p>

                    <div class="mb-3">
                        <span class="fw-semibold">Disponibilidad:</span>
                        <c:choose>
                            <c:when test="${producto.stock > 10}">
                                <span class="text-success">En stock (${producto.stock} unidades)</span>
                            </c:when>
                            <c:when test="${producto.stock > 0}">
                                <span class="text-warning">Últimas unidades (${producto.stock})</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger">Agotado</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="d-flex flex-wrap align-items-center gap-3 mb-4">
                        <form id="addCart" action="${pageContext.request.contextPath}/checkout" method="post" class="d-flex align-items-center">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id" value="${producto.id}">

                            <div class="input-group quantity-control">
                                <button class="btn btn-outline-secondary minus-btn" type="button">-</button>
                                <input type="number" class="form-control quantity-input" name="cantidad" 
                                       value="1" min="1" max="${producto.stock}">
                                <button class="btn btn-outline-secondary plus-btn" type="button">+</button>
                            </div>
                        </form>

                        <button type="submit" form="addCart" class="btn btn-primary add-to-cart"
                                ${producto.stock <= 0 ? 'disabled' : ''}>
                            <i class="bi bi-cart-plus"></i> Añadir al carrito
                        </button>
                    </div>

                    <div class="alert alert-success added-to-cart-alert d-none">
                        <i class="bi bi-check-circle"></i> ¡Producto añadido al carrito!
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/includes/footer.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            const minusBtn = document.querySelector('.minus-btn');
            const plusBtn = document.querySelector('.plus-btn');
            const quantityInput = document.querySelector('.quantity-input');
            
            minusBtn?.addEventListener('click', () => {
                let value = parseInt(quantityInput.value);
                if (value > 1) quantityInput.value = value - 1;
            });

            plusBtn?.addEventListener('click', () => {
                let value = parseInt(quantityInput.value);
                const max = parseInt(quantityInput.max);
                if (value < max) quantityInput.value = value + 1;
            });
        </script>

    </body>
</html>
