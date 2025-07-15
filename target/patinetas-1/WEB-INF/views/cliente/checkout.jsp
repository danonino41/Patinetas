<%@page import="java.util.List"%>
<%@page import="com.mycompany.patinetas.models.ItemCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PatinetasShop - Carrito</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@include file="../../includes/navbar.jsp" %>

<div class="container mt-5">
    <h2 class="mb-4">Tu Carrito de Compras</h2>

    <%@page import="com.mycompany.patinetas.models.Carrito"%>
    <%
        Carrito carrito = (Carrito) session.getAttribute("carrito");
        List<ItemCarrito> items = (carrito != null) ? carrito.getItems() : null;
    %>
    
    <c:if test="${not empty mensajeExito}">
        <div class="alert alert-success alert-dismissible fade show">
            ${mensajeExito}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="mensajeExito" scope="session"/>
    </c:if>

    <c:if test="${not empty mensajeError}">
        <div class="alert alert-danger alert-dismissible fade show">
            ${mensajeError}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="mensajeError" scope="session"/>
    </c:if>

    <% if (items != null && !items.isEmpty()) { %>
        <div class="table-responsive">
            <table class="table table-bordered align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Producto</th>
                        <th>Precio Unitario</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <% for (ItemCarrito item : items) { %>
                    <tr>
                        <td><%= item.getProducto().getNombre() %></td>
                        <td>S/ <%= String.format("%.2f", item.getProducto().getPrecio()) %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/checkout" method="post" class="d-flex gap-2">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="<%= item.getProducto().getId() %>">
                                <input type="number" class="form-control form-control-sm w-50" name="cantidad" 
                                       value="<%= item.getCantidad() %>" min="1" 
                                       max="<%= item.getProducto().getStock() %>">
                                <button type="submit" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-arrow-repeat"></i>
                                </button>
                            </form>
                        </td>
                        <td>S/ <%= String.format("%.2f", item.getSubtotal()) %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/checkout" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="id" value="<%= item.getProducto().getId() %>">
                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                <tr>
                    <td colspan="3" class="text-end"><strong>Total:</strong></td>
                    <td colspan="2"><strong>S/ <%= String.format("%.2f", carrito.getTotal()) %></strong></td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="d-flex justify-content-end mt-3">
            <form action="${pageContext.request.contextPath}/venta" method="post">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-bag-check"></i> Finalizar Compra
                </button>
            </form>
        </div>
    <% } else { %>
        <div class="alert alert-info">
            Tu carrito está vacío.
        </div>
        <a href="${pageContext.request.contextPath}" class="btn btn-primary">
            <i class="bi bi-arrow-left"></i> Ver productos
        </a>
    <% } %>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
