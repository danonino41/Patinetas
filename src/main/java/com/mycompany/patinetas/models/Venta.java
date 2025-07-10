package com.mycompany.patinetas.models;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class Venta {
    private int id;
    private int usuarioId;
    private LocalDateTime fecha;
    private BigDecimal total;
    
    // Constructores
    public Venta(int id, int usuarioId, LocalDateTime fecha, BigDecimal total) {
        this.id = id;
        this.usuarioId = usuarioId;
        this.fecha = fecha;
        this.total = total;
    }

    public Venta() {
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }
    
}
