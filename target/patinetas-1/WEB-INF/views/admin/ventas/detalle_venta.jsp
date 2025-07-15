<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Venta - Administración</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .btn-primary {
            background-color: #6f42c1;
            border-color: #6f42c1;
        }
        .btn-secondary {
            background-color: #e9ecef;
            color: #495057;
        }
        .btn-secondary:hover {
            background-color: #d6d8db;
        }
        .btn-sm {
            font-size: 0.875rem;
        }
        .table-striped tbody tr:hover {
            background-color: #f1f1f1;
        }

        @media (max-width: 768px) {
            .btn-sm {
                font-size: 0.75rem;
            }
            .card-body {
                padding: 1rem;
            }
            .table-responsive {
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
    
    <div class="container-fluid mt-4">
        <div class="row">
            <main class="col-md-9 m-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Detalle de Venta #${venta.id}</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/reportes-ventas" class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Información de la Venta</h5>
                            </div>
                            <div class="card-body">
                                <dl class="row">
                                    <dt class="col-sm-4">Fecha:</dt>
                                    <dd class="col-sm-8"><fmt:formatDate value="${venta.fecha}" pattern="dd/MM/yyyy HH:mm"/></dd>
                                    
                                    <dt class="col-sm-4">Cliente:</dt>
                                    <dd class="col-sm-8">${venta.clienteNombre}</dd>
                                    
                                    <dt class="col-sm-4">Total:</dt>
                                    <dd class="col-sm-8">S/<fmt:formatNumber value="${venta.total}" type="currency" currencySymbol=""/></dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Productos</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                        <th>Precio Unitario</th>
                                        <th>Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${detalles}" var="detalle">
                                        <tr>
                                            <td>${detalle.nombreProducto}</td>
                                            <td>${detalle.cantidad}</td>
                                            <td>S/<fmt:formatNumber value="${detalle.subtotal / detalle.cantidad}" type="currency" currencySymbol=""/></td>
                                            <td>S/<fmt:formatNumber value="${detalle.subtotal}" type="currency" currencySymbol=""/></td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="table-active">
                                        <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                        <td><strong>S/<fmt:formatNumber value="${venta.total}" type="currency" currencySymbol=""/></strong></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
