<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${empty proveedor.id ? 'Nueva' : 'Editar'} Proveedor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
    <div class="container mt-4">
        <h1>${empty proveedor.id ? 'Nueva' : 'Editar'} Proveedor</h1>
        
        <form action="${pageContext.request.contextPath}/admin/proveedores" method="post">
            <input type="hidden" name="id" value="${proveedor.id}">
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="${proveedor.nombre}" required>
            </div>
            
            <div class="mb-3">
                <label for="direccion" class="form-label">Dirección</label>
                <input type="text" class="form-control" id="direccion" name="direccion">${proveedor.direccion}</input>
            </div>
            
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="number" class="form-control" id="telefono" name="telefono">${proveedor.telefono}</input>
            </div>
            
            <div class="mb-3">
                <label for="email" class="form-label">Teléfono</label>
                <input type="email" class="form-control" id="email" name="email">${proveedor.email}</input>
            </div>
            
            <button type="submit" class="btn btn-primary">Guardar</button>
            <a href="${pageContext.request.contextPath}/admin/categorias" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
</body>
</html>