<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&family=Poppins:wght@400;600&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
        }

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

        .navbar-brand:hover {
            color: #ff3333;
        }

        .navbar-nav .nav-item {
            margin-right: 1rem;
        }

        .navbar-nav .nav-link {
            color: #e0e0e0;
            font-size: 1.1rem;
            text-transform: capitalize;
            transition: color 0.3s ease;
            font-family: 'Roboto Condensed', sans-serif;
        }

        .navbar-nav .nav-link:hover {
            color: #ff3333;
        }

        .nav-item.dropdown .dropdown-menu {
            background-color: #343a40;
            border: none;
        }

        .nav-item.dropdown .dropdown-item {
            color: #fff;
            font-family: 'Roboto', sans-serif;
        }

        .nav-item.dropdown .dropdown-item:hover {
            background-color: #495057;
            color: #ffc107;
        }

        .navbar-nav .nav-link i {
            font-size: 1.3rem;
        }

        #cartCounter {
            font-size: 1rem;
            background-color: #007bff;
            color: #fff;
            border-radius: 50%;
            padding: 0.2rem 0.5rem;
            margin-left: 0.5rem;
            font-family: 'Poppins', sans-serif;
        }

        .offcanvas {
            background-color: #364034;
            color: #fff;
        }

        .navbar-toggler {
            border: none;
            font-family: 'Poppins', sans-serif;
        }

        .navbar-toggler-icon {
            background-color: #fff;
        }

        @media (max-width: 991px) {

            .navbar-brand {
                font-size: 55px;
            }

            .navbar-nav {
                text-align: center;
            }

            .navbar-nav .nav-item {
                margin-right: 0;
            }

            .navbar-nav .nav-link {
                font-size: 35px;
            }

            #cartCounter {
                font-size: 0.9rem;
            }

            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba%288, 8, 8, 0.7%29' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
            }
        }
    </style>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fa-solid fa-person-skating"></i> Patinetas<sup>shop</sup>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/productos">PRODUCTOS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">NOSOTROS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">CONTACTO</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.usuario}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                    data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle"></i> ${sessionScope.usuario.nombre}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/perfil">Mi
                                            Perfil</a></li>
                                    <li><a class="dropdown-item"
                                            href="${pageContext.request.contextPath}/mis-pedidos">Mis Pedidos</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="bi bi-box-arrow-right"></i> Cerrar Sesion
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
                                    <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesion
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