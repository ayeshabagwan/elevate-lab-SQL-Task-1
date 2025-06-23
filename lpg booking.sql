-- Create LPG Booking System Schema
CREATE DATABASE IF NOT EXISTS lpg_booking_system;
USE lpg_booking_system;

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Cylinders Table
CREATE TABLE IF NOT EXISTS cylinders (
    cylinder_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('5KG', '14.2KG', '19KG') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    in_stock INT DEFAULT 0
) ENGINE=InnoDB;

-- Delivery Staff Table
CREATE TABLE IF NOT EXISTS delivery_staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    status ENUM('available', 'busy') DEFAULT 'available'
) ENGINE=InnoDB;

-- Bookings Table
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    cylinder_id INT NOT NULL,
    quantity INT DEFAULT 1,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivery_status ENUM('pending', 'delivered', 'cancelled') DEFAULT 'pending',
    delivery_staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (cylinder_id) REFERENCES cylinders(cylinder_id) ON DELETE CASCADE,
    FOREIGN KEY (delivery_staff_id) REFERENCES delivery_staff(staff_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Payments Table
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_mode ENUM('cash', 'card', 'online') NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
) ENGINE=InnoDB;
