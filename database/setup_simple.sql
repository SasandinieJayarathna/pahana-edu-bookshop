-- Simple Database Setup for Pahana Edu Billing System
-- Run this in MySQL Command Line or MySQL Workbench

-- Create database
CREATE DATABASE IF NOT EXISTS pahana_edu_db;
USE pahana_edu_db;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create customers table
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    notes TEXT,
    accountNumber VARCHAR(50) UNIQUE,
    customerType ENUM('RESIDENTIAL', 'COMMERCIAL', 'INDUSTRIAL') DEFAULT 'RESIDENTIAL',
    telephoneNumber VARCHAR(20),
    unitsConsumed DECIMAL(10, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create items table
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    unit VARCHAR(50) DEFAULT 'UNIT',
    active BOOLEAN DEFAULT TRUE,
    stockQuantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create invoices table
CREATE TABLE IF NOT EXISTS invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoiceNumber VARCHAR(100) NOT NULL UNIQUE,
    customer_id INT NOT NULL,
    invoiceDate DATE NOT NULL,
    dueDate DATE NOT NULL,
    subtotal DECIMAL(10, 2) DEFAULT 0.00,
    taxAmount DECIMAL(10, 2) DEFAULT 0.00,
    discountAmount DECIMAL(10, 2) DEFAULT 0.00,
    totalAmount DECIMAL(10, 2) DEFAULT 0.00,
    paymentStatus ENUM('PENDING', 'PAID', 'OVERDUE', 'CANCELLED') DEFAULT 'PENDING',
    notes TEXT,
    paymentTerms VARCHAR(255) DEFAULT 'Net 30',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Create invoice_items table
CREATE TABLE IF NOT EXISTS invoice_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    unitPrice DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(10, 2) DEFAULT 0.00,
    lineTotal DECIMAL(10, 2) NOT NULL,
    description TEXT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

USE pahana_edu_db;

-- Insert test admin user (password: admin123)
-- The password hash is for 'admin123' using simple SHA-256
INSERT INTO users (email, password, name) VALUES
('admin@gmail.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'System Administrator')
ON DUPLICATE KEY UPDATE email = email;

-- Insert sample customers (idempotent)
INSERT INTO customers (name, email, phone, address, accountNumber, customerType, telephoneNumber, unitsConsumed) VALUES
('Lanka Trading Co.', 'admin@lankatrading.lk', '011-5678901', '25 Galle Road, Dehiwala', 'LT001', 'COMMERCIAL', '011-5678901', 1850.75),
('Priya Fernando', 'priya.fernando@gmail.com', '071-8765432', '78 Temple Road, Nugegoda', 'PF002', 'RESIDENTIAL', '011-8901234', 950.50),
('Ceylon Steel Mills', 'operations@ceylonsteel.com', '011-9876543', '150 Industrial Estate, Ekala', 'CSM003', 'INDUSTRIAL', '011-9876543', 3150.25),
('Perera Household', 'malith.perera@yahoo.com', '077-5432109', '42 Flower Road, Kandy', 'PH004', 'RESIDENTIAL', '081-2345678', 675.80),
('Digital Solutions PVT', 'contact@digitalsol.lk', '011-4567890', '88 Ward Place, Colombo 07', 'DS005', 'COMMERCIAL', '011-4567890', 2250.60),
('Atlas Manufacturing', 'info@atlasmanuf.com', '011-6789012', '200 Export Processing Zone, Katunayake', 'AM006', 'INDUSTRIAL', '011-6789012', 4100.90)
ON DUPLICATE KEY UPDATE accountNumber = accountNumber;

-- Insert sample items (idempotent)
INSERT INTO items (name, code, description, price, unit, stockQuantity) VALUES
('Power - Residential Rate', 'PWR-RES-01', 'Residential power consumption billing', 27.80, 'kWh', 999999),
('Power - Commercial Rate', 'PWR-COM-01', 'Commercial power consumption billing', 35.20, 'kWh', 999999),
('Power - Industrial Rate', 'PWR-IND-01', 'Industrial power consumption billing', 31.50, 'kWh', 999999),
('Water Services', 'H2O-SVC-01', 'Municipal water service per cubic meter', 52.00, 'm³', 999999),
('Monthly Maintenance', 'MAINT-001', 'Monthly maintenance and service fee', 180.00, 'UNIT', 999999),
('Installation Fee', 'INSTALL-01', 'New installation and setup charges', 750.00, 'UNIT', 999999)
ON DUPLICATE KEY UPDATE code = code;

-- Insert sample invoices (idempotent)
INSERT INTO invoices (invoiceNumber, customer_id, invoiceDate, dueDate, subtotal, taxAmount, discountAmount, totalAmount, paymentStatus, notes, paymentTerms) VALUES
('INV-2025-101', 1, '2025-08-05', '2025-09-04', 1200.00, 180.00, 80.00, 1300.00, 'PAID', 'August commercial billing', 'Net 30'),
('INV-2025-102', 2, '2025-08-08', '2025-09-07', 650.00, 97.50, 25.00, 722.50, 'PAID', 'Residential power bill', 'Net 30'),
('INV-2025-103', 3, '2025-08-10', '2025-09-09', 2800.00, 420.00, 150.00, 3070.00, 'PENDING', 'Industrial power consumption', 'Net 30'),
('INV-2025-104', 4, '2025-08-12', '2025-09-11', 425.00, 63.75, 15.00, 473.75, 'PAID', 'Kandy residential billing', 'Net 30'),
('INV-2025-105', 5, '2025-08-15', '2025-09-14', 1800.00, 270.00, 120.00, 1950.00, 'PENDING', 'Digital solutions billing', 'Net 30'),
('INV-2025-106', 6, '2025-08-18', '2025-09-17', 3200.00, 480.00, 200.00, 3480.00, 'PENDING', 'Atlas manufacturing bill', 'Net 30'),
('INV-2025-107', 1, '2025-07-20', '2025-08-19', 1150.00, 172.50, 50.00, 1272.50, 'PAID', 'July trading company bill', 'Net 30'),
('INV-2025-108', 2, '2025-07-25', '2025-08-24', 580.00, 87.00, 30.00, 637.00, 'PAID', 'July residential power', 'Net 30'),
('INV-2025-109', 3, '2025-06-30', '2025-07-29', 2650.00, 397.50, 100.00, 2947.50, 'OVERDUE', 'June steel mills billing', 'Net 30'),
('INV-2025-110', 4, '2025-08-20', '2025-09-19', 390.00, 58.50, 10.00, 438.50, 'PENDING', 'Late August billing', 'Net 30')
ON DUPLICATE KEY UPDATE invoiceNumber = invoiceNumber;

-- Insert sample invoice items using joins and NOT EXISTS to avoid duplicates or FK issues
-- Invoice 101 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 34.00, 35.20, 0.00, 1196.80, 'Commercial power usage - August'
FROM invoices i
JOIN items it ON it.code = 'PWR-COM-01'
WHERE i.invoiceNumber = 'INV-2025-101'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1196.80 AND ii.description = 'Commercial power usage - August'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 176.80, 3.20, 'Maintenance with discount'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-101'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 3.20 AND ii.description = 'Maintenance with discount'
  );

-- Invoice 102 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 23.50, 27.80, 0.00, 653.30, 'Residential power - August'
FROM invoices i
JOIN items it ON it.code = 'PWR-RES-01'
WHERE i.invoiceNumber = 'INV-2025-102'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 653.30 AND ii.description = 'Residential power - August'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 183.30, -3.30, 'Service credit adjustment'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-102'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = -3.30 AND ii.description = 'Service credit adjustment'
  );

