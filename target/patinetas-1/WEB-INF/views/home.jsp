<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>PatinetasShop - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5));
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            margin-bottom: 50px;
        }
        .card-producto {
            transition: transform 0.3s;
        }
        .card-producto:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .precio-oferta {
            color: #dc3545;
            font-weight: bold;
        }
        .precio-original {
            text-decoration: line-through;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp"/>
    
    <!-- Hero Section -->
    <section class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 fw-bold">Las mejores patinetas del mercado</h1>
            <p class="lead">Encuentra tu patineta perfecta para moverte por la ciudad</p>
            <a href="${pageContext.request.contextPath}/productos" class="btn btn-primary btn-lg">Ver Catálogo</a>
        </div>
    </section>

    <!-- Productos Destacados -->
    <section class="container mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Productos Destacados</h2>
            <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-primary">Ver todos</a>
        </div>
        
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${productosDestacados}" var="producto">
                <div class="col">
                    <div class="card h-100 card-producto">
                        <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                             class="card-img-top" alt="${producto.nombre}" 
                             style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">${producto.nombre}</h5>
                            <p class="card-text text-truncate">${producto.descripcion}</p>
                            <h5 class="text-primary">$${producto.precio}</h5>
                        </div>
                        <div class="card-footer bg-white">
                            <a href="${pageContext.request.contextPath}/productos?id=${producto.id}" 
                               class="btn btn-primary w-100">
                                Ver Detalles
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Ofertas Especiales -->
    <c:if test="${not empty productosOferta}">
        <section class="bg-light py-5">
            <div class="container">
                <h2 class="text-center mb-5">Ofertas Especiales</h2>
                
                <div class="row row-cols-1 row-cols-md-4 g-4">
                    <c:forEach items="${productosOferta}" var="producto">
                        <div class="col">
                            <div class="card h-100 card-producto">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    producto.descuento
                                </span>
                                <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                                     class="card-img-top" alt="${producto.nombre}" 
                                     style="height: 150px; object-fit: cover;">
                                <div class="card-body">
                                    <h5 class="card-title">${producto.nombre}</h5>
                                    <div>
                                        <span class="precio-oferta">
                                            
                                        </span>
                                        <span class="precio-original">$${producto.precio}</span>
                                    </div>
                                </div>
                                <div class="card-footer bg-white">
                                    <a href="${pageContext.request.contextPath}/productos?id=${producto.id}" 
                                       class="btn btn-danger w-100">
                                        Aprovechar Oferta
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>PatinetasShop</h5>
                    <p>La mejor selección de patinetas eléctricas y accesorios.</p>
                </div>
                <div class="col-md-4">
                    <h5>Enlaces Rápidos</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Inicio</a></li>
                        <li><a href="#" class="text-white">Productos</a></li>
                        <li><a href="#" class="text-white">Contacto</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contacto</h5>
                    <p><i class="bi bi-envelope"></i> info@patinetasshop.com</p>
                    <p><i class="bi bi-telephone"></i> +1 234 567 890</p>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- Offcanvas del Carrito -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="cartOffcanvas">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title">Tu Carrito</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <div id="cartItemsContainer">
                <!-- Los items del carrito se cargarán aquí dinámicamente -->
                <div class="text-center my-5">
                    <p>Tu carrito está vacío</p>
                </div>
            </div>
            <div class="border-top pt-3">
                <div class="d-flex justify-content-between mb-2">
                    <span>Subtotal:</span>
                    <span id="cartSubtotal">$0.00</span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>IGV (18%):</span>
                    <span id="cartIgv">$0.00</span>
                </div>
                <div class="d-flex justify-content-between fw-bold">
                    <span>Total:</span>
                    <span id="cartTotal">$0.00</span>
                </div>
                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary w-100 mt-3" id="checkoutBtn">
                    Proceder al Pago
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Carrito en localStorage
    const CART_KEY = 'patinetas_shop_cart';
    
    // Elementos del DOM
    const cartItemsContainer = document.getElementById('cartItemsContainer');
    const cartSubtotal = document.getElementById('cartSubtotal');
    const cartIgv = document.getElementById('cartIgv');
    const cartTotal = document.getElementById('cartTotal');
    const checkoutBtn = document.getElementById('checkoutBtn');
    const cartCounter = document.querySelector('#cartCounter');
    
    // Funciones del carrito
    function getCart() {
        const cart = localStorage.getItem(CART_KEY);
        return cart ? JSON.parse(cart) : [];
    }
    
    function updateCartUI() {
        const cart = getCart();
        console.log(cart)
        let subtotal = 0;
        
    if (cart.length === 0) {
        cartItemsContainer.innerHTML = `
            <div class="text-center my-5">
                <p>Tu carrito está vacío</p>
            </div>
        `;
        checkoutBtn.classList.add('disabled');
    } else {
        let itemsHtml = '';
        
        cart.forEach(item => {
            const discount = item.discount || 0;
            const price = item.price - (item.price * discount / 100);
            const itemTotal = price * item.quantity;
            subtotal += itemTotal;
            
            // Construir la ruta de la imagen correctamente
            console.log(item.image);
            const imagePath = item.image.startsWith('/') ? item.image : "/"+item.image;
            console.log(imagePath);
            
            itemsHtml += `
                <div class="card mb-3 cart-item" data-id="${item.id}">
                    <div class="row g-0">
                        <div class="col-3">
                            <img src="${imagePath}"
                                 class="img-fluid rounded-start" alt="${item.name}"
                                 style="height: 100px; object-fit: cover;">
                        </div>
                        <div class="col-7">
                            <div class="card-body">
                                <h6 class="card-title">${item.name}</h6>
                                <p class="card-text">
                                    <small class="text-muted">$${price.toFixed(2)} c/u</small>
                                </p>
                                <div class="input-group input-group-sm">
                                    <button class="btn btn-outline-secondary decrease-btn" type="button">-</button>
                                    <input type="number" class="form-control text-center item-quantity" 
                                           value="${item.quantity}" min="1" max="${item.stock}">
                                    <button class="btn btn-outline-secondary increase-btn" type="button">+</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-2 d-flex align-items-center justify-content-center">
                            <button class="btn btn-link text-danger remove-item">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
        });
            
            cartItemsContainer.innerHTML = itemsHtml;
            checkoutBtn.classList.remove('disabled');
            
            // Agregar event listeners
            document.querySelectorAll('.decrease-btn').forEach(btn => {
                btn.addEventListener('click', decreaseQuantity);
            });
            
            document.querySelectorAll('.increase-btn').forEach(btn => {
                btn.addEventListener('click', increaseQuantity);
            });
            
            document.querySelectorAll('.item-quantity').forEach(input => {
                input.addEventListener('change', updateItemQuantity);
            });
            
            document.querySelectorAll('.remove-item').forEach(btn => {
                btn.addEventListener('click', removeItem);
            });
        }
        
        const igv = subtotal * 0.18;
        const total = subtotal + igv;
        
        cartSubtotal.textContent = `$${subtotal.toFixed(2)}`;
        cartIgv.textContent = `$${igv.toFixed(2)}`;
        cartTotal.textContent = `$${total.toFixed(2)}`;
        
        // Actualizar contador en el navbar
        const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
        if (cartCounter) {
            cartCounter.textContent = totalItems;
            cartCounter.style.display = totalItems > 0 ? 'inline-block' : 'none';
        }
    }
    
    function decreaseQuantity(e) {
        const itemElement = e.target.closest('.cart-item');
        const itemId = parseInt(itemElement.dataset.id);
        const quantityInput = itemElement.querySelector('.item-quantity');
        let quantity = parseInt(quantityInput.value);
        
        if (quantity > 1) {
            quantityInput.value = quantity - 1;
            updateCartItemQuantity(itemId, quantity - 1);
        }
    }
    
    function increaseQuantity(e) {
        const itemElement = e.target.closest('.cart-item');
        const itemId = parseInt(itemElement.dataset.id);
        const quantityInput = itemElement.querySelector('.item-quantity');
        let quantity = parseInt(quantityInput.value);
        const cart = getCart();
        const item = cart.find(item => item.id === itemId);
        
        if (quantity < item.stock) {
            quantityInput.value = quantity + 1;
            updateCartItemQuantity(itemId, quantity + 1);
        }
    }
    
    function updateItemQuantity(e) {
        const itemElement = e.target.closest('.cart-item');
        const itemId = parseInt(itemElement.dataset.id);
        const quantity = parseInt(e.target.value);
        const cart = getCart();
        const item = cart.find(item => item.id === itemId);
        
        if (quantity >= 1 && quantity <= item.stock) {
            updateCartItemQuantity(itemId, quantity);
        } else {
            e.target.value = item.quantity;
        }
    }
    
    function updateCartItemQuantity(itemId, quantity) {
        let cart = getCart();
        const itemIndex = cart.findIndex(item => item.id === itemId);
        
        if (itemIndex !== -1) {
            if (quantity <= 0) {
                cart.splice(itemIndex, 1);
            } else {
                cart[itemIndex].quantity = quantity;
            }
            
            localStorage.setItem(CART_KEY, JSON.stringify(cart));
            updateCartUI();
        }
    }
    
    function removeItem(e) {
        const itemElement = e.target.closest('.cart-item');
        const itemId = parseInt(itemElement.dataset.id);
        
        let cart = getCart();
        cart = cart.filter(item => item.id !== itemId);
        
        localStorage.setItem(CART_KEY, JSON.stringify(cart));
        updateCartUI();
    }
    
    // Inicializar carrito al cargar la página
    document.addEventListener('DOMContentLoaded', () => {
        updateCartUI();
    });
</script>
</body>
</html>