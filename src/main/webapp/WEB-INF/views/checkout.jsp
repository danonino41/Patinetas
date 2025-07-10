<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Checkout - PatinetasShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/navbar.jsp"/>
    
    <div class="container my-5">
        <div class="row">
            <div class="col-md-8">
                <h2 class="mb-4">Resumen de Compra</h2>
                
                <div id="checkoutItemsContainer">
                    <!-- Los items del carrito se cargarán aquí dinámicamente -->
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Total del Pedido</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <span id="checkoutSubtotal">$0.00</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>IGV (18%):</span>
                            <span id="checkoutIgv">$0.00</span>
                        </div>
                        <div class="d-flex justify-content-between fw-bold fs-5 mb-3">
                            <span>Total:</span>
                            <span id="checkoutTotal">$0.00</span>
                        </div>
                        
                        <form id="checkoutForm" action="${pageContext.request.contextPath}/procesar-pago" method="POST">
                            <div class="mb-3">
                                <label for="metodoPago" class="form-label">Método de Pago</label>
                                <select class="form-select" id="metodoPago" name="metodoPago" required>
                                    <option value="">Seleccione...</option>
                                    <option value="tarjeta">Tarjeta de Crédito/Débito</option>
                                    <option value="paypal">PayPal</option>
                                    <option value="transferencia">Transferencia Bancaria</option>
                                </select>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100 btn-lg">
                                Confirmar y Pagar
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const cart = JSON.parse(localStorage.getItem('patinetas_shop_cart')) || [];
            const checkoutItemsContainer = document.getElementById('checkoutItemsContainer');
            const checkoutSubtotal = document.getElementById('checkoutSubtotal');
            const checkoutIgv = document.getElementById('checkoutIgv');
            const checkoutTotal = document.getElementById('checkoutTotal');
            
            let subtotal = 0;
            
            if (cart.length === 0) {
                checkoutItemsContainer.innerHTML = `
                    <div class="alert alert-info">
                        No hay productos en tu carrito. <a href="${pageContext.request.contextPath}/productos">Ver productos</a>
                    </div>
                `;
            } else {
                let itemsHtml = '';
                
                cart.forEach(item => {
                    const price = item.price - (item.price * item.discount / 100);
                    const itemTotal = price * item.quantity;
                    subtotal += itemTotal;
                    
                    itemsHtml += `
                        <div class="card mb-3">
                            <div class="row g-0">
                                <div class="col-3">
                                    <img src="${pageContext.request.contextPath}/${item.image}" 
                                         class="img-fluid rounded-start" alt="${item.name}">
                                </div>
                                <div class="col-9">
                                    <div class="card-body">
                                        <h6 class="card-title">${item.name}</h6>
                                        <p class="card-text">
                                            <small class="text-muted">$${price.toFixed(2)} c/u</small>
                                        </p>
                                        <p class="card-text">
                                            Cantidad: ${item.quantity}
                                        </p>
                                        <p class="card-text fw-bold">
                                            Total: $${itemTotal.toFixed(2)}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `;
                });
                
                checkoutItemsContainer.innerHTML = itemsHtml;
            }
            
            const igv = subtotal * 0.18;
            const total = subtotal + igv;
            
            checkoutSubtotal.textContent = `$${subtotal.toFixed(2)}`;
            checkoutIgv.textContent = `$${igv.toFixed(2)}`;
            checkoutTotal.textContent = `$${total.toFixed(2)}`;
            
            // Manejar el envío del formulario
            document.getElementById('checkoutForm').addEventListener('submit', async (e) => {
                e.preventDefault();
                
                try {
                    // Verificar stock antes de procesar
                    const response = await fetch('${pageContext.request.contextPath}/api/verificar-stock', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(cart)
                    });
                    
                    const result = await response.json();
                    
                    if (result.success) {
                        // Procesar pago
                        const formData = new FormData(e.target);
                        const paymentMethod = formData.get('metodoPago');
                        
                        const paymentResponse = await fetch('${pageContext.request.contextPath}/procesar-pago', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({
                                items: cart,
                                paymentMethod: paymentMethod,
                                subtotal: subtotal,
                                igv: igv,
                                total: total
                            })
                        });
                        
                        const paymentResult = await paymentResponse.json();
                        
                        if (paymentResult.success) {
                            // Limpiar carrito y redirigir a confirmación
                            localStorage.removeItem('patinetas_shop_cart');
                            window.location.href = '${pageContext.request.contextPath}/confirmacion?codigo=' + paymentResult.codigo;
                        } else {
                            alert('Error al procesar el pago: ' + paymentResult.message);
                        }
                    } else {
                        alert('Error: ' + result.message);
                        // Actualizar carrito con stock disponible
                        localStorage.setItem('patinetas_shop_cart', JSON.stringify(result.updatedCart));
                        window.location.reload();
                    }
                } catch (error) {
                    console.error('Error:', error);
                    alert('Ocurrió un error al procesar tu pedido');
                }
            });
        });
    </script>
</body>
</html>