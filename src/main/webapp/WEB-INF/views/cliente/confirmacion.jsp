<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PatinetasShop - Confirmación de compra</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@include file="../../includes/navbar.jsp" %>

<div class="container mt-5">
    <div class="text-center">
        <h2 class="text-success mb-4"><i class="bi bi-check-circle-fill"></i> ¡Gracias por tu compra!</h2>

        <p class="fs-5">Tu pedido ha sido procesado exitosamente con el número:</p>
        <p class="fw-bold fs-4 text-primary"><%= request.getParameter("id") %></p>

        <p class="mb-4">Te hemos enviado un correo electrónico con los detalles de tu compra.</p>

        <a href="${pageContext.request.contextPath}" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left-circle"></i> Volver a la tienda
        </a>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
