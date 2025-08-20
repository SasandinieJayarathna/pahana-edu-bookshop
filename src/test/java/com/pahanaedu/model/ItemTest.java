package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class ItemTest {

    @Test
    public void testConstructorDefaults() {
        Item it = new Item("Pen", "PEN01", "Blue ink pen", new BigDecimal("1.25"), "pcs");
        assertTrue(it.isActive(), "New item should be active by default");
        assertEquals(0, it.getStockQuantity(), "New item should have stockQuantity 0 by default");
        assertEquals(new BigDecimal("1.25"), it.getPrice());
    }

    @Test
    public void testSetPriceAndGet() {
        Item it = new Item();
        it.setPrice(new BigDecimal("9.99"));
        assertEquals(new BigDecimal("9.99"), it.getPrice());
    }

    @Test
    public void testActivateDeactivate() {
        Item it = new Item();
        it.setActive(false);
        assertFalse(it.isActive());
        it.setActive(true);
        assertTrue(it.isActive());
    }
}
