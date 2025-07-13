<%@page import="java.util.List"%>
<%@page import="com.mycompany.patinetas.models.DetalleVenta"%>
<%@page import="com.mycompany.patinetas.models.Venta"%>
<%@page import="java.text.SimpleDateFormat"%>

<% 
    Venta venta = (Venta) request.getAttribute("venta");
    List<DetalleVenta> detalles = (List<DetalleVenta>) request.getAttribute("detalles");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PatinetasShop - Historial de compras</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        
        <%@include file="../../../includes/navbar.jsp" %>
        
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Detalle de Compra #<%= venta.getId() %></h2>
                <a href="${pageContext.request.contextPath}/perfil" class="btn btn-outline-secondary">
                    Volver al perfil
                </a>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h4>Información del Pedido</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Fecha:</strong> <%= dateFormat.format(venta.getFecha()) %></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Total:</strong> $<%= String.format("%.2f", venta.getTotal()) %></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4>Productos</h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (DetalleVenta detalle : detalles) { %>
                                    <tr>
                                        <td><%= detalle.getNombreProducto() %></td>
                                        <td><%= detalle.getCantidad() %></td>
                                        <td>$<%= String.format("%.2f", detalle.getSubtotal() / detalle.getCantidad()) %></td>
                                        <td>$<%= String.format("%.2f", detalle.getSubtotal()) %></td>
                                    </tr>
                                <% } %>
                                <tr class="table-active">
                                    <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                    <td><strong>$<%= String.format("%.2f", venta.getTotal()) %></strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
                                
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>                      

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>


