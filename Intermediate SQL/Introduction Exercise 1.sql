-- Part 1: Creating a Table with Constraints
CREATE DATABASE CompanyDB;
-- 1.
USE CompanyDB;
-- 2.
-- 3.
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL DEFAULT 3000.00 CHECK (Salary >= 0),
    DepartmentID INT,
    CONSTRAINT UC_FirstLastName UNIQUE (FirstName, LastName),
    CONSTRAINT FK_Department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- 4.
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);


--Part 2: Basic SQL Queries
-- 1. Insert sample records into the Departments table
INSERT INTO Departments (DepartmentName)
VALUES 
    ('Human Resources'),
    ('Finance'),
    ('IT'),
    ('Marketing'),
    ('Sales');

-- 2. Insert sample records into the Employees table
INSERT INTO Employees (FirstName, LastName, BirthDate, HireDate, Salary, DepartmentID)
VALUES 
    ('John', 'Doe', '1985-04-12', '2015-06-01', 3500.00, 1),
    ('Jane', 'Smith', '1990-08-25', '2018-07-15', 4500.00, 2),
    ('Robert', 'Brown', '1982-01-10', '2010-11-20', 5000.00, 3),
    ('Emily', 'Davis', '1995-02-17', '2021-03-22', 3000.00, 4),
    ('Michael', 'Wilson', '1988-07-30', '2012-09-30', 6000.00, 1);

-- 3. Display all data from the Employees table
SELECT * FROM Employees;

-- 4. Find all employees whose salary is greater than 4000.00
SELECT * FROM Employees
WHERE Salary > 4000.00;

-- 5. Find employees working in a specific department (e.g., DepartmentID = 1)
SELECT * FROM Employees
WHERE DepartmentID = 1;

-- 6. Update the salary of all employees who were hired before the year 2020, increasing it by 10%
UPDATE Employees
SET Salary = Salary * 1.10
WHERE HireDate < '2020-01-01';

-- 7. Delete all employees whose salary is less than 3000.00
DELETE FROM Employees
WHERE Salary < 3000.00;
