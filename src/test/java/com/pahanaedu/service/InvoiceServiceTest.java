package com.pahanaedu.service;

import com.pahanaedu.dao.*;
import com.pahanaedu.model.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

public class InvoiceServiceTest {

    private InvoiceService invoiceService;
    private InMemoryInvoiceDAO invoiceDAO;
    private InMemoryInvoiceItemDAO invoiceItemDAO;
    private InMemoryCustomerDAO customerDAO;
    private InMemoryItemDAO itemDAO;

    @BeforeEach
    public void setup() throws Exception {
        // create service and replace DAOs with in-memory fakes via reflection
        invoiceService = new InvoiceService();

        invoiceDAO = new InMemoryInvoiceDAO();
        invoiceItemDAO = new InMemoryInvoiceItemDAO();
        customerDAO = new InMemoryCustomerDAO();
        itemDAO = new InMemoryItemDAO();

        // wire fakes using reflection to replace private final fields
        java.lang.reflect.Field f1 = InvoiceService.class.getDeclaredField("invoiceDAO");
        java.lang.reflect.Field f2 = InvoiceService.class.getDeclaredField("invoiceItemDAO");
        java.lang.reflect.Field f3 = InvoiceService.class.getDeclaredField("customerDAO");
        java.lang.reflect.Field f4 = InvoiceService.class.getDeclaredField("itemDAO");
        f1.setAccessible(true);
        f2.setAccessible(true);
        f3.setAccessible(true);
        f4.setAccessible(true);
        f1.set(invoiceService, invoiceDAO);
        f2.set(invoiceService, invoiceItemDAO);
        f3.set(invoiceService, customerDAO);
        f4.set(invoiceService, itemDAO);

        // seed a customer
        Customer c = new Customer("Test Cust", "t@e", "p", "a", "ACC1", Customer.CustomerType.INDIVIDUAL);
        c.setId(1);
        customerDAO.save(c);

        // seed an item
        Item it = new Item("Pen", "P01", "Blue pen", new BigDecimal("2.50"), "pcs");
        it.setId(1);
        itemDAO.save(it);
    }

    @Test
    public void testCreateInvoiceHappyPath() {
        LocalDate today = LocalDate.now();
        LocalDate due = today.plusDays(30);
        Invoice inv = invoiceService.createInvoice(1, today, due);
        assertNotNull(inv);
        assertEquals(1, inv.getCustomerId());
        assertEquals(1, invoiceDAO.getSaved().size());
    }

    @Test
    public void testCreateInvoiceMissingCustomer() {
        LocalDate today = LocalDate.now();
        LocalDate due = today.plusDays(30);
        assertThrows(RuntimeException.class, () -> invoiceService.createInvoice(999, today, due));
    }

    @Test
    public void testAddItemToInvoiceAndRecalculateTotals() {
        // create invoice
        Invoice inv = invoiceService.createInvoice(1, LocalDate.now(), LocalDate.now().plusDays(30));
        int invoiceId = inv.getId();

        // add an item
        invoiceService.addItemToInvoice(invoiceId, 1, new BigDecimal("2"), BigDecimal.ZERO);

        // verify invoice totals updated in DAO
        Invoice stored = invoiceDAO.findById(invoiceId).get();
        assertEquals(new BigDecimal("5.00"), stored.getSubtotal());
        // tax is 15% of subtotal (5.00 * 0.15 = 0.75)
        assertEquals(new BigDecimal("0.75"), stored.getTaxAmount());
        // total = subtotal + tax = 5.00 + 0.75 = 5.75
        assertEquals(new BigDecimal("5.75"), stored.getTotalAmount());
    }

    @Test
    public void testAddItemMissingInvoice() {
        assertThrows(RuntimeException.class,
                () -> invoiceService.addItemToInvoice(999, 1, BigDecimal.ONE, BigDecimal.ZERO));
    }

    @Test
    public void testAddItemMissingItem() {
        Invoice inv = invoiceService.createInvoice(1, LocalDate.now(), LocalDate.now().plusDays(30));
        assertThrows(RuntimeException.class,
                () -> invoiceService.addItemToInvoice(inv.getId(), 999, BigDecimal.ONE, BigDecimal.ZERO));
    }

    @Test
    public void testRemoveItemFromInvoice() {
        Invoice inv = invoiceService.createInvoice(1, LocalDate.now(), LocalDate.now().plusDays(30));
        int invoiceId = inv.getId();
        InvoiceItem ii = invoiceService.addItemToInvoice(invoiceId, 1, new BigDecimal("1"), BigDecimal.ZERO);
        assertEquals(1, invoiceItemDAO.findByInvoiceId(invoiceId).size());
        invoiceService.removeItemFromInvoice(ii.getId());
        assertEquals(0, invoiceItemDAO.findByInvoiceId(invoiceId).size());
    }

    @Test
    public void testUpdatePaymentStatus() {
        Invoice inv = invoiceService.createInvoice(1, LocalDate.now(), LocalDate.now().plusDays(30));
        invoiceService.updatePaymentStatus(inv.getId(), Invoice.PaymentStatus.PAID);
        Invoice stored = invoiceDAO.findById(inv.getId()).get();
        assertEquals(Invoice.PaymentStatus.PAID, stored.getPaymentStatus());
    }

    @Test
    public void testGetMonthlyRevenueAndTotalRevenue() {
        Invoice inv = invoiceService.createInvoice(1, LocalDate.now(), LocalDate.now().plusDays(30));
        invoiceDAO.findById(inv.getId()).get().setTotalAmount(new BigDecimal("100.00"));
        assertEquals(new BigDecimal("100.00"), invoiceService.getTotalRevenue());
        LocalDate d = LocalDate.now();
        assertEquals(new BigDecimal("100.00"), invoiceService.getMonthlyRevenue(d.getYear(), d.getMonthValue()));
    }

