// Actualizar contador del carrito en todas las páginas
document.addEventListener("DOMContentLoaded", () => {
  
  const cart = JSON.parse(localStorage.getItem("patinetas_shop_cart")) || [];
  console.log(cart)
  const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);

  const cartCounter = document.getElementById("cartCounter");
  if (cartCounter) {
    cartCounter.textContent = totalItems;
  }
});
