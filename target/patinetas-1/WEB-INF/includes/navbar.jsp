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

    html,
    body {
        height: 100%;
        margin: 0;
    }

    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    .main-content {
        flex: 1;
    }
</style>
    
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">NOSOTROS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">CONTACTO</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/busqueda">PRODUCTOS</a>
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
                                <c:if test="${sessionScope.usuario.rol eq 'admin'}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                        <i class="bi bi-speedometer2"></i> Panel Admin
                                    </a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link position-relative" href="#" data-bs-toggle="offcanvas" data-bs-target="#cartOffcanvas" onclick="loadCart()">
                                <i class="bi bi-cart fs-5"></i>
                                <span class="position-absolute top-52 start-60 translate-middle badge rounded-pill bg-primary" id="cartCounter">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.carrito && not empty sessionScope.carrito.items}">
                                            ${sessionScope.carrito.items.size()}
                                        </c:when>
                                        <c:otherwise>
                                            0
                                        </c:otherwise>
                                    </c:choose>
                                </span>
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
                            <a class="nav-link position-relative" href="#" data-bs-toggle="offcanvas" data-bs-target="#cartOffcanvas" onclick="loadCart()">
                                <i class="bi bi-cart fs-5"></i>
                                <span class="position-absolute top-52 start-60 translate-middle badge rounded-pill bg-primary" id="cartCounter">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.carrito && not empty sessionScope.carrito.items}">
                                            ${sessionScope.carrito.getTotalItems()}
                                        </c:when>
                                        <c:otherwise>
                                            0
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
                
<!-- Offcanvas del Carrito -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="cartOffcanvas">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">Tu Carrito</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body">
        <div id="cartItemsContainer">
            <!-- Los items del carrito se cargarán aquí dinámicamente -->
            <div class="text-center my-5" id="emptyCartMessage">
                <p>Tu carrito está vacío</p>
            </div>
        </div>
        <div class="border-top pt-3" id="cartSummary" style="display: none;">
            <div class="d-flex justify-content-between fw-bold">
                <span>Total:</span>
                <span id="cartTotal">$0.00</span>
            </div>
            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary w-100 mt-3" id="checkoutBtn">
                Finalizar compra
            </a>
        </div>
    </div>
</div>
                


<!-- Script para manejar el carrito -->
<script>
// Función para cargar el carrito via AJAX
function loadCart() {
    fetch('${pageContext.request.contextPath}/api/carrito')
        .then(response => response.json())
        .then(data => {
            updateCartUI(data);
        })
        .catch(error => {
            console.error('Error al cargar el carrito:', error);
        });
}

// Función para actualizar la UI del carrito
function updateCartUI(cartData) {
    const cartItemsContainer = document.getElementById('cartItemsContainer');
    const cartCounter = document.getElementById('cartCounter');
    const emptyCartMessage = document.getElementById('emptyCartMessage');
    const cartSummary = document.getElementById('cartSummary');
    
    console.log(cartData);
    
    if (cartData.items && cartData.items.length > 0) {
        // Actualizar contador
        // cartCounter.textContent = cartData.items.length;
        
        // Ocultar mensaje de carrito vacío
        emptyCartMessage.style.display = 'none';
        
        // Generar HTML para los items del carrito
        let itemsHTML = '';
        cartData.items.forEach(item => {
            itemsHTML += `
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div class="d-flex">
                                <img src="${pageContext.request.contextPath}/\${item.producto.imagen}" 
                                     alt="\${item.producto.nombre}" 
                                     class="rounded me-3" 
                                     style="width: 64px; height: 64px; object-fit: cover;">
                                <div>
                                    <h6 class="mb-1">\${item.producto.nombre}</h6>
                                    <small class="text-muted">\${item.producto.descripcion.substring(0, 30)}...</small>
                                </div>
                            </div>
                            <div class="text-end">
                                <div class="input-group input-group-sm" style="width: 100px;">
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="updateCartItem(\${item.producto.id}, \${item.cantidad - 1})">-</button>
                                    <input type="text" class="form-control text-center" 
                                           value="\${item.cantidad}" readonly>
                                    <button class="btn btn-outline-secondary" type="button" 
                                            onclick="updateCartItem(\${item.producto.id}, \${item.cantidad + 1})">+</button>
                                </div>
                                <button class="btn btn-link text-danger p-0 mt-1" 
                                        onclick="removeFromCart(\${item.producto.id})">
                                    <small>Eliminar</small>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            `;
        });
        cartItemsContainer.innerHTML = itemsHTML;
        
        // Actualizar resumen
        document.getElementById('cartTotal').textContent = `\$ \${cartData.total.toFixed(2)}`;
        
        // Mostrar resumen
        cartSummary.style.display = 'block';
    } else {
        // Mostrar carrito vacío
        cartCounter.textContent = '0';
        cartItemsContainer.innerHTML = `
            <div class="text-center my-5" id="emptyCartMessage">
                <p>Tu carrito está vacío</p>
            </div>
        `;
        cartSummary.style.display = 'none';
    }
}

// Función para actualizar cantidad de un item
function updateCartItem(productId, newQuantity) {
    if (newQuantity < 1) {
        removeFromCart(productId);
        return;
    }
    
    fetch('${pageContext.request.contextPath}/api/carrito/actualizar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `productoId=\${productId}&cantidad=\${newQuantity}`
    })
    .then(response => response.json())
    .then(data => {
        updateCartUI(data);
    })
    .catch(error => {
        console.error('Error al actualizar el carrito:', error);
    });
}

// Función para eliminar un item del carrito
function removeFromCart(productId) {
    fetch('${pageContext.request.contextPath}/api/carrito/eliminar', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `productoId=\${productId}`
    })
    .then(response => response.json())
    .then(data => {
        updateCartUI(data);
    })
    .catch(error => {
        console.error('Error al eliminar del carrito:', error);
    });
}

// Cargar el carrito cuando se abre el offcanvas
document.getElementById('cartOffcanvas').addEventListener('show.bs.offcanvas', function () {
    loadCart();
});
</script>