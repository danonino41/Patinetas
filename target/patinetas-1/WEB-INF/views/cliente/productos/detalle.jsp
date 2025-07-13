<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${producto.nombre} - PatinetasShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .product-image {
            max-height: 500px;
            object-fit: contain;
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
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/includes/navbar.jsp"/>

<div class="container my-5">
    <div class="row gy-4 align-items-center">
        <!-- Imagen del producto -->
        <div class="col-md-6 text-center">
            <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                 class="img-fluid rounded product-image border" alt="${producto.nombre}">
        </div>

        <!-- Información del producto -->
        <div class="col-md-6">
            <h1 class="fw-bold">${producto.nombre}</h1>
            <p class="text-muted mb-1">Código: <strong>${producto.id}</strong></p>
            <h4 class="text-primary mb-3">$${producto.precio}</h4>
            <p class="lead">${producto.descripcion}</p>

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

            <!-- Formulario de cantidad y botón de agregar -->
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
