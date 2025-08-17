<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page session="true" %>
        <%@ page isELIgnored="false" %>
            <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Login - Pahana Edu Billing System</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                        rel="stylesheet">
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                        rel="stylesheet">
                    <style>
                        body {
                            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                            background: #f5f7fb;
                        }

                        .navbar-brand {
                            font-weight: 600;
                            letter-spacing: 0.2px;
                        }

                        .card-modern {
                            border: 0;
                            border-radius: 12px;
                            box-shadow: 0 6px 18px rgba(45, 63, 84, 0.06);
                        }

                        .login-card {
                            max-width: 480px;
                            margin: 40px auto;
                        }
                    </style>
                </head>

                <body>
                    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                        <div class="container-fluid px-4">
                            <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                                <span class="me-2"><i class="fas fa-bolt text-primary"></i></span>
                                <span>Pahana Edu</span>
                            </a>
                        </div>
                    </nav>

                    <div class="container-fluid px-4 mt-4">
                        <div class="login-card card card-modern">
                            <div class="card-body p-4">
                                <div class="text-center mb-3">
                                    <h2 class="mb-0">Pahana Edu</h2>
                                    <p class="text-muted">Billing System</p>
                                </div>

                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <form method="post" action="${pageContext.request.contextPath}/login">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            value="${email}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="password" name="password"
                                            required>
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary">Login</button>
                                    </div>
                                </form>

                                <div class="text-center mt-3">
                                    <p>Don't have an account? <a
                                            href="${pageContext.request.contextPath}/register">Register here</a></p>
                                </div>

                                <div class="text-center mt-3">
                                    <small class="text-muted">Demo credentials: admin@gmail.com / admin123</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
                </body>

                </html>