<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Confirmación de Compra - PatinetasShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .confirmation-icon {
            font-size: 5rem;
            color: #28a745;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp"/>
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <div class="confirmation-icon mb-4">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
                <h1>¡Gracias por tu compra!</h1>
                <p class="lead">Tu pedido ha sido procesado exitosamente.</p>
                
                <div class="card mt-4">
                    <div class="card-body">
                        <h5 class="card-title">Detalles del Pedido</h5>
                        <p class="card-text">
                            Código de pedido: <strong>${param.codigo}</strong>
                        </p>
                        <p class="card-text">
                            Te hemos enviado un correo electrónico con los detalles de tu compra.
                        </p>
                    </div>
                </div>
                
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/mis-pedidos" class="btn btn-primary me-2">
                        Ver mis pedidos
                    </a>
                    <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-secondary">
                        Seguir comprando
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>