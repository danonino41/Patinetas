package com.mycompany.patinetas.models;

public class Producto {
    private int id;
    private String nombre;
    private String descripcion;
    private Double precio;
    private int stock;
    private String imagen;
    private int categoriaId;
    private int proveedorId;

    // Constructores
    public Producto(String nombre, String descripcion, Double precio, int stock, String imagen, int categoriaId, int proveedorId) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.imagen = imagen;
        this.categoriaId = categoriaId;
        this.proveedorId = proveedorId;
    }

    public Producto() {
    }

    // Getters y setters
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

    public int getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(int categoriaId) {
        this.categoriaId = categoriaId;
    }

    public int getProveedorId() {
        return proveedorId;
    }

    public void setProveedorId(int proveedorId) {
        this.proveedorId = proveedorId;
    }


}
