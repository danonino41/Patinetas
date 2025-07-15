<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PatinetasShop - Contacto</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .contact-hero {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), 
                        url('https://www.shutterstock.com/image-photo/athletic-boy-helmet-knee-pads-260nw-1479148847.jpg');
            background-size: cover;
            color: white;
            padding: 5rem 0;
            margin-bottom: 3rem;
        }
        .contact-info-card {
            transition: all 0.3s;
        }
        .contact-info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/includes/navbar.jsp"/>

    <section class="contact-hero text-center">
        <div class="container">
            <h1 class="display-4 fw-bold">Contáctanos</h1>
            <p class="lead">Estamos aquí para ayudarte con cualquier pregunta</p>
        </div>
    </section>
    
    <div class="container my-5">
        <c:if test="${not empty mensajeExito}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${mensajeExito}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="row">
            <div class="col-lg-5 mb-4">
                <h2 class="mb-4"><i class="bi bi-info-circle me-2"></i>Información de Contacto</h2>
                
                <div class="card contact-info-card mb-3">
                    <div class="card-body">
                        <h5><i class="bi bi-geo-alt text-primary me-2"></i>Dirección</h5>
                        <p>${direccion}</p>
                    </div>
                </div>
                
                <div class="card contact-info-card mb-3">
                    <div class="card-body">
                        <h5><i class="bi bi-telephone text-success me-2"></i>Teléfono</h5>
                        <p>${telefono}</p>
                    </div>
                </div>
                
                <div class="card contact-info-card mb-3">
                    <div class="card-body">
                        <h5><i class="bi bi-envelope text-danger me-2"></i>Email</h5>
                        <p>${email}</p>
                    </div>
                </div>
                
                <div class="card contact-info-card">
                    <div class="card-body">
                        <h5><i class="bi bi-clock text-warning me-2"></i>Horario de Atención</h5>
                        <p>${horario}</p>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-7">
                <h2 class="mb-4"><i class="bi bi-map me-2"></i>Ubicación en el Mapa</h2>
                <!-- Incrustar el mapa de Google Maps dentro de la columna de 7 partes -->
                <div class="embed-responsive embed-responsive-16by9">
                    <iframe 
                        class="embed-responsive-item" 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7805.903661712293!2d-77.077682!3d-11.977835!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105ce404678f75b%3A0xfed99f7d0ccb5ab!2sAv.%20Naranjal%20%26%20Av.%20Universitaria%2C%20Los%20Olivos%2015306!5e0!3m2!1ses-419!2spe!4v1752566387501!5m2!1ses-419!2spe" 
                        width="100%" 
                        height="450" 
                        style="border:0;" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </div>
    </div>
    

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
