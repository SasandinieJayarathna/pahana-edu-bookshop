<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Items - Pahana Edu Billing System</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                        rel="stylesheet">
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
                                    <h2><i class="fas fa-box"></i> Items Management</h2>
                                    <a href="<c:url value='/items?action=new'/>" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> New Item
                                    </a>
                                </div>

                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <c:if test="${param.success == 'created'}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        Item created successfully!
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <c:if test="${param.success == 'updated'}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        Item updated successfully!
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <c:if test="${param.success == 'deleted'}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        Item deleted successfully!
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <!-- Items List -->
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="mb-0">Items</h5>
                                    </div>
                                    <div class="card-body">
                                        <c:choose>
                                            <c:when test="${not empty items}">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-hover">
                                                        <thead class="table-dark">
                                                            <tr>
                                                                <th>Code</th>
                                                                <th>Name</th>
                                                                <th>Description</th>
                                                                <th>Price</th>
                                                                <th>Unit</th>
                                                                <th>Stock</th>
                                                                <th>Status</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="item" items="${items}">
                                                                <tr>
                                                                    <td><strong>${item.code}</strong></td>
                                                                    <td>${item.name}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${fn:length(item.description) > 50}">
                                                                                ${fn:substring(item.description, 0,
                                                                                50)}...
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                ${item.description}
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>$
                                                                        <fmt:formatNumber value="${item.price}"
                                                                            pattern="#,##0.00" />
                                                                    </td>
                                                                    <td>${item.unit}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${item.stockQuantity <= 10}">
                                                                                <span
                                                                                    class="badge bg-warning">${item.stockQuantity}</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                ${item.stockQuantity}
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${item.active}">
                                                                                <span
                                                                                    class="badge bg-success">Active</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span
                                                                                    class="badge bg-secondary">Inactive</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <div class="btn-group" role="group">
                                                                            <a href="<c:url value='/items?action=view&id=${item.id}'/>"
                                                                                class="btn btn-sm btn-outline-info"
                                                                                title="View">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="<c:url value='/items?action=edit&id=${item.id}'/>"
                                                                                class="btn btn-sm btn-outline-primary"
                                                                                title="Edit">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <form method="post"
                                                                                action="<c:url value='/items'/>"
                                                                                class="d-inline">
                                                                                <input type="hidden" name="action"
                                                                                    value="delete">
                                                                                <input type="hidden" name="id"
                                                                                    value="${item.id}">
                                                                                <button type="submit"
                                                                                    class="btn btn-sm btn-outline-danger"
                                                                                    title="Delete"
                                                                                    onclick="return confirm('Are you sure you want to delete this item?')">
                                                                                    <i class="fas fa-trash"></i>
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center py-5">
                                                    <i class="fas fa-box fa-3x text-muted mb-3"></i>
                                                    <h5 class="text-muted">No items found</h5>
                                                    <p class="text-muted">Start by creating your first item.</p>
                                                    <a href="<c:url value='/items?action=new'/>"
                                                        class="btn btn-primary">
                                                        <i class="fas fa-plus"></i> Create First Item
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>