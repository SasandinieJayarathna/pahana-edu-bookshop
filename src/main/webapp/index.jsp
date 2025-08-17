<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page session="true" %>
        <%@ page isELIgnored="false" %>
            <%@ taglib prefix="c" uri="jakarta.tags.core" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Home</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <style>
                        body {
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            min-height: 100vh;
                        }

                        .welcome-card {
                            background: rgba(255, 255, 255, 0.95);
                            border-radius: 15px;
                            backdrop-filter: blur(10px);
                        }
                    </style>
                </head>

                <body class="d-flex align-items-center">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-md-8 col-lg-6">
                                <div class="welcome-card p-5 text-center">
                                    <h1 class="display-4 text-primary mb-4">
                                        <i class="fas fa-bolt"></i> Welcome
                                    </h1>

                                    <p class="lead mb-4">
                                        Access your billing portal to manage customers, items, and invoices.
                                    </p>

                                    <div class="d-grid gap-2 col-md-8 mx-auto">
                                        <a href="<c:url value='/login'/>" class="btn btn-primary btn-lg">
                                            <i class="fas fa-sign-in-alt"></i> Login to System
                                        </a>
                                        <a href="<c:url value='/register'/>" class="btn btn-outline-secondary">
                                            <i class="fas fa-user-plus"></i> Create New Account
                                        </a>
                                    </div>

                                    <div class="mt-5 pt-4 border-top">
                                        <!-- Removed Technology Stack and Demo Login details -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
                </body>

                </html>