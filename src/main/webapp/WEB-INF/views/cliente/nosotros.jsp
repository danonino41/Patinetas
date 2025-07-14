<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PatinetasShop - Nosotros</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), 
                        url('https://m.media-amazon.com/images/S/aplus-media-library-service-media/0c3ac075-b815-4f32-b014-dcffff472fbd.__CR0,0,970,300_PT0_SX970_V1___.jpg');
            background-size: cover;
            color: white;
            padding: 5rem 0;
            margin-bottom: 3rem;
        }
        .team-member {
            transition: transform 0.3s;
        }
        .team-member:hover {
            transform: translateY(-10px);
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/includes/navbar.jsp"/>

    <section class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 fw-bold">Nuestra Historia</h1>
            <p class="lead">Conoce más sobre nosotros y nuestra pasión por las patinetas</p>
        </div>
    </section>
    
    <div class="container my-5">
        <div class="row">
            <div class="col-md-6 mb-4">
                <h2><i class="bi bi-bullseye text-primary me-2"></i>Misión</h2>
                <p class="lead">${mision}</p>
            </div>
            <div class="col-md-6 mb-4">
                <h2><i class="bi bi-eye text-success me-2"></i>Visión</h2>
                <p class="lead">${vision}</p>
            </div>
        </div>
        
        <div class="card mb-5">
            <div class="card-body">
                <h2><i class="bi bi-clock-history text-info me-2"></i>Nuestra Historia</h2>
                <p>${historia}</p>
            </div>
        </div>
        
        <h2 class="text-center mb-4"><i class="bi bi-people-fill me-2"></i>Nuestro Equipo</h2>
        <div class="row">
            <c:forEach items="${equipo}" var="miembro">
                <div class="col-md-4 mb-4">
                    <div class="card team-member h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-circle display-4 text-muted"></i>
                            <h5 class="card-title mt-3">${miembro.split(" - ")[0]}</h5>
                            <p class="text-muted">${miembro.split(" - ")[1]}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <jsp:include page="/WEB-INF/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
