<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Invoice ${invoice.invoiceNumber} - Print</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                body {
                    font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
                    font-size: 14px;
                    line-height: 1.4;
                    color: #333;
                }

                @media print {
                    body {
                        font-size: 12px;
                        margin: 0;
                        padding: 20px;
                    }

                    .container {
                        max-width: none !important;
                        margin: 0 !important;
                        padding: 0 !important;
                    }

                    .no-print {
                        display: none !important;
                    }

                    .page-break {
                        page-break-before: always;
                    }

                    .table {
                        font-size: 11px;
                    }

                    .company-header {
                        margin-bottom: 40px;
                    }

                    .invoice-details {
                        margin-bottom: 30px;
                    }
                }

                @media screen {
                    .container {
                        max-width: 900px;
                        margin: 20px auto;
                        padding: 30px;
                        background: white;
                        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                        border-radius: 8px;
                    }

                    body {
                        background-color: #f8f9fa;
                    }
                }

                .company-header {
                    text-align: center;
                    margin-bottom: 40px;
                    padding-bottom: 20px;
                    border-bottom: 3px solid #0d6efd;
                }

                .company-header h1 {
                    color: #0d6efd;
                    font-size: 2.5rem;
                    font-weight: bold;
                    margin-bottom: 5px;
                }

                .company-header p {
                    color: #6c757d;
                    font-size: 1.1rem;
                    margin-bottom: 0;
                }

                .invoice-title {
                    font-size: 2rem;
                    font-weight: bold;
                    color: #dc3545;
                    text-align: center;
                    margin: 30px 0;
                    text-transform: uppercase;
                    letter-spacing: 2px;
                }

                .invoice-details {
                    margin-bottom: 40px;
                }

                .invoice-details .row {
                    margin-bottom: 15px;
                }

                .invoice-number {
                    font-size: 1.3rem;
                    font-weight: bold;
                    color: #0d6efd;
                }

                .customer-info {
                    background-color: #f8f9fa;
                    padding: 20px;
                    border-radius: 8px;
                    margin-bottom: 30px;
                }

                .customer-info h5 {
                    color: #495057;
                    border-bottom: 2px solid #dee2e6;
                    padding-bottom: 10px;
                    margin-bottom: 15px;
                }

                .table {
                    border: 2px solid #dee2e6;
                }

                .table thead th {
                    background-color: #343a40;
                    color: white;
                    font-weight: bold;
                    text-align: center;
                    vertical-align: middle;
                    border: 1px solid #454d55;
                }

                .table tbody td {
                    vertical-align: middle;
                    border: 1px solid #dee2e6;
                }

                .table tfoot td {
                    font-weight: bold;
                    background-color: #f8f9fa;
                    border: 1px solid #dee2e6;
                }

                .total-row {
                    background-color: #e9ecef !important;
                    font-size: 1.1rem;
                }

                .footer-info {
                    margin-top: 50px;
                    padding-top: 20px;
                    border-top: 2px solid #dee2e6;
                    text-align: center;
                    color: #6c757d;
                }

                .print-controls {
                    position: fixed;
                    top: 20px;
                    right: 20px;
                    z-index: 1000;
                }

                .btn-print {
                    background-color: #28a745;
                    border-color: #28a745;
                }

                .btn-print:hover {
                    background-color: #218838;
                    border-color: #1e7e34;
                }
            </style>
        </head>

        <body>
            <!-- Print Controls (visible only on screen) -->
            <div class="print-controls no-print">
                <div class="btn-group-vertical">
                    <button onclick="window.print()" class="btn btn-print text-white mb-2">
                        <i class="fas fa-print"></i> Print
                    </button>
                    <a href="<c:url value='/invoices?action=view&id=${invoice.id}'/>" class="btn btn-secondary mb-2">
                        <i class="fas fa-eye"></i> View
                    </a>
                    <a href="<c:url value='/invoices?action=list'/>" class="btn btn-outline-secondary">
                        <i class="fas fa-list"></i> Back
                    </a>
                </div>
            </div>

            <div class="container">
                <!-- Company Header -->
                <div class="company-header">
                    <h1>Pahana Edu Billing System</h1>
                    <p>Educational Services & Billing Solutions</p>
                    <p>Phone: (555) 123-4567 | Email: info@pahanaedu.com</p>
                    <p>Address: 123 Education Street, Learning City, LC 12345</p>
                </div>

                <!-- Invoice Title -->
                <div class="invoice-title">INVOICE</div>

                <c:if test="${not empty invoice}">
                    <!-- Invoice Details -->
                    <div class="invoice-details">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Invoice #:</strong></div>
                                    <div class="col-8"><span class="invoice-number">${invoice.invoiceNumber}</span>
                                    </div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Invoice Date:</strong></div>
                                    <div class="col-8">${invoice.invoiceDate}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Due Date:</strong></div>
                                    <div class="col-8">${invoice.dueDate}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4"><strong>Payment Status:</strong></div>
                                    <div class="col-8">
                                        <strong class="text-info">${invoice.paymentStatus}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="customer-info">
                                    <h5><i class="fas fa-user"></i> Bill To:</h5>
                                    <div><strong>${invoice.customer.name}</strong></div>
                                    <c:if test="${not empty invoice.customer.email}">
                                        <div>Email: ${invoice.customer.email}</div>
                                    </c:if>
                                    <c:if test="${not empty invoice.customer.phone}">
                                        <div>Phone: ${invoice.customer.phone}</div>
                                    </c:if>
                                    <c:if test="${not empty invoice.customer.address}">
                                        <div>Address: ${invoice.customer.address}</div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Invoice Items Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th style="width: 40%">Item Description</th>
                                    <th style="width: 12%">Quantity</th>
                                    <th style="width: 16%">Unit Price</th>
                                    <th style="width: 16%">Discount</th>
                                    <th style="width: 16%">Line Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${invoiceItems}">
                                    <tr>
                                        <td>
                                            <strong>${item.item.name}</strong>
                                            <c:if test="${not empty item.item.description}">
                                                <br><small class="text-muted">${item.item.description}</small>
                                            </c:if>
                                        </td>
                                        <td class="text-center">${item.quantity}</td>
                                        <td class="text-end">$
                                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" />
                                        </td>
                                        <td class="text-end">$
                                            <fmt:formatNumber value="${item.discount}" pattern="#,##0.00" />
                                        </td>
                                        <td class="text-end">$
                                            <fmt:formatNumber value="${item.lineTotal}" pattern="#,##0.00" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="text-end"><strong>Subtotal:</strong></td>
                                    <td class="text-end"><strong>$
                                            <fmt:formatNumber value="${invoice.subtotal}" pattern="#,##0.00" />
                                        </strong></td>
                                </tr>
                                <c:if test="${invoice.taxAmount > 0}">
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Tax:</strong></td>
                                        <td class="text-end"><strong>$
                                                <fmt:formatNumber value="${invoice.taxAmount}" pattern="#,##0.00" />
                                            </strong></td>
                                    </tr>
                                </c:if>
                                <c:if test="${invoice.discountAmount > 0}">
                                    <tr>
                                        <td colspan="4" class="text-end"><strong>Total Discount:</strong></td>
                                        <td class="text-end"><strong>-$
                                                <fmt:formatNumber value="${invoice.discountAmount}"
                                                    pattern="#,##0.00" />
                                            </strong></td>
                                    </tr>
                                </c:if>
                                <tr class="total-row">
                                    <td colspan="4" class="text-end"><strong>TOTAL AMOUNT:</strong></td>
                                    <td class="text-end"><strong>$
                                            <fmt:formatNumber value="${invoice.totalAmount}" pattern="#,##0.00" />
                                        </strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!-- Additional Information -->
                    <c:if test="${not empty invoice.notes}">
                        <div class="row mt-4">
                            <div class="col-12">
                                <h5><i class="fas fa-sticky-note"></i> Notes:</h5>
                                <div class="border p-3 bg-light rounded">
                                    ${invoice.notes}
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Payment Terms and Footer -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <h6><strong>Payment Terms:</strong></h6>
                            <p>${invoice.paymentTerms}</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <h6><strong>Payment Methods:</strong></h6>
                            <p>Cash, Check, Bank Transfer, Credit Card</p>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="footer-info">
                        <p><strong>Thank you for your business!</strong></p>
                        <p>For questions about this invoice, please contact us at (555) 123-4567</p>
                        <p><small>Generated on:
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss" />
                            </small></p>
                    </div>
                </c:if>

                <c:if test="${empty invoice}">
                    <div class="alert alert-warning text-center">
                        <h4><i class="fas fa-exclamation-triangle"></i> Invoice not found</h4>
                        <p>The requested invoice could not be found or loaded.</p>
                        <a href="<c:url value='/invoices?action=list'/>" class="btn btn-primary">
                            <i class="fas fa-list"></i> Back to Invoice List
                        </a>
                    </div>
                </c:if>
            </div>

            <script>
                // Auto-focus on print when page loads (optional)
                window.addEventListener('load', function () {
                    // Uncomment the line below if you want the print dialog to open automatically
                    // window.print();
                });

                // Keyboard shortcut for printing
                document.addEventListener('keydown', function (e) {
                    if (e.ctrlKey && e.key === 'p') {
                        e.preventDefault();
                        window.print();
                    }
                });
            </script>
        </body>

        </html>