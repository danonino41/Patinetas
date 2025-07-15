<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes de Ventas - Administración</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <style>
        .stat-card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .chart-container {
            height: 300px;
            position: relative;
        }
        .btn-primary {
            background-color: #6f42c1;
            border-color: #6f42c1;
        }
        .btn-primary:hover {
            background-color: #5a2c9e;
        }
        .table-striped tbody tr:hover {
            background-color: #f1f1f1;
        }

        /* Responsividad */
        @media (max-width: 768px) {
            .btn-sm {
                font-size: 0.75rem;
            }
            
            .stat-card{
                margin-bottom: 10px;
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
                    <h1 class="h2">
                        <i class="bi bi-cart-check-fill me-2"></i> Reportes de Ventas
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="window.print()">
                                <i class="bi bi-printer"></i> Imprimir
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-sm btn-outline-secondary ms-3">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Filtros -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Filtros</h5>
                    </div>
                    <div class="card-body">
                        <form class="row g-3">
                            <div class="col-md-3">
                                <label for="fechaInicio" class="form-label">Fecha Inicio</label>
                                <input type="date" class="form-control" id="fechaInicio" name="fechaInicio" value="${fechaInicio}">
                            </div>
                            <div class="col-md-3">
                                <label for="fechaFin" class="form-label">Fecha Fin</label>
                                <input type="date" class="form-control" id="fechaFin" name="fechaFin" value="${fechaFin}">
                            </div>
                            <div class="col-md-3">
                                <label for="ordenarPor" class="form-label">Ordenar por</label>
                                <select class="form-select" id="ordenarPor" name="ordenarPor">
                                    <option value="fecha_desc" ${ordenarPor == 'fecha_desc' ? 'selected' : ''}>Fecha (Más reciente)</option>
                                    <option value="fecha_asc" ${ordenarPor == 'fecha_asc' ? 'selected' : ''}>Fecha (Más antigua)</option>
                                    <option value="total_desc" ${ordenarPor == 'total_desc' ? 'selected' : ''}>Monto (Mayor primero)</option>
                                </select>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-funnel"></i> Aplicar Filtros
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Resumen Estadístico -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card text-white bg-primary stat-card">
                            <div class="card-body">
                                <h6 class="card-title">Total Ventas</h6>
                                <h2 class="card-text"><fmt:formatNumber value="${totalVentasCount}" type="number"/></h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-success stat-card">
                            <div class="card-body">
                                <h6 class="card-title">Monto Total</h6>
                                <h2 class="card-text">S/<fmt:formatNumber value="${totalVentas}" type="currency" currencySymbol=""/></h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-info stat-card">
                            <div class="card-body">
                                <h6 class="card-title">Venta Promedio</h6>
                                <h2 class="card-text">S/<fmt:formatNumber value="${estadisticas.promedioVenta}" type="currency" currencySymbol=""/></h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-white bg-warning stat-card">
                            <div class="card-body">
                                <h6 class="card-title">Venta Más Alta</h6>
                                <h2 class="card-text">S/<fmt:formatNumber value="${estadisticas.ventaMaxima}" type="currency" currencySymbol=""/></h2>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Gráficos y Tablas -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">Historial de Ventas</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="ventasTable" class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Fecha</th>
                                                <th>Cliente</th>
                                                <th>Total</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ventas}" var="venta">
                                                <tr>
                                                    <td>${venta.id}</td>
                                                    <td><fmt:formatDate value="${venta.fecha}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    <td>${venta.clienteNombre}</td>
                                                    <td>S/<fmt:formatNumber value="${venta.total}" type="currency" currencySymbol=""/></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/admin/detalle-venta?id=${venta.id}" 
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="bi bi-eye"></i> Ver
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">Productos Más Vendidos</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-group">
                                    <c:forEach items="${estadisticas.productosMasVendidos}" var="producto">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            ${producto.nombre}
                                            <span class="badge bg-primary rounded-pill">${producto.totalVendido}</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">Ventas por Día</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="ventasChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
    $(document).ready(function() {
        // Convertir los datos a formato adecuado
        const dias = JSON.parse('${ventasPorDiaLabels}'.replace(/&#034;/g, '"'));
        const ventas = JSON.parse('${ventasPorDiaData}'.replace(/&#034;/g, '"'));
        
        // Configurar el gráfico
        const ctx = document.getElementById('ventasChart').getContext('2d');
        const ventasChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dias,
                datasets: [{
                    label: 'Ventas por día',
                    data: ventas,
                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Monto en S/'
                        },
                        ticks: {
                            callback: function(value) {
                                return 'S/' + value.toLocaleString();
                            }
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Fechas (Día/Mes)'
                        }
                    }
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return 'Total: S/ ' + context.raw.toFixed(2);
                            }
                        }
                    }
                }
            }
        });
    });
    </script>
</body>
</html>
