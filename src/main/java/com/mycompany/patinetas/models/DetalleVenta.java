package com.mycompany.patinetas.models;

import java.math.BigDecimal;

public class DetalleVenta {
    private int id;
    private int ventaId;
    private int productoId;
    private int cantidad;
    private BigDecimal subtotal;

    // Constructores
    public DetalleVenta(int id, int ventaId, int productoId, int cantidad, BigDecimal subtotal) {
        this.id = id;
        this.ventaId = ventaId;
        this.productoId = productoId;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
    }

    public DetalleVenta() {
    }

    // Getters y setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVentaId() {
        return ventaId;
    }

    public void setVentaId(int ventaId) {
        this.ventaId = ventaId;
    }

    public int getProductoId() {
        return productoId;
    }

    public void setProductoId(int productoId) {
        this.productoId = productoId;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }
    

    
}
