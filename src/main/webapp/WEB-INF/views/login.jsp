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
                    <style>
                        body {
                            background-color: #f8f9fa;
                        }

                        .login-container {
                            max-width: 400px;
                            margin: 100px auto;
                            padding: 30px;
                            background: white;
                            border-radius: 10px;
                            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                        }

                        .logo {
                            text-align: center;
                            margin-bottom: 30px;
                        }

                        .logo h2 {
                            color: #007bff;
                            font-weight: bold;
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <div class="login-container">
                            <div class="logo">
                                <h2>Pahana Edu</h2>
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
                                    <input type="email" class="form-control" id="email" name="email" value="${email}"
                                        required>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                            </form>

                            <div class="text-center mt-3">
                                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register
                                        here</a></p>
                            </div>

                            <div class="text-center mt-4">
                                <small class="text-muted">
                                    Demo credentials: admin@gmail.com / admin123
                                </small>
                            </div>
                        </div>
                    </div>

                    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>