<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuario - Administración</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/includes/navbar.jsp"/>
        
        <div class="container-fluid mt-4">
            <div class="row">
                
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1>${empty usuario.id ? 'Nueva' : 'Editar'} Usuario</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-sm btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                        </div>
                    </div>
                                
                    <c:if test="${not empty mensajeExito}">
                        <div class="alert alert-success alert-dismissible fade show">
                            ${mensajeExito}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="mensajeExito" scope="session"/>
                    </c:if>
                                
                    <c:if test="${not empty mensajeError}">
                        <div class="alert alert-danger alert-dismissible fade show">
                            ${mensajeError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="mensajeError" scope="session"/>
                    </c:if>
                    
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Datos del Usuario</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/usuarios" method="post">
                                <input type="hidden" name="accion" value=${empty usuario.id ? 'actualizar' : 'registrar'}>
                                <input type="hidden" name="id" value="${usuario.id}">
                                
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" 
                                           value="${usuario.nombre}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${usuario.email}" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="rol" class="form-label">Rol</label>
                                    <select class="form-select" id="rol" name="rol" required>
                                        <option value="usuario" ${usuario.rol eq 'usuario' ? 'selected' : ''}>Usuario</option>
                                        <option value="admin" ${usuario.rol eq 'admin' ? 'selected' : ''}>Administrador</option>
                                        <option value="vendedor" ${usuario.rol eq 'vendedor' ? 'selected' : ''}>Vendedor</option>
                                    </select>
                                </div>
                                
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-save"></i> Guardar Cambios
                                </button>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>