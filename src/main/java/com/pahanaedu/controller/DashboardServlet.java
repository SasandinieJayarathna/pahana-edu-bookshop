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

            // Set attributes for JSP
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalInvoices", totalInvoices);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("totalRevenue", totalRevenue);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