    @Test
    public void testFindByIdWithItemsReturnsOptional() {
        Invoice inv = invoiceService.createInvoice(1, LocalDate.now(), LocalDate.now().plusDays(30));
        assertTrue(invoiceService.findByIdWithItems(inv.getId()).isPresent());
    }

    // In-memory DAO implementations below - minimal for testing
    static class InMemoryInvoiceDAO implements InvoiceDAO {
        private final Map<Integer, Invoice> store = new HashMap<>();
        private int seq = 1;

        public Invoice save(Invoice invoice) {
            invoice.setId(seq++);
            store.put(invoice.getId(), invoice);
            return invoice;
        }

        public Optional<Invoice> findById(int id) {
            return Optional.ofNullable(store.get(id));
        }

        public List<Invoice> findAll() {
            return new ArrayList<>(store.values());
        }

        public List<Invoice> findByCustomerId(int customerId) {
            List<Invoice> out = new ArrayList<>();
            for (Invoice i : store.values())
                if (i.getCustomerId() == customerId)
                    out.add(i);
            return out;
        }

        public Invoice update(Invoice invoice) {
            store.put(invoice.getId(), invoice);
            return invoice;
        }

        public void deleteById(int id) {
            store.remove(id);
        }

        public Optional<Invoice> findByInvoiceNumber(String invoiceNumber) {
            return store.values().stream().filter(i -> invoiceNumber.equals(i.getInvoiceNumber())).findFirst();
        }

        public String generateNextInvoiceNumber() {
            return "INV-" + (seq);
        }

        public BigDecimal sumTotalAmount() {
            return store.values().stream().map(Invoice::getTotalAmount).filter(Objects::nonNull).reduce(BigDecimal.ZERO,
                    BigDecimal::add);
        }

        public BigDecimal sumTotalAmountForMonthYear(int year, int month) {
            return sumTotalAmount();
        }

        public Collection<Invoice> getSaved() {
            return store.values();
        }
    }

    static class InMemoryInvoiceItemDAO implements InvoiceItemDAO {
        private final Map<Integer, InvoiceItem> store = new HashMap<>();
        private int seq = 1;

        public InvoiceItem save(InvoiceItem invoiceItem) {
            invoiceItem.setId(seq++);
            store.put(invoiceItem.getId(), invoiceItem);
            return invoiceItem;
        }

        public Optional<InvoiceItem> findById(int id) {
            return Optional.ofNullable(store.get(id));
        }

        public List<InvoiceItem> findByInvoiceId(int invoiceId) {
            List<InvoiceItem> out = new ArrayList<>();
            for (InvoiceItem ii : store.values())
                if (ii.getInvoiceId() == invoiceId)
                    out.add(ii);
            return out;
        }

        public InvoiceItem update(InvoiceItem invoiceItem) {
            store.put(invoiceItem.getId(), invoiceItem);
            return invoiceItem;
        }

        public void deleteById(int id) {
            store.remove(id);
        }

        public void deleteByInvoiceId(int invoiceId) {
            // remove all items with matching invoiceId
            List<Integer> toRemove = new ArrayList<>();
            for (Map.Entry<Integer, InvoiceItem> e : store.entrySet()) {
                if (e.getValue().getInvoiceId() == invoiceId)
                    toRemove.add(e.getKey());
            }
            for (Integer k : toRemove)
                store.remove(k);
        }
    }

    static class InMemoryCustomerDAO implements CustomerDAO {
        private final Map<Integer, Customer> store = new HashMap<>();
        private int seq = 1;

        public Customer save(Customer c) {
            c.setId(seq++);
            store.put(c.getId(), c);
            return c;
        }

        public Optional<Customer> findById(int id) {
            return Optional.ofNullable(store.get(id));
        }

        public List<Customer> findAll() {
            return new ArrayList<>(store.values());
        }

        public Customer update(Customer c) {
            store.put(c.getId(), c);
            return c;
        }

        public void deleteById(int id) {
            store.remove(id);
        }

        public List<Customer> findByNameContaining(String name) {
            List<Customer> out = new ArrayList<>();
            for (Customer c : store.values())
                if (c.getName() != null && c.getName().contains(name))
                    out.add(c);
            return out;
        }

        public Optional<Customer> findByAccountNumber(String accountNumber) {
            return store.values().stream().filter(c -> accountNumber.equals(c.getAccountNumber())).findFirst();
        }
    }

    static class InMemoryItemDAO implements ItemDAO {
        private final Map<Integer, Item> store = new HashMap<>();
        private int seq = 1;

        public Item save(Item i) {
            if (i.getId() == 0)
                i.setId(seq++);
            store.put(i.getId(), i);
            return i;
        }

        public Optional<Item> findById(int id) {
            return Optional.ofNullable(store.get(id));
        }

        public List<Item> findAll() {
            return new ArrayList<>(store.values());
        }

        public List<Item> findAllActive() {
            List<Item> out = new ArrayList<>();
            for (Item it : store.values())
                if (it.isActive())
                    out.add(it);
            return out;
        }

        public Optional<Item> findByCode(String code) {
            return store.values().stream().filter(it -> code.equals(it.getCode())).findFirst();
        }

        public Item update(Item i) {
            store.put(i.getId(), i);
            return i;
        }

        public void deleteById(int id) {
            store.remove(id);
        }

        public List<Item> findByNameContaining(String name) {
            List<Item> out = new ArrayList<>();
            for (Item it : store.values())
                if (it.getName() != null && it.getName().contains(name))
                    out.add(it);
            return out;
        }
    }
}
