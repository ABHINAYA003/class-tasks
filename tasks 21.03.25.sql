CREATE DATABASE Task1;
go
use Task1;
go
task set 1
1. CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 60000),
(2, 'Bob', 'Finance', 55000),
(3, 'Charlie', 'HR', 48000),
(4, 'David', 'HR', 52000),
(5, 'Eve', 'IT', 70000);
SELECT NAME 
FROM EMPLOYEES 
WHERE DEPARTMENT = 'HR' AND SALARY > 50000 ;

2. CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    OrderAmount DECIMAL(10,2)
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1, 101, '2024-02-01', 200),
(2, 102, '2024-02-02', 150),
(3, 101, '2024-02-05', 300),
(4, 103, '2024-02-10', 250),
(5, 101, '2024-02-15', 400);
SELECT CustomerID, COUNT(*) AS DuplicateCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 1;

3. CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE
);
INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 201, 10, '2024-03-01'),
(2, 202, 5, '2024-03-02'),
(3, 201, 7, '2024-03-03'),
(4, 203, 3, '2024-03-04');
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Sales
GROUP BY ProductID;

4. CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2)
);
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount) VALUES
(1, 301, '2024-02-25', 100),
(2, 302, '2024-03-05', 250),
(3, 303, '2024-03-10', 300);
SELECT TransactionID, AccountID, TransactionDate, Amount
FROM Transactions
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE());

5. CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    StockQuantity INT
);
INSERT INTO Products (ProductID, ProductName, Price, StockQuantity) VALUES
(10, 'Laptop', 1000, 50),
(20, 'Mouse', 20, 200),
(30, 'Keyboard', 30, 80);
 UPDATE Products
SET Price = Price * 1.10
WHERE StockQuantity < 100;

6. CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(100),
    Email VARCHAR(100),
    Status VARCHAR(20)
);
INSERT INTO Users (UserID, Username, Email, Status) VALUES
(1, 'JohnDoe', 'john@example.com', 'inactive'),
(2, 'JaneDoe', 'jane@example.com', 'active'),
(3, 'MikeSmith', 'mike@example.com', 'inactive');
ALTER TABLE Users ADD LastLoginDate DATE;
UPDATE Users
SET LastLoginDate = '2023-03-10' WHERE UserID = 1;
UPDATE Users
SET LastLoginDate = '2024-03-01' WHERE UserID = 2;
UPDATE Users
SET LastLoginDate = '2023-01-15' WHERE UserID = 3;
DELETE FROM Users
WHERE Status = 'inactive'
AND LastLoginDate < DATEADD(YEAR, -1, GETDATE());
SELECT * FROM Users;


9. CREATE TABLE PRODUCTSS (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Discount VARCHAR(20) NULL
);
INSERT INTO PRODUCTSS (ProductName, Category, Discount) VALUES
('Laptop', 'Electronics', '10%'),
('Smartphone', 'Electronics', NULL),
('Table', 'Furniture', '5%'),
('Chair', 'Furniture', NULL),
('Headphones', 'Electronics', '15%');
SELECT ProductName, 
       ISNULL(Discount, 'No Discount') AS Discount
FROM PRODUCTSS;

10. CREATE TABLE SALESS (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    SaleAmount DECIMAL(10,2) NOT NULL,
    SaleDate DATE NOT NULL
);
INSERT INTO SALESS (ProductID, SaleAmount, SaleDate) VALUES
(101, 500.00, '2024-03-01'),
(101, 700.00, '2024-03-05'),
(101, 600.00, '2024-03-10'),
(102, 900.00, '2024-03-02'),
(102, 800.00, '2024-03-07'),
(103, 1200.00, '2024-03-03'),
(103, 1100.00, '2024-03-08'),
(103, 1300.00, '2024-03-12');
SELECT 
    SaleID, 
    ProductID, 
    SaleAmount, 
    SaleDate, 
    RANK() OVER (PARTITION BY ProductID ORDER BY SaleAmount DESC) AS SaleRank
FROM SALESS;



task set 2

1. SELECT * FROM salesman;

2. SELECT name, commission FROM salesman;

3. SELECT ord_date, salesman_id, ord_no, purch_amt FROM orders;

4. SELECT DISTINCT salesman_id FROM orders;

5. SELECT name, city FROM salesman
WHERE city = 'Paris';

6. SELECT customer_id, cust_name, city, grade, salesman_id 
FROM customer
WHERE grade = 200;

7. SELECT ord_no, ord_date, purch_amt 
FROM orders
WHERE salesman_id = 5001;

8. SELECT year, subject, winner 
FROM nobel_win
WHERE year = 1970;

9. SELECT year, subject, winner, country, category 
FROM nobel_win
WHERE (year = 1970 AND subject = 'Physics')
   OR (year = 1971 AND subject = 'Economics');

10. SELECT year, subject, winner, country, category 
FROM nobel_win
WHERE (subject = 'Physiology' AND year < 1971)
   OR (subject = 'Peace' AND year >= 1974);

