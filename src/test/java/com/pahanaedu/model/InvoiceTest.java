package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceTest {

    @Test
    public void testDefaultConstructorDefaults() {
        Invoice inv = new Invoice();
        assertEquals(BigDecimal.ZERO, inv.getSubtotal());
        assertEquals(Invoice.PaymentStatus.PENDING, inv.getPaymentStatus());
        assertEquals("Net 30", inv.getPaymentTerms());
    }

    @Test
    public void testInvoiceConstructorFields() {
        LocalDate today = LocalDate.now();
        LocalDate due = today.plusDays(30);
        Invoice inv = new Invoice("INV-001", 5, today, due);
        assertEquals("INV-001", inv.getInvoiceNumber());
        assertEquals(5, inv.getCustomerId());
        assertEquals(today, inv.getInvoiceDate());
        assertEquals(due, inv.getDueDate());
    }
}
