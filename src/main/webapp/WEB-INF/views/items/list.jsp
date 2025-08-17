<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Items</title>
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
                            font-weight: 600
                        }

                        .card-modern {
                            border: 0;
                            border-radius: 12px;
                            box-shadow: 0 6px 18px rgba(45, 63, 84, 0.06);
                        }

                        .table-modern thead {
                            background: #eef2ff
                        }
                    </style>
                </head>

                <body>
                    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                        <div class="container-fluid px-4">
                            <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                                <span class="me-2"><i class="fas fa-box text-primary"></i></span>
                                <span>Items</span>
                            </a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link" href="<c:url value='/dashboard'/>">Overview</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="<c:url value='/customers?action=list'/>">Customers</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" href="<c:url value='/items?action=list'/>">Items</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="<c:url value='/invoices?action=list'/>">Invoices</a>
                                    </li>
                                </ul>

                                <div class="d-flex align-items-center">
                                    <div class="me-3 text-muted small">Welcome,
                                        <strong>${sessionScope.userName}</strong>
                                    </div>
                                    <a class="btn btn-outline-secondary btn-sm"
                                        href="<c:url value='/logout'/>">Logout</a>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <div class="container-fluid px-4 mt-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h1 class="h5 mb-0">Items Management</h1>
                                <p class="small text-muted mb-0">Create and manage inventory items.</p>
                            </div>
                            <div>
                                <a href="<c:url value='/items?action=new'/>" class="btn btn-primary btn-sm"><i
                                        class="fas fa-plus me-1"></i> New Item</a>
                            </div>
                        </div>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">${errorMessage}</div>
                        </c:if>

                        <c:if test="${param.success == 'created'}">
                            <div class="alert alert-success" role="alert">Item created successfully!</div>
                        </c:if>
                        <c:if test="${param.success == 'updated'}">
                            <div class="alert alert-success" role="alert">Item updated successfully!</div>
                        </c:if>
                        <c:if test="${param.success == 'deleted'}">
                            <div class="alert alert-success" role="alert">Item deleted successfully!</div>
                        </c:if>

                        <div class="card card-modern">
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty items}">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle">
                                                <thead class="table-modern">
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
                                                                    <c:when test="${fn:length(item.description) > 50}">
                                                                        ${fn:substring(item.description, 0, 50)}...
                                                                    </c:when>
                                                                    <c:otherwise>${item.description}</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>Rs.
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
                                                                    <c:otherwise>${item.stockQuantity}</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${item.active}">
                                                                        <span class="badge bg-success">Active</span>
                                                                    </c:when>
                                                                    <c:otherwise><span
                                                                            class="badge bg-secondary">Inactive</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <div class="btn-group" role="group">
                                                                    <a href="<c:url value='/items?action=view&id=${item.id}'/>"
                                                                        class="btn btn-sm btn-outline-info"
                                                                        title="View"><i class="fas fa-eye"></i></a>
                                                                    <a href="<c:url value='/items?action=edit&id=${item.id}'/>"
                                                                        class="btn btn-sm btn-outline-primary"
                                                                        title="Edit"><i class="fas fa-edit"></i></a>
                                                                    <form method="post" action="<c:url value='/items'/>"
                                                                        class="d-inline">
                                                                        <input type="hidden" name="action"
                                                                            value="delete">
                                                                        <input type="hidden" name="id"
                                                                            value="${item.id}">
                                                                        <button type="submit"
                                                                            class="btn btn-sm btn-outline-danger"
                                                                            title="Delete"
                                                                            onclick="return confirm('Are you sure you want to delete this item?')"><i
                                                                                class="fas fa-trash"></i></button>
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
                                            <a href="<c:url value='/items?action=new'/>" class="btn btn-primary"><i
                                                    class="fas fa-plus"></i> Create First Item</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>