<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Customer Management - Pahana Edu Billing System</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                                <h2>Customer Management</h2>
                                <a href="<c:url value='/customers?action=new'/>" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> New Customer
                                </a>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Search Form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="<c:url value='/customers'/>" class="row g-3">
                                        <input type="hidden" name="action" value="search">
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" name="searchTerm"
                                                placeholder="Search customers by name..." value="${searchTerm}">
                                        </div>
                                        <div class="col-md-4">
                                            <button type="submit" class="btn btn-outline-primary me-2">Search</button>
                                            <a href="<c:url value='/customers?action=list'/>"
                                                class="btn btn-outline-secondary">Clear</a>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Customer List -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        Customers
                                        <c:if test="${not empty searchTerm}">
                                            - Search Results for "${searchTerm}"
                                        </c:if>
                                        <span class="badge bg-secondary">${customers.size()}</span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty customers}">
                                            <div class="text-center py-4">
                                                <p class="text-muted">No customers found.</p>
                                                <a href="<c:url value='/customers?action=new'/>"
                                                    class="btn btn-primary">
                                                    Create Your First Customer
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-striped table-hover">
                                                    <thead class="table-dark">
                                                        <tr>
                                                            <th>Account #</th>
                                                            <th>Name</th>
                                                            <th>Email</th>
                                                            <th>Phone</th>
                                                            <th>Type</th>
                                                            <th>Units Consumed</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="customer" items="${customers}">
                                                            <tr>
                                                                <td><strong>${customer.accountNumber}</strong></td>
                                                                <td>${customer.name}</td>
                                                                <td>${customer.email}</td>
                                                                <td>${customer.phone}</td>
                                                                <td>
                                                                    <span
                                                                        class="badge bg-info">${customer.customerType}</span>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatNumber value="${customer.unitsConsumed}"
                                                                        pattern="#,##0.00" />
                                                                </td>
                                                                <td>
                                                                    <div class="btn-group" role="group">
                                                                        <a href="<c:url value='/customers?action=view&id=${customer.id}'/>"
                                                                            class="btn btn-sm btn-outline-info"
                                                                            title="View">
                                                                            <i class="fas fa-eye"></i>
                                                                        </a>
                                                                        <a href="<c:url value='/customers?action=edit&id=${customer.id}'/>"
                                                                            class="btn btn-sm btn-outline-warning"
                                                                            title="Edit">
                                                                            <i class="fas fa-edit"></i>
                                                                        </a>
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-outline-danger"
                                                                            onclick="confirmDelete(${customer.id}, '${customer.name}')"
                                                                            title="Delete">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Confirm Delete</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to delete customer <strong id="customerName"></strong>?
                                This action cannot be undone.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <form id="deleteForm" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" id="customerId">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
                <script>
                    function confirmDelete(id, name) {
                        document.getElementById('customerId').value = id;
                        document.getElementById('customerName').textContent = name;
                        document.getElementById('deleteForm').action = '<c:url value="/customers"/>';
                        new bootstrap.Modal(document.getElementById('deleteModal')).show();
                    }
                </script>
            </body>

            </html>