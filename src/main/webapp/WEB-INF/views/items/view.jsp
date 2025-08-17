<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Item Details - Pahana Edu Billing System</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                    <div class="container">
                        <a class="navbar-brand" href="<c:url value='/dashboard'/>">Pahana Edu Billing</a>
                        <div class="navbar-nav ms-auto">
                            <span class="navbar-text me-3">Welcome, ${sessionScope.userName}</span>
                            <a class="nav-link" href="<c:url value='/logout'/>">Logout</a>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2><i class="fas fa-box"></i> Item Details</h2>
                                <div>
                                    <a href="<c:url value='/items?action=edit&id=${item.id}'/>"
                                        class="btn btn-primary me-2">
                                        <i class="fas fa-edit"></i> Edit Item
                                    </a>
                                    <a href="<c:url value='/items?action=list'/>" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to Items
                                    </a>
                                </div>
                            </div>

                            <c:if test="${not empty item}">
                                <!-- Item Information -->
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <h5 class="mb-0">Item Information</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td><strong>Item Code:</strong></td>
                                                        <td><span class="badge bg-primary fs-6">${item.code}</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Name:</strong></td>
                                                        <td>${item.name}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Unit:</strong></td>
                                                        <td>${item.unit}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Price:</strong></td>
                                                        <td><strong class="text-success">$
                                                                <fmt:formatNumber value="${item.price}"
                                                                    pattern="#,##0.00" />
                                                            </strong></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-md-6">
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td><strong>Stock Quantity:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${item.stockQuantity <= 10}">
                                                                    <span
                                                                        class="badge bg-warning fs-6">${item.stockQuantity}</span>
                                                                    <small class="text-muted">(Low Stock)</small>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-success fs-6">${item.stockQuantity}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Status:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${item.active}">
                                                                    <span class="badge bg-success fs-6">Active</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-secondary fs-6">Inactive</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Created:</strong></td>
                                                        <td>
                                                            <c:if test="${not empty item.createdAt}">
                                                                ${item.createdAt}
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Last Updated:</strong></td>
                                                        <td>
                                                            <c:if test="${not empty item.updatedAt}">
                                                                ${item.updatedAt}
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <c:if test="${not empty item.description}">
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <h6><strong>Description:</strong></h6>
                                                    <p class="text-muted">${item.description}</p>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="mb-0">Actions</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex gap-2">
                                            <a href="<c:url value='/items?action=edit&id=${item.id}'/>"
                                                class="btn btn-primary">
                                                <i class="fas fa-edit"></i> Edit Item
                                            </a>
                                            <form method="post" action="<c:url value='/items'/>" class="d-inline">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${item.id}">
                                                <button type="submit" class="btn btn-danger"
                                                    onclick="return confirm('Are you sure you want to delete this item? This action cannot be undone.')">
                                                    <i class="fas fa-trash"></i> Delete Item
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${empty item}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    Item not found.
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>