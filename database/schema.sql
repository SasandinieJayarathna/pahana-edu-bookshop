-- Pahana Edu Billing System Database Schema
-- MySQL 8+ Compatible

CREATE DATABASE IF NOT EXISTS pahana_edu_db;
USE pahana_edu_db;

CREATE USER 'pahana_user'@'localhost' IDENTIFIED BY 'pahana_pass123';
GRANT ALL PRIVILEGES ON pahana_edu_db.* TO 'pahana_user'@'localhost';
FLUSH PRIVILEGES;

-- Users table for authentication
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customers table
CREATE TABLE customers (
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

-- Items/Services table
CREATE TABLE items (
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

-- Invoices table
CREATE TABLE invoices (
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

-- Invoice items table
CREATE TABLE invoice_items (
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

-- Insert default admin user (password: admin123)
INSERT INTO users (email, password, name) VALUES
('admin@pahanaedu.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'System Administrator');

-- Insert sample customers
INSERT INTO customers (name, email, phone, address, accountNumber, customerType, telephoneNumber, unitsConsumed) VALUES
('ABC Corporation', 'contact@abc.com', '011-2345678', '123 Business Street, Colombo 01', 'ACC001', 'COMMERCIAL', '011-2345678', 1250.50),
('John Doe', 'john.doe@email.com', '077-1234567', '456 Residential Lane, Colombo 03', 'ACC002', 'RESIDENTIAL', '011-3456789', 850.25),
('XYZ Industries', 'info@xyz.com', '011-7654321', '789 Industrial Zone, Colombo 15', 'ACC003', 'INDUSTRIAL', '011-7654321', 2150.75);

-- Insert sample items
INSERT INTO items (name, code, description, price, unit, stockQuantity) VALUES
('Electricity - Residential', 'ELEC-RES', 'Residential electricity billing per unit', 25.50, 'kWh', 999999),
('Electricity - Commercial', 'ELEC-COM', 'Commercial electricity billing per unit', 32.75, 'kWh', 999999),
('Water Supply', 'WATER-001', 'Municipal water supply per cubic meter', 45.00, 'm³', 999999),
('Service Charge', 'SVC-001', 'Monthly service and maintenance charge', 150.00, 'UNIT', 999999);
