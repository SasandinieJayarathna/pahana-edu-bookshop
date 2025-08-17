package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceItemTest {

    @Test
    public void testCalculateLineTotal() {
        InvoiceItem ii = new InvoiceItem(1, 2, new BigDecimal("3"), new BigDecimal("10.00"));
        // default discount 0
        ii.calculateLineTotal();
        assertEquals(new BigDecimal("30.00"), ii.getLineTotal(),
                "Line total should be quantity * unitPrice when no discount");
    }

    @Test
    public void testSettersUpdateLineTotal() {
        InvoiceItem ii = new InvoiceItem();
        ii.setQuantity(new BigDecimal("2"));
        ii.setUnitPrice(new BigDecimal("5.50"));
        ii.setDiscount(new BigDecimal("1.00"));

        // lineTotal should be recalculated
        assertEquals(new BigDecimal("10.00"), ii.getLineTotal(), "Line total should be quantity*unitPrice - discount");
    }
}
