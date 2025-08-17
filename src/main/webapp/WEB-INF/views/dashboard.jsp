<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - Pahana Edu Billing System</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                    <div class="container">
                        <a class="navbar-brand" href="<c:url value='/dashboard'/>">
                            <i class="fas fa-bolt"></i> Pahana Edu Billing
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link active" href="<c:url value='/dashboard'/>">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/customers?action=list'/>">
                                        <i class="fas fa-users"></i> Customers
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/items?action=list'/>">
                                        <i class="fas fa-box"></i> Items
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/invoices?action=list'/>">
                                        <i class="fas fa-file-invoice"></i> Invoices
                                    </a>
                                </li>
                            </ul>
                            <div class="navbar-nav">
                                <span class="navbar-text me-3">
                                    <i class="fas fa-user"></i> Welcome, ${sessionScope.userName}
                                </span>
                                <a class="nav-link" href="<c:url value='/logout'/>">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <div class="row">
                        <div class="col-12">
                            <h2 class="mb-4">
                                <i class="fas fa-tachometer-alt"></i> Dashboard Overview
                            </h2>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Statistics Cards -->
                            <div class="row mb-4">
                                <div class="col-md-3">
                                    <div class="card text-white bg-primary">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h4 class="card-title">${totalCustomers}</h4>
                                                    <p class="card-text">Total Customers</p>
                                                </div>
                                                <div class="align-self-center">
                                                    <i class="fas fa-users fa-2x opacity-75"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <a href="<c:url value='/customers?action=list'/>"
                                                class="text-white text-decoration-none">
                                                View All <i class="fas fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card text-white bg-success">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h4 class="card-title">${totalInvoices}</h4>
                                                    <p class="card-text">Total Invoices</p>
                                                </div>
                                                <div class="align-self-center">
                                                    <i class="fas fa-file-invoice fa-2x opacity-75"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <a href="<c:url value='/invoices?action=list'/>"
                                                class="text-white text-decoration-none">
                                                View All <i class="fas fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card text-white bg-info">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h4 class="card-title">${totalItems}</h4>
                                                    <p class="card-text">Active Items</p>
                                                </div>
                                                <div class="align-self-center">
                                                    <i class="fas fa-box fa-2x opacity-75"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <a href="<c:url value='/items?action=list'/>"
                                                class="text-white text-decoration-none">
                                                View All <i class="fas fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card text-white bg-warning">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h4 class="card-title">$
                                                        <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />
                                                    </h4>
                                                    <p class="card-text">Total Revenue</p>
                                                </div>
                                                <div class="align-self-center">
                                                    <i class="fas fa-dollar-sign fa-2x opacity-75"></i>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <span class="text-white">
                                                From all invoices
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="mb-0">
                                                <i class="fas fa-plus-circle"></i> Quick Actions
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-grid gap-2">
                                                <a href="<c:url value='/customers?action=new'/>"
                                                    class="btn btn-outline-primary">
                                                    <i class="fas fa-user-plus"></i> Add New Customer
                                                </a>
                                                <a href="<c:url value='/items?action=new'/>"
                                                    class="btn btn-outline-success">
                                                    <i class="fas fa-box"></i> Add New Item
                                                </a>
                                                <a href="<c:url value='/invoices?action=new'/>"
                                                    class="btn btn-outline-warning">
                                                    <i class="fas fa-file-invoice"></i> Create New Invoice
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5 class="mb-0">
                                                <i class="fas fa-info-circle"></i> System Information
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <p><strong>Application:</strong> Pahana Edu Billing System</p>
                                            <p><strong>Technology Stack:</strong> Jakarta EE 10 + Pure JDBC</p>
                                            <p><strong>Database:</strong> MySQL 8+</p>
                                            <p><strong>Version:</strong> 1.0.0</p>
                                            <p class="text-muted mb-0">
                                                <small>Built with Jakarta Servlets, JSP, JSTL, and MySQL</small>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
            </body>

            </html>