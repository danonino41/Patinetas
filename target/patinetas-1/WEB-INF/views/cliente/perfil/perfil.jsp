<%@page import="java.util.List"%>
<%@page import="com.mycompany.patinetas.models.Venta"%>
<%@page import="com.mycompany.patinetas.models.Usuario"%>
<%@page import="java.text.SimpleDateFormat"%>

<% 
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    List<Venta> historialCompras = (List<Venta>) request.getAttribute("historialCompras");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PatinetasShop - Perfil</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body>
        
        <%@include file="../../../includes/navbar.jsp" %>

        <div class="container">
            <h2>Mi Perfil</h2>

            <div class="row">
                <div class="col-md-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h4>Información Personal</h4>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Nombre:</label>
                                <p class="form-control-static"><%= usuario.getNombre() %></p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email:</label>
                                <p class="form-control-static"><%= usuario.getEmail() %></p>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Rol:</label>
                                <p class="form-control-static"><%= usuario.getRol() %></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4>Historial de Compras</h4>
                        </div>
                        <div class="card-body">
                            <% if (historialCompras != null && !historialCompras.isEmpty()) { %>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>N° Pedido</th>
                                                <th>Fecha</th>
                                                <th>Total</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Venta venta : historialCompras) { %>
                                                <tr>
                                                    <td>#<%= venta.getId() %></td>
                                                    <td><%= dateFormat.format(venta.getFecha()) %></td>
                                                    <td>$<%= String.format("%.2f", venta.getTotal()) %></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/detalle-venta?id=<%= venta.getId() %>" 
                                                           class="btn btn-sm btn-info">
                                                            Ver Detalle
                                                        </a>
                                                    </td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            <% } else { %>
                                <p>No tienes compras registradas.</p>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                        
        <jsp:include page="/WEB-INF/includes/footer.jsp"/>
                        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



