<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Restablecer Contraseña</title>
        <link rel="icon" href="${pageContext.request.contextPath}/static/imagen/logo.png" type="image/x-icon">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <style>
            .password-container { position: relative; }
            .toggle-password {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="card shadow">
                        <div class="card-body">
                            <h3 class="card-title text-center mb-4">Restablecer Contraseña</h3>

                            <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                                <p class="error-message">
                                    <%= error%>
                                </p>
                            <% }%>

                            <% String success=(String) request.getAttribute("success"); if (success !=null) { %>
                                <p class="success-message">
                                    <%= success%>
                                </p>
                            <% }%>

                            <form action="reset-password" method="POST">
                                <input type="hidden" name="token" value="${param.token}">

                                <div class="mb-3 password-container">
                                    <label for="nuevaContraseña" class="form-label">Nueva Contraseña</label>
                                    <input type="password" class="form-control" id="nuevaContraseña" 
                                           name="nuevaContraseña" required>
                                    <span class="toggle-password" onclick="togglePassword('nuevaContraseña')">
                                        <i class="bi bi-eye"></i>
                                    </span>
                                </div>

                                <div class="mb-3 password-container">
                                    <label for="confirmarContraseña" class="form-label">Confirmar Contraseña</label>
                                    <input type="password" class="form-control" id="confirmarContraseña" 
                                           name="confirmarContraseña" required>
                                    <span class="toggle-password" onclick="togglePassword('confirmarContraseña')">
                                        <i class="bi bi-eye"></i>
                                    </span>
                                </div>

                                <button type="submit" class="btn btn-primary w-100">Actualizar Contraseña</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function togglePassword(fieldId) {
                const field = document.getElementById(fieldId);
                const icon = field.nextElementSibling.querySelector('i');

                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    field.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>