package com.mycompany.patinetas.models;

public class Detalle_venta {
    private int id;
    private Venta venta;
    private Producto producto;
    private int cantidad;
    private Double subtotal;

    public Detalle_venta(int cantidad, int id, Producto producto, Double subtotal, Venta venta) {
        this.cantidad = cantidad;
        this.id = id;
        this.producto = producto;
        this.subtotal = subtotal;
        this.venta = venta;
    }

    public Detalle_venta() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Venta getVenta() {
        return venta;
    }

    public void setVenta(Venta venta) {
        this.venta = venta;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }


    
}
