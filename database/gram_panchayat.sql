-- ============================================
-- Gram Panchayat Management System Database
-- ============================================

CREATE DATABASE IF NOT EXISTS gram_panchayat;
USE gram_panchayat;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    mobile VARCHAR(15) NOT NULL,
    address TEXT,
    role ENUM('ADMIN', 'CITIZEN') DEFAULT 'CITIZEN',
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Birth Certificate Applications
CREATE TABLE birth_certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    child_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    place_of_birth VARCHAR(200) NOT NULL,
    father_name VARCHAR(100) NOT NULL,
    mother_name VARCHAR(100) NOT NULL,
    father_occupation VARCHAR(100),
    mother_occupation VARCHAR(100),
    address TEXT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    admin_remarks TEXT,
    applied_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(id)
);

-- Death Certificate Applications
CREATE TABLE death_certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    deceased_name VARCHAR(100) NOT NULL,
    date_of_death DATE NOT NULL,
    place_of_death VARCHAR(200) NOT NULL,
    cause_of_death VARCHAR(200),
    age_at_death INT,
    relation_with_applicant VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    admin_remarks TEXT,
    applied_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(id)
);

-- Government Schemes
CREATE TABLE schemes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    scheme_name VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    eligibility TEXT NOT NULL,
    benefits TEXT NOT NULL,
    last_date DATE,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Scheme Registrations
CREATE TABLE scheme_registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    scheme_id INT NOT NULL,
    citizen_id INT NOT NULL,
    annual_income DECIMAL(10,2),
    occupation VARCHAR(100),
    family_members INT,
    remarks TEXT,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    admin_remarks TEXT,
    applied_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (scheme_id) REFERENCES schemes(id),
    FOREIGN KEY (citizen_id) REFERENCES users(id)
);

-- Complaints
CREATE TABLE complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    category ENUM('ROAD', 'WATER', 'ELECTRICITY', 'SANITATION', 'OTHER') NOT NULL,
    subject VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(200),
    status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED', 'REJECTED') DEFAULT 'PENDING',
    admin_remarks TEXT,
    filed_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(id)
);

-- Insert default admin
INSERT INTO users (full_name, email, password, mobile, role, status)
VALUES ('Admin', 'admin@gp.gov.in', 'admin123', '9999999999', 'ADMIN', 'ACTIVE');

-- Insert sample schemes
INSERT INTO schemes (scheme_name, description, eligibility, benefits, last_date, status) VALUES
('PM Awas Yojana', 'Housing scheme for rural poor', 'BPL families with no pucca house', 'Financial assistance for house construction', '2025-12-31', 'ACTIVE'),
('Kisan Samman Nidhi', 'Income support for farmers', 'Small and marginal farmers', 'Rs. 6000 per year in 3 installments', '2025-12-31', 'ACTIVE'),
('Ujjwala Yojana', 'LPG connection for rural women', 'BPL women above 18 years', 'Free LPG connection and cylinder', '2025-06-30', 'ACTIVE'),
('Jan Dhan Yojana', 'Financial inclusion scheme', 'All citizens without bank account', 'Zero balance bank account with insurance', '2025-12-31', 'ACTIVE');
