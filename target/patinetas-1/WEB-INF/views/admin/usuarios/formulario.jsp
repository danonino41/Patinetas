<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario - Administración</title>
    <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-header {
            background-color: #6f42c1;
            color: white;
        }
        .btn-primary {
            background-color: #6f42c1;
            border-color: #6f42c1;
        }
        .btn-secondary {
            background-color: #e9ecef;
            color: #495057;
        }
        .btn-secondary:hover {
            background-color: #d6d8db;
        }
        .form-control:focus {
            border-color: #6f42c1;
            box-shadow: 0 0 0 0.25rem rgba(111, 66, 193, 0.25);
        }

        @media (max-width: 768px) {
            .header h2 {
                font-size: 1.5rem;
            }
            .btn-sm {
                font-size: 0.875rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
    
    <div class="container-fluid mt-4">
        <div class="row">
            <main class="col-md-9 m-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h2>
                        <i class="bi bi-people-fill me-2"></i> ${empty usuario.id ? 'Nuevo' : 'Editar'} Usuario
                    </h2>
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
                            <input type="hidden" name="accion" value="${empty usuario.id ? 'registrar' : 'actualizar'}">
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
                                <label for="contraseña">Contraseña</label>
                                <input type="password" class="form-control" id="contraseña" name="contraseña"
                                       placeholder="${empty usuario.id ? 'Contraseña' : 'Dejar en blanco para no cambiar'}" 
                                       ${empty usuario.id ? 'required' : ''}>
                            </div>
                            
                            <div class="mb-3">
                                <label for="rol" class="form-label">Rol</label>
                                <select class="form-select" id="rol" name="rol" required>
                                    <option value="usuario" ${usuario.rol eq 'usuario' ? 'selected' : ''}>Usuario</option>
                                    <option value="admin" ${usuario.rol eq 'admin' ? 'selected' : ''}>Administrador</option>
                                </select>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save"></i> ${empty usuario.id ? 'Registrar' : 'Actualizar'}
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-secondary">
                                Cancelar
                            </a>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