-- Invoice 103 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 85.00, 31.50, 0.00, 2677.50, 'Industrial power consumption'
FROM invoices i
JOIN items it ON it.code = 'PWR-IND-01'
WHERE i.invoiceNumber = 'INV-2025-103'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 2677.50 AND ii.description = 'Industrial power consumption'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 6.50, 52.00, 0.00, 338.00, 'Industrial water supply'
FROM invoices i
JOIN items it ON it.code = 'H2O-SVC-01'
WHERE i.invoiceNumber = 'INV-2025-103'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 338.00 AND ii.description = 'Industrial water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 395.50, -215.50, 'Maintenance credit'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-103'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = -215.50 AND ii.description = 'Maintenance credit'
  );

-- Invoice 104 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 15.25, 27.80, 0.00, 423.95, 'Residential power - Kandy'
FROM invoices i
JOIN items it ON it.code = 'PWR-RES-01'
WHERE i.invoiceNumber = 'INV-2025-104'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 423.95 AND ii.description = 'Residential power - Kandy'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 178.95, 1.05, 'Partial maintenance'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-104'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1.05 AND ii.description = 'Partial maintenance'
  );

-- Invoice 105 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 50.00, 35.20, 0.00, 1760.00, 'Commercial power - Digital Sol'
FROM invoices i
JOIN items it ON it.code = 'PWR-COM-01'
WHERE i.invoiceNumber = 'INV-2025-105'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1760.00 AND ii.description = 'Commercial power - Digital Sol'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 4.00, 52.00, 0.00, 208.00, 'Water services'
FROM invoices i
JOIN items it ON it.code = 'H2O-SVC-01'
WHERE i.invoiceNumber = 'INV-2025-105'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 208.00 AND ii.description = 'Water services'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 148.00, 32.00, 'Maintenance with discount'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-105'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 32.00 AND ii.description = 'Maintenance with discount'
  );

