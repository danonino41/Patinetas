package com.mycompany.patinetas.models;

import java.util.ArrayList;
import java.util.List;

public class Carrito {
    private List<ItemCarrito> items;
    
    public Carrito() {
        items = new ArrayList<>();
    }
    
    public void agregarItem(Producto producto, int cantidad) {
        // Buscar si el producto ya está en el carrito
        for (ItemCarrito item : items) {
            if (item.getProducto().getId() == producto.getId()) {
                item.setCantidad(item.getCantidad() + cantidad);
                return;
            }
        }
        items.add(new ItemCarrito(producto, cantidad));
    }
    
    public void eliminarItem(int productoId) {
        items.removeIf(item -> item.getProducto().getId() == productoId);
    }
    
    public void actualizarCantidad(int productoId, int cantidad) {
        for (ItemCarrito item : items) {
            if (item.getProducto().getId() == productoId) {
                if (cantidad <= 0) {
                    eliminarItem(productoId);
                } else {
                    item.setCantidad(cantidad);
                }
                return;
            }
        }
    }
    
    public double getTotal() {
        return items.stream().mapToDouble(ItemCarrito::getSubtotal).sum();
    }
    
    public List<ItemCarrito> getItems() {
        return items;
    }
    
    public void vaciar() {
        items.clear();
    }
    
    public int getTotalItems() {
        return items.stream().mapToInt(ItemCarrito::getCantidad).sum();
    }
}