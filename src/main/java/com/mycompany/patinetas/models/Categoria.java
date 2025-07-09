package com.mycompany.patinetas.models;

public class Categoria {
    private int id;
    private String nombre;
    private String descripcion;
    private Double precio;
    private int stock;
    private String imagen;

    public Categoria(String descripcion, int id, String imagen, String nombre, Double precio, int stock) {
        this.descripcion = descripcion;
        this.id = id;
        this.imagen = imagen;
        this.nombre = nombre;
        this.precio = precio;
        this.stock = stock;
    }

    public Categoria() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    
    
}