-- Invoice 106 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 95.00, 31.50, 0.00, 2992.50, 'Atlas industrial power'
FROM invoices i
JOIN items it ON it.code = 'PWR-IND-01'
WHERE i.invoiceNumber = 'INV-2025-106'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 2992.50 AND ii.description = 'Atlas industrial power'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 9.00, 52.00, 0.00, 468.00, 'Manufacturing water supply'
FROM invoices i
JOIN items it ON it.code = 'H2O-SVC-01'
WHERE i.invoiceNumber = 'INV-2025-106'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 468.00 AND ii.description = 'Manufacturing water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 440.50, -260.50, 'Maintenance adjustment'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-106'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = -260.50 AND ii.description = 'Maintenance adjustment'
  );

-- Invoice 107 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 32.50, 35.20, 0.00, 1144.00, 'July commercial power'
FROM invoices i
JOIN items it ON it.code = 'PWR-COM-01'
WHERE i.invoiceNumber = 'INV-2025-107'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 1144.00 AND ii.description = 'July commercial power'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 174.00, 6.00, 'Standard maintenance'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-107'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 6.00 AND ii.description = 'Standard maintenance'
  );

-- Invoice 108 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 20.75, 27.80, 0.00, 576.85, 'July residential power'
FROM invoices i
JOIN items it ON it.code = 'PWR-RES-01'
WHERE i.invoiceNumber = 'INV-2025-108'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 576.85 AND ii.description = 'July residential power'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 176.85, 3.15, 'Reduced maintenance'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-108'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 3.15 AND ii.description = 'Reduced maintenance'
  );

-- Invoice 109 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 78.00, 31.50, 0.00, 2457.00, 'June steel mills power'
FROM invoices i
JOIN items it ON it.code = 'PWR-IND-01'
WHERE i.invoiceNumber = 'INV-2025-109'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 2457.00 AND ii.description = 'June steel mills power'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 7.50, 52.00, 0.00, 390.00, 'June water supply'
FROM invoices i
JOIN items it ON it.code = 'H2O-SVC-01'
WHERE i.invoiceNumber = 'INV-2025-109'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 390.00 AND ii.description = 'June water supply'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 377.00, -197.00, 'Service adjustment credit'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-109'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = -197.00 AND ii.description = 'Service adjustment credit'
  );

-- Invoice 110 items
INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 13.75, 27.80, 0.00, 382.25, 'Late August residential'
FROM invoices i
JOIN items it ON it.code = 'PWR-RES-01'
WHERE i.invoiceNumber = 'INV-2025-110'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 382.25 AND ii.description = 'Late August residential'
  );

INSERT INTO invoice_items (invoice_id, item_id, quantity, unitPrice, discount, lineTotal, description)
SELECT i.id, it.id, 1, 180.00, 172.25, 7.75, 'Pro-rated maintenance'
FROM invoices i
JOIN items it ON it.code = 'MAINT-001'
WHERE i.invoiceNumber = 'INV-2025-110'
  AND NOT EXISTS (
    SELECT 1 FROM invoice_items ii WHERE ii.invoice_id = i.id AND ii.item_id = it.id AND ii.lineTotal = 7.75 AND ii.description = 'Pro-rated maintenance'
  );

-- Display summary
SELECT 'Modified sample data inserted successfully!' as Status;
SELECT COUNT(*) as UserCount FROM users;
SELECT COUNT(*) as CustomerCount FROM customers;
SELECT COUNT(*) as ItemCount FROM items;
SELECT COUNT(*) as InvoiceCount FROM invoices;
SELECT COUNT(*) as InvoiceItemCount FROM invoice_items;
SELECT SUM(totalAmount) as TotalRevenue FROM invoices;
SELECT 
    paymentStatus, 
    COUNT(*) as Count, 
    SUM(totalAmount) as Amount 
FROM invoices 
GROUP BY paymentStatus;
