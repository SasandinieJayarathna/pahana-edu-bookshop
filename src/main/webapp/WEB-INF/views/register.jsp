<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Register - Pahana Edu Billing System</title>
            <link href="<link href=" https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                rel="stylesheet">" rel="stylesheet">
            <style>
                body {
                    background-color: #f8f9fa;
                }

                .register-container {
                    max-width: 450px;
                    margin: 50px auto;
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
                <div class="register-container">
                    <div class="logo">
                        <h2>Pahana Edu</h2>
                        <p class="text-muted">Create New Account</p>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form method="post" action="<c:url value='/register'/>">
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="${name}" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>

                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Register</button>
                        </div>
                    </form>

                    <div class="text-center mt-3">
                        <p>Already have an account? <a href="<c:url value='/login'/>">Login here</a></p>
                    </div>
                </div>
            </div>

            <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
        </body>

        </html>