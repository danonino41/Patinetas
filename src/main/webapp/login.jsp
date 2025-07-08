<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="login-container">
            <h2>Iniciar sesión</h2>
            <% String error=request.getParameter("error");  
             if (error !=null) { %>
                <p class="error-message">
                    <%= error%>
                </p>
                <% }%>
                    <form action="LoginServlet" method="post">
                        <label for="correo">Correo electrónico:</label>
                        <input type="email" id="correo" name="correo" required
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
                        <p>No tienes cuenta? <a href="registro.jsp">Registrarse</a></p>
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