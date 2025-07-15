<!-- Font Awesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&family=Poppins:wght@400;600&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');
    .navbar {
        background-color: #000000;
        padding: 0.8rem 1rem;
        font-family: 'Poppins', sans-serif;
    }

    .navbar-brand {
        font-size: 2rem;
        color: #e0e0e0;
        text-transform: uppercase;
        font-family: "Bebas Neue", sans-serif;
        font-weight: 400;
        font-style: normal;
    }
</style>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fa-solid fa-person-skating"></i> Patinetas<sup>shop</sup>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/">
                        <i class="bi bi-shop-window"></i> Pagina web
                    </a>
                </li>
            </ul>
            <div class="d-flex">
                <span class="navbar-text me-3">Bienvenido, ${usuario.nombre}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Cerrar Sesión</a>
            </div>
        </div>
    </div>
</nav>

