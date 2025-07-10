<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">PatinetasShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/productos">Productos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">Nosotros</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">Contacto</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.usuario}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle"></i> ${sessionScope.usuario.nombre}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/perfil">Mi Perfil</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mis-pedidos">Mis Pedidos</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#cartOffcanvas">
                                <i class="bi bi-cart"></i>
                                <span class="badge bg-primary" id="cartCounter">0</span>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesión
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                <i class="bi bi-person-plus"></i> Registrarse
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#cartOffcanvas">
                                <i class="bi bi-cart"></i>
                                <span class="badge bg-primary" id="cartCounter">0</span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
    