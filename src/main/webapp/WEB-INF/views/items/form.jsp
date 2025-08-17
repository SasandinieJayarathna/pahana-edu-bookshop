<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <c:choose>
                        <c:when test="${isEdit}">Edit Item</c:when>
                        <c:otherwise>New Item</c:otherwise>
                    </c:choose> - Pahana Edu Billing System
                </title>
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
                                <h2>
                                    <i class="fas fa-box"></i>
                                    <c:choose>
                                        <c:when test="${isEdit}">Edit Item</c:when>
                                        <c:otherwise>New Item</c:otherwise>
                                    </c:choose>
                                </h2>
                                <a href="<c:url value='/items?action=list'/>" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back to Items
                                </a>
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Item Form -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">Item Information</h5>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="<c:url value='/items'/>">
                                        <input type="hidden" name="action"
                                            value="<c:choose><c:when test='${isEdit}'>update</c:when><c:otherwise>save</c:otherwise></c:choose>">
                                        <c:if test="${isEdit}">
                                            <input type="hidden" name="itemId" value="${item.id}">
                                        </c:if>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="name" class="form-label">Item Name <span
                                                            class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="name" name="name"
                                                        value="${item.name}" required maxlength="255">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="code" class="form-label">Item Code <span
                                                            class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="code" name="code"
                                                        value="${item.code}" required maxlength="100">
                                                    <div class="form-text">Unique identifier for the item</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="price" class="form-label">Price <span
                                                            class="text-danger">*</span></label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">$</span>
                                                        <input type="number" step="0.01" class="form-control" id="price"
                                                            name="price" value="${item.price}" required min="0">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="unit" class="form-label">Unit</label>
                                                    <select class="form-select" id="unit" name="unit">
                                                        <option value="UNIT" <c:if
                                                            test="${item.unit == 'UNIT' or empty item.unit}">selected
                                                            </c:if>>Unit</option>
                                                        <option value="PIECE" <c:if test="${item.unit == 'PIECE'}">
                                                            selected</c:if>>Piece</option>
                                                        <option value="BOX" <c:if test="${item.unit == 'BOX'}">selected
                                                            </c:if>>Box</option>
                                                        <option value="KG" <c:if test="${item.unit == 'KG'}">selected
                                                            </c:if>>Kilogram</option>
                                                        <option value="METER" <c:if test="${item.unit == 'METER'}">
                                                            selected</c:if>>Meter</option>
                                                        <option value="HOUR" <c:if test="${item.unit == 'HOUR'}">
                                                            selected</c:if>>Hour</option>
                                                        <option value="SERVICE" <c:if test="${item.unit == 'SERVICE'}">
                                                            selected</c:if>>Service</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label for="stockQuantity" class="form-label">Stock Quantity</label>
                                                    <input type="number" class="form-control" id="stockQuantity"
                                                        name="stockQuantity" value="${item.stockQuantity}" min="0">
                                                    <div class="form-text">Current inventory count</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <c:if test="${isEdit}">
                                                    <div class="mb-3">
                                                        <label class="form-label">Status</label>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="active"
                                                                name="active" <c:if test="${item.active}">checked
                                                </c:if>>
                                                <label class="form-check-label" for="active">
                                                    Active (available for use in invoices)
                                                </label>
                                            </div>
                                        </div>
                                        </c:if>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"
                                    placeholder="Detailed description of the item">${item.description}</textarea>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="<c:url value='/items?action=list'/>" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    <c:choose>
                                        <c:when test="${isEdit}">Update Item</c:when>
                                        <c:otherwise>Create Item</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
                </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Auto-generate item code based on name if creating new item
                    <c:if test="${not isEdit}">
                        document.getElementById('name').addEventListener('input', function() {
                const name = this.value;
                        const codeField = document.getElementById('code');

                        if (name && !codeField.value) {
                    // Generate simple code from name (first 3 letters + random number)
                    const prefix = name.replace(/[^a-zA-Z]/g, '').substring(0, 3).toUpperCase();
                        const suffix = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
                        codeField.value = prefix + suffix;
                }
            });
                    </c:if>
                </script>
            </body>

            </html>