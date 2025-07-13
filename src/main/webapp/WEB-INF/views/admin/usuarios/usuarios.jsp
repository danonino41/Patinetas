<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Usuarios - Administración</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    </head>
    <body>
        <jsp:include page="/WEB-INF/includes/adminNavbar.jsp"/>
        
        <div class="container-fluid mt-4">
            <div class="row">
                
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Gestión de Usuarios</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <a href="${pageContext.request.contextPath}/admin/usuarios?accion=nuevo" class="btn btn-sm btn-primary">
                                <i class="bi bi-plus-circle"></i> Nuevo Usuario
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
                    
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Buscar Usuarios</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/usuarios" method="post" class="row g-3">
                                <input type="hidden" name="accion" value="buscar">
                                <div class="col-md-10">
                                    <input type="text" class="form-control" name="busqueda" 
                                           placeholder="Buscar por nombre o email..." value="${busqueda}">
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-search"></i> Buscar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">Listado de Usuarios</h5>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table id="usuariosTable" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Email</th>
                                            <th>Rol</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${usuarios}" var="usuario">
                                            <tr>
                                                <td>${usuario.id}</td>
                                                <td>${usuario.nombre}</td>
                                                <td>${usuario.email}</td>
                                                <td>
                                                    <span class="badge ${usuario.rol eq 'admin' ? 'bg-primary' : 'bg-secondary'}">
                                                        ${usuario.rol}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/usuarios?accion=editar&id=${usuario.id}" 
                                                       class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-pencil"></i> Editar
                                                    </a>
                                                    <button onclick="confirmarEliminacion(${usuario.id}, '${usuario.nombre}')" 
                                                            class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash"></i> Eliminar
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <!-- Modal de confirmación -->
        <div class="modal fade" id="confirmarEliminarModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmar Eliminación</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="mensajeConfirmacion">¿Estás seguro de eliminar al usuario?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a id="btnEliminarConfirmado" href="#" class="btn btn-danger">Eliminar</a>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
        
        <script>
            $(document).ready(function() {
                $('#usuariosTable').DataTable({
                    language: {
                        url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json'
                    },
                    order: [[1, 'asc']]
                });
            });
            
            const contextPath = '${pageContext.request.contextPath}';
            
            function confirmarEliminacion(id, nombre) {
                console.log(id);
                console.log(nombre);
                const modal = new bootstrap.Modal(document.getElementById('confirmarEliminarModal'));
                document.getElementById('mensajeConfirmacion').textContent = 
                    "¿Estás seguro de eliminar al usuario " + nombre + "?";
                document.getElementById('btnEliminarConfirmado').href = contextPath + "/admin/usuarios?accion=eliminar&id="+id;
                modal.show();
            }
        </script>
    </body>
</html>