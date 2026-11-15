-- --------------------------------------------------------
-- DATABASE CREATION
-- --------------------------------------------------------
CREATE DATABASE IF NOT EXISTS HostelSystem;
USE HostelSystem;


-- Disable foreign key checks temporarily to allow dropping tables smoothly
SET FOREIGN_KEY_CHECKS = 0;


-- --------------------------------------------------------
-- DROP TABLES (If they exist, to start fresh)
-- --------------------------------------------------------
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Fee;
DROP TABLE IF EXISTS Room_Allocation;
DROP TABLE IF EXISTS Visitor_Log;
DROP TABLE IF EXISTS Maintenance_Request;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Visitor;
DROP TABLE IF EXISTS Hostel;


SET FOREIGN_KEY_CHECKS = 1;


-- --------------------------------------------------------
-- 1. TABLE: HOSTEL
-- --------------------------------------------------------
CREATE TABLE Hostel (
    Hostel_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Gender_Type ENUM('Male', 'Female') NOT NULL
);


-- --------------------------------------------------------
-- 2. TABLE: STAFF
-- --------------------------------------------------------
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50),
    Phone VARCHAR(20),
    Shift ENUM('Morning', 'Evening', 'Night')
);


-- --------------------------------------------------------
-- 3. TABLE: STUDENT
-- --------------------------------------------------------
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    CNIC VARCHAR(20) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    DOB DATE,
    Address TEXT
);


-- --------------------------------------------------------
-- 4. TABLE: VISITOR
-- --------------------------------------------------------
CREATE TABLE Visitor (
    Visitor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    CNIC VARCHAR(20) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);


-- --------------------------------------------------------
-- 5. TABLE: ROOM
-- --------------------------------------------------------
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY AUTO_INCREMENT,
    Room_Number VARCHAR(20) NOT NULL,
    Capacity INT DEFAULT 3,
    Hostel_ID INT,
    FOREIGN KEY (Hostel_ID) REFERENCES Hostel(Hostel_ID) ON DELETE CASCADE
);


-- --------------------------------------------------------
-- 6. TABLE: ROOM_ALLOCATION (Associative Entity)
-- --------------------------------------------------------
CREATE TABLE Room_Allocation (
    Allocation_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Room_ID INT,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Status ENUM('Active', 'Expired') DEFAULT 'Active',
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON DELETE CASCADE,
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID) ON DELETE CASCADE
);


-- --------------------------------------------------------
-- 7. TABLE: FEE
-- --------------------------------------------------------
CREATE TABLE Fee (
    Fee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Semester VARCHAR(20),
    Total_Amount DECIMAL(10, 2) NOT NULL,
    Due_Date DATE,
    Status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Unpaid',
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON DELETE CASCADE
);


-- --------------------------------------------------------
-- 8. TABLE: PAYMENT
-- --------------------------------------------------------
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Fee_ID INT,
    Amount_Paid DECIMAL(10, 2) NOT NULL,
    Payment_Date DATE,
    Method ENUM('Cash', 'Bank Transfer', 'Online') DEFAULT 'Cash',
    FOREIGN KEY (Fee_ID) REFERENCES Fee(Fee_ID) ON DELETE CASCADE
);


-- --------------------------------------------------------
-- 9. TABLE: MAINTENANCE_REQUEST
-- --------------------------------------------------------
CREATE TABLE Maintenance_Request (
    Request_ID INT PRIMARY KEY AUTO_INCREMENT,
    Room_ID INT,
    Staff_ID INT,
    Issue_Description TEXT,
    Request_Date DATE,
    Status ENUM('Pending', 'In Progress', 'Resolved') DEFAULT 'Pending',
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID) ON DELETE CASCADE,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON DELETE SET NULL
);


-- --------------------------------------------------------
-- 10. TABLE: VISITOR_LOG (Associative Entity)
-- --------------------------------------------------------
CREATE TABLE Visitor_Log (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    Visitor_ID INT,
    Student_ID INT,
    Visit_Date DATE,
    Time_In TIME,
    Time_Out TIME,
    FOREIGN KEY (Visitor_ID) REFERENCES Visitor(Visitor_ID) ON DELETE CASCADE,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON DELETE CASCADE
);


-- --------------------------------------------------------
-- 11. TABLE: INVENTORY
-- --------------------------------------------------------
CREATE TABLE Inventory (
    Item_ID INT PRIMARY KEY AUTO_INCREMENT,
    Room_ID INT,
    Item_Name VARCHAR(100),
    Quantity INT DEFAULT 1,
    Item_Condition VARCHAR(50),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID) ON DELETE CASCADE
);


-- --------------------------------------------------------
-- 12. TABLE: ATTENDANCE
-- --------------------------------------------------------
CREATE TABLE Attendance (
    Attendance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_ID INT,
    Attendance_Date DATE,
    Time_In TIME,
    Time_Out TIME,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON DELETE CASCADE
);