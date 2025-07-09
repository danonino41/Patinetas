<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="register-container">
            <h2>Crear Cuenta</h2>
                <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                    <div class="error-message">
                        <%= error%>
                    </div>
                <% }%>

                    <form action="register" method="POST">
                        <label for="nombre">Nombre:</label>
                        <input type="text" name="nombre" id="nombre" required
                            placeholder="Introduce tu nombre completo" />

                        <label for="email">Email:</label>
                        <input type="email" name="email" id="email" required
                            placeholder="Introduce tu correo electrónico" />

                        <label for="contraseña">Password</label>
                        <input type="password" class="form-control" id="contraseña" name="contraseña"
                            placeholder="Contraseña" required>
                        
                        <label for="confirmarContraseña">Password</label>
                        <input type="password" class="form-control" id="confirmarContraseña" name="confirmarContraseña"
                            placeholder="Contraseña" required>

                        <div class="form-group form-check">
                            <input type="checkbox" class="form-check-input" id="mostrarContrasena">
                            <label class="form-check-label" for="mostrarContrasena">Ver contraseña</label>
                        </div>
                        <BR>
                        <button type="submit">Registrarse</button>
                    </form>

                    <div class="login-link">
                        <p>Ya tienes cuenta? <a href="login.jsp">Iniciar sesión</a></p>
                    </div>
        </div>

        <script>
            const passwordInput = document.getElementById('contraseña');
            const confirmPassowrdInput = document.getElementById('confirmarContraseña');
            const mostrarCheckbox = document.getElementById('mostrarContrasena');
            mostrarCheckbox.addEventListener('change', function () {
                if (this.checked) {
                    passwordInput.type = 'text';
                    confirmPassowrdInput.type = 'text';
                } else {
                    passwordInput.type = 'password';
                    confirmPassowrdInput.type = 'password';
                }
            });
        </script>
    </body>

    </html>