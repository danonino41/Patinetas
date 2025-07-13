<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.patinetas.models.Producto"%>
<%@page import="com.mycompany.patinetas.models.Categoria"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PatinetasShop - Busqueda</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            .product-card {
                transition: transform 0.3s ease;
            }
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            @media (max-width: 768px) {
                .filter-col {
                    order: 2;
                    margin-top: 20px;
                }
                .results-col {
                    order: 1;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/includes/navbar.jsp"/>
        
        <div class="container mt-4">
            <div class="row">
                <!-- Filtros -->
                <div class="col-md-3">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5>Filtrar Productos</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/busqueda" method="get">
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre:</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" 
                                           value="${not empty filtroNombre ? filtroNombre : ''}">
                                </div>

                                <div class="mb-3">
                                    <label for="categoria" class="form-label">Categoría:</label>
                                    <select class="form-select" id="categoria" name="categoria">
                                        <option value="">Todas las categorías</option>
                                        <c:forEach items="${categorias}" var="categoria">
                                            <option value="${categoria.id}" 
                                                    ${filtroCategoria != null && filtroCategoria == categoria.id ? 'selected' : ''}>
                                                ${categoria.nombre}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Rango de precios:</label>
                                    <div class="row g-2">
                                        <div class="col">
                                            <input type="number" class="form-control" placeholder="Mínimo" 
                                                   name="precioMin" step="0.01" min="0"
                                                   value="${not empty filtroPrecioMin ? filtroPrecioMin : ''}">
                                        </div>
                                        <div class="col">
                                            <input type="number" class="form-control" placeholder="Máximo" 
                                                   name="precioMax" step="0.01" min="0"
                                                   value="${not empty filtroPrecioMax ? filtroPrecioMax : ''}">
                                        </div>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary w-100">Aplicar Filtros</button>
                                <a href="${pageContext.request.contextPath}/busqueda" class="btn btn-outline-secondary w-100 mt-2">
                                    Limpiar Filtros
                                </a>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Resultados -->
                <div class="col-md-9">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2>Productos</h2>
                        <div class="text-muted">
                            Mostrando ${productos.size()} resultados
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty productos && !productos.isEmpty()}">
                            <div class="row row-cols-1 row-cols-md-3 g-4">
                                <c:forEach items="${productos}" var="producto">
                                    <div class="col">
                                        <div class="card h-100">
                                            <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                                                 class="card-img-top" alt="${producto.nombre}"
                                                 style="height: 200px; object-fit: contain;">
                                            <div class="card-body">
                                                <h5 class="card-title">${producto.nombre}</h5>
                                                <p class="card-text text-muted">${producto.categoriaNombre}</p>
                                                <h6 class="text-primary">$${String.format("%.2f", producto.precio)}</h6>
                                                <c:if test="${producto.stock > 0}">
                                                    <span class="badge bg-success">Disponible</span>
                                                </c:if>
                                                <c:if test="${producto.stock <= 0}">
                                                    <span class="badge bg-secondary">Agotado</span>
                                                </c:if>
                                            </div>
                                            <div class="card-footer bg-white">
                                                <form action="${pageContext.request.contextPath}/checkout" method="post" class="d-flex">
                                                    <input type="hidden" name="action" value="add">
                                                    <input type="hidden" name="id" value="${producto.id}">
                                                    <input type="number" name="cantidad" value="1" min="1" 
                                                           max="${producto.stock}" class="form-control me-2" style="width: 70px;">
                                                    <button type="submit" class="btn btn-primary" 
                                                            ${producto.stock <= 0 ? 'disabled' : ''}>
                                                        <i class="bi bi-cart-plus"></i>
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/productos?id=${producto.id}" 
                                                        class="btn btn-primary w-100 ms-2">
                                                         Ver Detalles
                                                    </a>
                                                </form>
                                                        
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                No se encontraron productos con los filtros aplicados.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
                        
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



