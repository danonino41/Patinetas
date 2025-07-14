<!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fa-solid fa-person-skating"></i> Patinetas<sup>shop</sup>
        </a>
        <div class="collapse navbar-collapse">
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