<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Recuperar Contraseña</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">Recuperar Contraseña</h3>
                        
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
                        
                        <form action="forgot-password" method="POST">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email registrado</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Enviar enlace de recuperación</button>
                        </form>
                        <div class="mt-3 text-center">
                            <a href="login">Volver al inicio de sesión</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>