<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${producto.nombre} - PatinetasShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .product-image {
            max-height: 500px;
            object-fit: contain;
        }
        .quantity-control {
            width: 120px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp"/>
    
    <div class="container my-5">
        <div class="row">
            <div class="col-md-6">
                <img src="${pageContext.request.contextPath}/${producto.imagen}" 
                     class="img-fluid rounded product-image" alt="${producto.nombre}">
            </div>
            <div class="col-md-6">
                <h1>${producto.nombre}</h1>
                <p class="text-muted">Código: ${producto.id}</p>
                

                
                <p class="lead">${producto.descripcion}</p>
                
                <div class="mb-3">
                    <span class="fw-bold">Disponibilidad:</span>
                    <c:choose>
                        <c:when test="${producto.stock > 10}">
                            <span class="text-success">En stock (${producto.stock} unidades)</span>
                        </c:when>
                        <c:when test="${producto.stock > 0}">
                            <span class="text-warning">Últimas unidades (${producto.stock})</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">Agotado</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="d-flex align-items-center mb-4">
                    <div class="input-group quantity-control me-3">
                        <button class="btn btn-outline-secondary minus-btn" type="button">-</button>
                        <input type="number" class="form-control text-center quantity-input" 
                               value="1" min="1" max="${producto.stock}">
                        <button class="btn btn-outline-secondary plus-btn" type="button">+</button>
                    </div>
                    
                    <button class="btn btn-primary add-to-cart" 
                            ${producto.stock <= 0 ? 'disabled' : ''}>
                        <i class="bi bi-cart-plus"></i> Añadir al carrito
                    </button>
                </div>
                
                <div class="alert alert-success d-none added-to-cart-alert">
                    ¡Producto añadido al carrito!
                </div>
            </div>
        </div>
    </div>

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
        const minusBtn = document.querySelector('.minus-btn');
        const plusBtn = document.querySelector('.plus-btn');
        const quantityInput = document.querySelector('.quantity-input');
        const addToCartBtn = document.querySelector('.add-to-cart');
        const cartItemsContainer = document.getElementById('cartItemsContainer');
        const cartSubtotal = document.getElementById('cartSubtotal');
        const cartIgv = document.getElementById('cartIgv');
        const cartTotal = document.getElementById('cartTotal');
        const checkoutBtn = document.getElementById('checkoutBtn');
        const cartCounter = document.getElementById('cartCounter');
        const addedToCartAlert = document.querySelector('.added-to-cart-alert');
        
        // Actualizar cantidad
        minusBtn.addEventListener('click', () => {
            let value = parseInt(quantityInput.value);
            if (value > 1) {
                quantityInput.value = value - 1;
            }
        });
        
        plusBtn.addEventListener('click', () => {
            let value = parseInt(quantityInput.value);
            if (value < ${producto.stock}) {
                quantityInput.value = value + 1;
            }
        });
        
        // Añadir al carrito
        addToCartBtn.addEventListener('click', () => {
            const productId = ${producto.id};
            const quantity = parseInt(quantityInput.value);
            const product = {
                id: productId,
                name: '${producto.nombre}',
                price: ${producto.precio},
                image: '${producto.imagen}',
                stock: ${producto.stock},
                quantity: quantity
            };
            
            addToCart(product);
            updateCartUI();
            showAddedToCartAlert();
        });
        
        // Funciones del carrito
        function getCart() {
            const cart = localStorage.getItem(CART_KEY);
            return cart ? JSON.parse(cart) : [];
        }
        
        function saveCart(cart) {
            localStorage.setItem(CART_KEY, JSON.stringify(cart));
        }
        
        function addToCart(product) {
            let cart = getCart();
            const existingItemIndex = cart.findIndex(item => item.id === product.id);
            
            if (existingItemIndex !== -1) {
                // Actualizar cantidad si ya existe
                cart[existingItemIndex].quantity += product.quantity;
            } else {
                // Añadir nuevo producto
                cart.push(product);
            }
            
            saveCart(cart);
        }
        
        function updateCartUI() {
            const cart = getCart();
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
                    const price = item.price - (item.price * item.discount / 100);
                    const itemTotal = price * item.quantity;
                    subtotal += itemTotal;
                    
                    itemsHtml += `
                        <div class="card mb-3 cart-item" data-id="${item.id}">
                            <div class="row g-0">
                                <div class="col-3">
                                    <img src="${pageContext.request.contextPath}/${item.image}" 
                                         class="img-fluid rounded-start" alt="${item.name}">
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
                
                // Agregar event listeners a los nuevos elementos
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
                
                saveCart(cart);
                updateCartUI();
            }
        }
        
        function removeItem(e) {
            const itemElement = e.target.closest('.cart-item');
            const itemId = parseInt(itemElement.dataset.id);
            
            let cart = getCart();
            cart = cart.filter(item => item.id !== itemId);
            
            saveCart(cart);
            updateCartUI();
        }
        
        function showAddedToCartAlert() {
            addedToCartAlert.classList.remove('d-none');
            setTimeout(() => {
                addedToCartAlert.classList.add('d-none');
            }, 3000);
        }
        
        // Inicializar carrito al cargar la página
        document.addEventListener('DOMContentLoaded', () => {
            updateCartUI();
            
            // Si hay parámetros en la URL para añadir al carrito
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('addToCart')) {
                const productId = ${producto.id};
                const quantity = parseInt(quantityInput.value);
                const product = {
                    id: productId,
                    name: '${producto.nombre}',
                    price: ${producto.precio},
                    image: '${producto.imagen}',
                    stock: ${producto.stock},
                    quantity: quantity
                };
                
                addToCart(product);
                updateCartUI();
                
                // Mostrar el offcanvas del carrito
                const cartOffcanvas = new bootstrap.Offcanvas(document.getElementById('cartOffcanvas'));
                cartOffcanvas.show();
            }
        });
    </script>
</body>
</html>