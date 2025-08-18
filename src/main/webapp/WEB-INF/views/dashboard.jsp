<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                    rel="stylesheet">
                <style>
                    body {
                        font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
                        background: #f5f7fb;
                    }

                    .navbar-brand {
                        font-weight: 600;
                        letter-spacing: 0.2px
                    }

                    .card-modern {
                        border: 0;
                        border-radius: 12px;
                        box-shadow: 0 6px 18px rgba(45, 63, 84, 0.08);
                    }

                    .stat-icon {
                        width: 56px;
                        height: 56px;
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #fff;
                    }

                    .stat-value {
                        font-size: 1.6rem;
                        font-weight: 700
                    }

                    .stat-label {
                        color: #6b7280;
                        font-size: 0.9rem
                    }

                    .quick-btn {
                        border-radius: 10px;
                        padding: 0.6rem 1rem;
                    }
                </style>
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
                    <div class="container-fluid px-4">
                        <a class="navbar-brand d-flex align-items-center" href="<c:url value='/dashboard'/>">
                            <span class="me-2"><i class="fas fa-bolt text-primary"></i></span>
                            <span>Dashboard</span>
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link active" href="<c:url value='/dashboard'/>">Overview</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/customers?action=list'/>">Customers</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/items?action=list'/>">Items</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/invoices?action=list'/>">Invoices</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="<c:url value='/help.jsp'/>">Help</a>
                                </li>
                            </ul>

                            <div class="d-flex align-items-center">
                                <div class="me-3 text-muted small">Welcome, <strong>${sessionScope.userName}</strong>
                                </div>
                                <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/logout'/>">Logout</a>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="container-fluid px-4 mt-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h1 class="h4 mb-0">Dashboard Overview</h1>
                            <p class="text-muted small mb-0">Quick insights and shortcuts to manage the system.</p>
                        </div>
                        <div>
                            <a href="<c:url value='/invoices?action=new'/>" class="btn btn-primary btn-sm me-2">New
                                Invoice</a>
                            <a href="<c:url value='/customers?action=new'/>" class="btn btn-outline-primary btn-sm">New
                                Customer</a>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">${errorMessage}</div>
                    </c:if>

                    <div class="row g-3 mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-primary">
                                        <i class="fas fa-users fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">${totalCustomers}</div>
                                        <div class="stat-label">Total Customers</div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <a href="<c:url value='/customers?action=list'/>"
                                        class="text-decoration-none small">View all customers &rarr;</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-success">
                                        <i class="fas fa-file-invoice fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">${totalInvoices}</div>
                                        <div class="stat-label">Total Invoices</div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <a href="<c:url value='/invoices?action=list'/>"
                                        class="text-decoration-none small">View all invoices &rarr;</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-info">
                                        <i class="fas fa-box fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">${totalItems}</div>
                                        <div class="stat-label">Active Items</div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <a href="<c:url value='/items?action=list'/>"
                                        class="text-decoration-none small">View items &rarr;</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-warning">
                                        <i class="fas fa-indian-rupee-sign fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">Rs.
                                            <fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />
                                        </div>
                                        <div class="stat-label">Total Revenue</div>
                                    </div>
                                </div>
                                <div class="mt-3 small text-muted">From all invoices</div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional statistics row -->
                    <div class="row g-3 mb-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-danger">
                                        <i class="fas fa-clock fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">${pendingInvoices}</div>
                                        <div class="stat-label">Pending Invoices</div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <a href="<c:url value='/invoices?action=list&status=PENDING'/>"
                                        class="text-decoration-none small">View pending &rarr;</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-success">
                                        <i class="fas fa-check-circle fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">${paidInvoices}</div>
                                        <div class="stat-label">Paid Invoices</div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <a href="<c:url value='/invoices?action=list&status=PAID'/>"
                                        class="text-decoration-none small">View paid &rarr;</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-primary">
                                        <i class="fas fa-calendar-alt fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">Rs.
                                            <fmt:formatNumber value="${monthlyRevenue}" pattern="#,##0.00" />
                                        </div>
                                        <div class="stat-label">This Month</div>
                                    </div>
                                </div>
                                <div class="mt-3 small text-muted">Current month revenue</div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="card card-modern p-3 h-100">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="stat-icon bg-info">
                                        <i class="fas fa-percentage fa-lg"></i>
                                    </div>
                                    <div>
                                        <div class="stat-value">
                                            <c:choose>
                                                <c:when test="${totalInvoices > 0}">
                                                    <fmt:formatNumber value="${(paidInvoices / totalInvoices) * 100}"
                                                        pattern="##.#" />%
                                                </c:when>
                                                <c:otherwise>0%</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="stat-label">Payment Rate</div>
                                    </div>
                                </div>
                                <div class="mt-3 small text-muted">Invoice payment success rate</div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-lg-8">
                            <div class="card card-modern p-3">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="mb-0">Recent Invoices</h5>
                                    <a href="<c:url value='/invoices?action=list'/>"
                                        class="btn btn-sm btn-outline-primary">View All</a>
                                </div>
                                <c:choose>
                                    <c:when test="${empty recentInvoices}">
                                        <div class="text-center py-4 text-muted">
                                            <i class="fas fa-file-invoice fa-3x mb-3"></i>
                                            <p>No invoices found. <a href="<c:url value='/invoices?action=new'/>">Create
                                                    your first invoice</a></p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>Invoice #</th>
                                                        <th>Customer</th>
                                                        <th>Date</th>
                                                        <th>Amount</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="invoice" items="${recentInvoices}">
                                                        <tr>
                                                            <td>
                                                                <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>"
                                                                    class="text-decoration-none fw-bold">${invoice.invoiceNumber}</a>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty invoice.customer}">
                                                                        ${invoice.customer.name}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Customer ID: ${invoice.customerId}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                ${invoice.invoiceDate}
                                                            </td>
                                                            <td>
                                                                <span class="fw-bold">Rs.
                                                                    <fmt:formatNumber value="${invoice.totalAmount}"
                                                                        pattern="#,##0.00" />
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${invoice.paymentStatus == 'PAID'}">
                                                                        <span class="badge bg-success">Paid</span>
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${invoice.paymentStatus == 'PENDING'}">
                                                                        <span class="badge bg-warning">Pending</span>
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${invoice.paymentStatus == 'OVERDUE'}">
                                                                        <span class="badge bg-danger">Overdue</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="badge bg-secondary">${invoice.paymentStatus}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
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

                        <div class="col-lg-4">
                            <div class="card card-modern p-3 mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="mb-0">Quick Actions</h5>
                                </div>
                                <div class="d-grid gap-2">
                                    <a href="<c:url value='/customers?action=new'/>"
                                        class="btn btn-outline-primary quick-btn">
                                        <i class="fas fa-user-plus me-2"></i> Add Customer
                                    </a>
                                    <a href="<c:url value='/items?action=new'/>"
                                        class="btn btn-outline-success quick-btn">
                                        <i class="fas fa-box me-2"></i> Add Item
                                    </a>
                                    <a href="<c:url value='/invoices?action=new'/>"
                                        class="btn btn-outline-warning quick-btn">
                                        <i class="fas fa-file-invoice me-2"></i> Create Invoice
                                    </a>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
            </body>

            </html>