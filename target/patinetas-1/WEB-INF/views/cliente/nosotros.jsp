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
                background-position: center;
                color: white;
                padding: 6rem 0;
                margin-bottom: 3rem;
                text-align: center;
            }

            .hero-section h1 {
                font-size: 3rem;
                font-weight: 700;
            }

            .hero-section p {
                font-size: 1.2rem;
                font-weight: 400;
            }

            .mission-vision h2 {
                font-size: 1.8rem;
                font-weight: 600;
            }

            .mission-vision p {
                font-size: 1.1rem;
            }

            .team-member {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                border-radius: 10px; 
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .team-member:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
            }

            .team-member .card-body {
                padding: 2rem;
            }

            .team-member .card-body i {
                font-size: 3rem;
                color: #6c757d;
            }

            .team-member .card-body h5 {
                font-size: 1.5rem;
                font-weight: 600;
                margin-top: 1rem;
            }

            .team-member .card-body p {
                color: #6c757d;
                font-size: 1.1rem;
            }

            .card-title i {
                font-size: 1.6rem;
                margin-right: 10px;
            }

            @media (max-width: 768px) {
                .hero-section {
                    padding: 4rem 0;
                }

                .hero-section h1 {
                    font-size: 2.5rem;
                }

                .hero-section p {
                    font-size: 1.1rem;
                }

                .team-member .card-body h5 {
                    font-size: 1.2rem;
                }

                .team-member .card-body p {
                    font-size: 1rem;
                }
            }

            @media (max-width: 576px) {
                .hero-section h1 {
                    font-size: 2rem;
                }

                .hero-section p {
                    font-size: 1rem;
                }

                .team-member .card-body h5 {
                    font-size: 1rem;
                }

                .team-member .card-body p {
                    font-size: 0.9rem;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="/WEB-INF/includes/navbar.jsp"/>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <h1 class="display-4 fw-bold">Nuestra Historia</h1>
                <p class="lead">Conoce más sobre nosotros y nuestra pasión por las patinetas</p>
            </div>
        </section>

        <div class="container my-5 mission-vision">
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
                <div class="col-md-4 mb-4">
                    <div class="card team-member h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-circle display-4 text-muted"></i>
                            <h5 class="card-title mt-3">SANCHEZ ROSALES, JEFFERSON ALEXANDER</h5>
                            <p class="text-muted">Backend Developer</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card team-member h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-circle display-4 text-muted"></i>
                            <h5 class="card-title mt-3">CULLLANCO GONZALES, DIEGO ALONSO</h5>
                            <p class="text-muted">Frontend Developer</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="card team-member h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-person-circle display-4 text-muted"></i>
                            <h5 class="card-title mt-3">RENE ALEJANDRO ZAMUDIO ARIZA</h5>
                            <p class="text-muted">Director de Proyecto</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/includes/footer.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
