package com.pahanaedu.model;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

public class CustomerTest {

    @Test
    public void testConstructorAndUnitsConsumedDefault() {
        Customer c = new Customer("Alice", "a@example.com", "123", "Addr", "ACC1", Customer.CustomerType.INDIVIDUAL);
        assertEquals("Alice", c.getName());
        assertEquals(Customer.CustomerType.INDIVIDUAL, c.getCustomerType());
        assertEquals(BigDecimal.ZERO, c.getUnitsConsumed(), "New customer should have unitsConsumed 0 by default");
    }

    @Test
    public void testSetCustomerTypeAndGet() {
        Customer c = new Customer();
        c.setCustomerType(Customer.CustomerType.BUSINESS);
        assertEquals(Customer.CustomerType.BUSINESS, c.getCustomerType());
    }
}
