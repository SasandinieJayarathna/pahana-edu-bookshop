<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${isEdit ? 'Edit' : 'New'} Customer - Pahana Edu Billing System</title>
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
                                <h2>${isEdit ? 'Edit' : 'New'} Customer</h2>
                                <a href="<c:url value='/customers?action=list'/>" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back to List
                                </a>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">Customer Information</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="<c:url value='/customers'/>">
                                        <input type="hidden" name="action" value="${isEdit ? 'update' : 'save'}">
                                        <c:if test="${isEdit}">
                                            <input type="hidden" name="id" value="${customer.id}">
                                        </c:if>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="name" class="form-label">Customer Name *</label>
                                                    <input type="text" class="form-control" id="name" name="name"
                                                        value="${customer.name}" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="email" class="form-label">Email Address</label>
                                                    <input type="email" class="form-control" id="email" name="email"
                                                        value="${customer.email}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="phone" class="form-label">Phone Number</label>
                                                    <input type="text" class="form-control" id="phone" name="phone"
                                                        value="${customer.phone}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="telephoneNumber" class="form-label">Telephone
                                                        Number</label>
                                                    <input type="text" class="form-control" id="telephoneNumber"
                                                        name="telephoneNumber" value="${customer.telephoneNumber}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="accountNumber" class="form-label">Account Number</label>
                                                    <input type="text" class="form-control" id="accountNumber"
                                                        name="accountNumber" value="${customer.accountNumber}"
                                                        placeholder="Leave empty to auto-generate">
                                                    <div class="form-text">Leave empty to auto-generate account number
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="customerType" class="form-label">Customer Type *</label>
                                                    <select class="form-select" id="customerType" name="customerType"
                                                        required>
                                                        <option value="RESIDENTIAL"
                                                            ${customer.customerType=='RESIDENTIAL' ? 'selected' : '' }>
                                                            Residential
                                                        </option>
                                                        <option value="COMMERCIAL" ${customer.customerType=='COMMERCIAL'
                                                            ? 'selected' : '' }>
                                                            Commercial
                                                        </option>
                                                        <option value="INDUSTRIAL" ${customer.customerType=='INDUSTRIAL'
                                                            ? 'selected' : '' }>
                                                            Industrial
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="unitsConsumed" class="form-label">Units Consumed</label>
                                                    <input type="number" step="0.01" class="form-control"
                                                        id="unitsConsumed" name="unitsConsumed"
                                                        value="${customer.unitsConsumed}">
                                                    <div class="form-text">Total units consumed by the customer</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label for="address" class="form-label">Address</label>
                                            <textarea class="form-control" id="address" name="address"
                                                rows="3">${customer.address}</textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label for="notes" class="form-label">Notes</label>
                                            <textarea class="form-control" id="notes" name="notes"
                                                rows="3">${customer.notes}</textarea>
                                        </div>

                                        <div class="d-flex justify-content-end gap-2">
                                            <a href="<c:url value='/customers?action=list'/>"
                                                class="btn btn-secondary">Cancel</a>
                                            <button type="submit" class="btn btn-primary">
                                                ${isEdit ? 'Update' : 'Create'} Customer
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
            </body>

            </html>