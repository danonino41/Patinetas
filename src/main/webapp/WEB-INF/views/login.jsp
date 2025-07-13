<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="static/css/style.css">
    </head>

    <body>
        <div class="login-container">
            <h2>Iniciar sesión</h2>
            <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                <p class="error-message">
                    <%= error%>
                </p>
            <% }%>
                
            <form action="login" method="POST">
                <label for="correo">Correo electrónico:</label>
                <input type="email" id="email" name="email" required
                    placeholder="Introduce tu correo electrónico">

                <label for="contraseña">Contraseña:</label>
                <input type="password" id="contraseña" name="contraseña" required
                    placeholder="Introduce tu contraseña">

                <div class="form-group form-check">
                    <input type="checkbox" id="mostrarContrasena">
                    <label for="mostrarContrasena">Ver contraseña</label>
                </div>
                <BR>
                <input type="submit" value="Iniciar sesión">
            </form>

            <div class="register-link">
                <p>No tienes cuenta? <a href="register">Registrarse</a></p>
            </div>

            <div class="register-link">
                <a href="forgot-password">¿Olvidaste tu contraseña?</a>
            </div>
        </div>
        <script>
            const passwordInput = document.getElementById('contraseña');
            const mostrarCheckbox = document.getElementById('mostrarContrasena');
            mostrarCheckbox.addEventListener('change', function () {
                passwordInput.type = this.checked ? 'text' : 'password';
            });
        </script>
        </body>

    </html>