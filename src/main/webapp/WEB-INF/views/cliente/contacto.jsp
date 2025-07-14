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
                <h2 class="mb-4"><i class="bi bi-send me-2"></i>Envíanos un Mensaje</h2>
                <form action="${pageContext.request.contextPath}/contact" method="post">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre Completo</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="asunto" class="form-label">Asunto</label>
                        <input type="text" class="form-control" id="asunto" name="asunto" required>
                    </div>
                    <div class="mb-3">
                        <label for="mensaje" class="form-label">Mensaje</label>
                        <textarea class="form-control" id="mensaje" name="mensaje" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send-fill me-2"></i>Enviar Mensaje
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="container-fluid p-0">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3901.965943584534!2d-77.04278592416466!3d-12.046990088146993!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c5f619ee3ec7%3A0x14206cb9cc452e4a!2sLima%2C%20Per%C3%BA!5e0!3m2!1ses!2sus!4v1620000000000!5m2!1ses!2sus" 
                width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
    </div>

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
