package com.pahanaedu.controller;

import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.InvoiceService;
import com.pahanaedu.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import com.pahanaedu.model.Invoice;

/**
 * Dashboard servlet showing key business statistics
 */
@WebServlet(name = "dashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {

    private CustomerService customerService;
    private InvoiceService invoiceService;
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
        invoiceService = new InvoiceService();
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Calculate dashboard statistics
            int totalCustomers = customerService.findAll().size();
            int totalInvoices = invoiceService.findAll().size();
            int totalItems = itemService.findAllActive().size();

            // Calculate total revenue from all invoices
            BigDecimal totalRevenue = invoiceService.findAll().stream()
                    .map(invoice -> invoice.getTotalAmount())
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            // Calculate pending invoices count
            long pendingInvoices = invoiceService.findAll().stream()
                    .filter(invoice -> "PENDING".equals(invoice.getPaymentStatus().toString()))
                    .count();

            // Calculate paid invoices count
            long paidInvoices = invoiceService.findAll().stream()
                    .filter(invoice -> "PAID".equals(invoice.getPaymentStatus().toString()))
                    .count();

            // Calculate monthly revenue (current month)
            BigDecimal monthlyRevenue = invoiceService.findAll().stream()
                    .filter(invoice -> {
                        // Filter invoices from current month
                        LocalDate invoiceDate = invoice.getInvoiceDate();
                        LocalDate now = LocalDate.now();
                        return invoiceDate.getMonth() == now.getMonth() &&
                                invoiceDate.getYear() == now.getYear();
                    })
                    .map(invoice -> invoice.getTotalAmount())
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            // Get recent invoices (last 5)
            List<Invoice> recentInvoices = invoiceService.findAll().stream()
                    .sorted((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()))
                    .limit(5)
                    .collect(java.util.stream.Collectors.toList());

            // Set attributes for JSP
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalInvoices", totalInvoices);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("pendingInvoices", pendingInvoices);
            request.setAttribute("paidInvoices", paidInvoices);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("recentInvoices", recentInvoices);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
