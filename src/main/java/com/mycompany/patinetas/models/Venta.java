package com.mycompany.patinetas.models;

import java.util.Date;

public class Venta {
    private int id;
    private Usuario usuario;
    private Date fecha;
    private Double total;
    
    public Venta(int id, Usuario usuario, Date fecha, Double total) {
        this.id = id;
        this.usuario = usuario;
        this.fecha = fecha;
        this.total = total;
    }

    public Venta() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }
    

    
}
