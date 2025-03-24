CREATE DATABASE TASK2;
GO
USE Task2;
go
1. CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5,2)
);
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006),
(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
(3001, 'Brad Guzan', 'London', NULL, 5005);
SELECT s.name AS Salesman, c.cust_name, s.city
FROM salesman s
JOIN customer c ON s.city = c.city;

2. CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003);
SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;


3. SELECT c.cust_name, c.city, s.name AS salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id;


4. SELECT c.cust_name, c.city AS customer_city, s.name AS salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

5. SELECT 
    c.cust_name AS "Customer Name",
    c.city AS "Customer City",
    s.name AS "Salesman",
    s.city AS "Salesman City",
    s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.city <> c.city 
AND s.commission > 0.12;

6. SELECT 
    o.ord_no, 
    o.ord_date, 
    o.purch_amt, 
    c.cust_name, 
    c.grade, 
    s.name AS salesman, 
    s.commission
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

7. SELECT 
    o.ord_no, 
    o.ord_date, 
    o.purch_amt, 
    c.customer_id, 
    c.cust_name, 
    c.city AS customer_city, 
    c.grade, 
    s.salesman_id, 
    s.name AS salesman_name, 
    s.city AS salesman_city, 
    s.commission
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;


8. SELECT 
    c.customer_id, 
    c.cust_name, 
    c.city AS customer_city, 
    c.grade, 
    s.name AS salesman_name, 
    s.city AS salesman_city
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC;

9. SELECT 
    c.customer_id, 
    c.cust_name, 
    c.city AS customer_city, 
    c.grade, 
    s.name AS salesman_name, 
    s.city AS salesman_city
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.grade < 300 OR c.grade IS NULL
ORDER BY c.customer_id ASC;


10. SELECT 
    c.cust_name, 
    c.city AS customer_city, 
    o.ord_no, 
    o.ord_date, 
    o.purch_amt 
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.ord_date ASC;

11. SELECT 
    c.cust_name AS "Customer Name",
    c.city AS "Customer City",
    o.ord_no AS "Order Number",
    o.ord_date AS "Order Date",
    o.purch_amt AS "Order Amount",
    s.name AS "Salesperson Name",
    s.commission AS "Commission"
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN salesman s ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id;

12.  SELECT DISTINCT s.salesman_id, s.name AS "Salesperson Name", s.city AS "Salesperson City", s.commission 
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
ORDER BY s.salesman_id;

13. SELECT 
    s.salesman_id, 
    s.name AS "Salesperson Name", 
    s.city AS "Salesperson City", 
    s.commission, 
    c.customer_id, 
    c.cust_name AS "Customer Name", 
    c.city AS "Customer City", 
    c.grade, 
    o.ord_no AS "Order Number", 
    o.ord_date AS "Order Date", 
    o.purch_amt AS "Order Amount"
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY s.salesman_id, c.customer_id, o.ord_date;


14. SELECT DISTINCT 
    s.salesman_id, 
    s.name AS "Salesperson Name", 
    s.city AS "Salesperson City", 
    s.commission, 
    c.customer_id, 
    c.cust_name AS "Customer Name", 
    c.city AS "Customer City", 
    c.grade, 
    o.ord_no AS "Order Number", 
    o.ord_date AS "Order Date", 
    o.purch_amt AS "Order Amount"
FROM salesman s
LEFT JOIN customer c ON s.salesman_id = c.salesman_id
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE 
    (o.purch_amt >= 2000 AND c.grade IS NOT NULL)
    OR o.ord_no IS NULL
ORDER BY s.salesman_id, c.customer_id;

15. SELECT 
    COALESCE(c.cust_name, 'Unknown') AS "Customer Name",
    COALESCE(c.city, 'Unknown') AS "City",
    o.ord_no AS "Order Number",
    o.ord_date AS "Order Date",
    o.purch_amt AS "Purchase Amount"
FROM orders o
LEFT JOIN customer c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NOT NULL OR o.customer_id NOT IN (SELECT customer_id FROM customer)
ORDER BY o.ord_date, o.ord_no;

16. SELECT 
    COALESCE(c.cust_name, 'Unknown') AS "Customer Name",
    COALESCE(c.city, 'Unknown') AS "City",
    o.ord_no AS "Order Number",
    o.ord_date AS "Order Date",
    o.purch_amt AS "Purchase Amount"
FROM orders o
LEFT JOIN customer c ON o.customer_id = c.customer_id
WHERE (c.grade IS NOT NULL AND c.customer_id IS NOT NULL) 
   OR (c.customer_id IS NULL OR c.grade IS NULL)
ORDER BY o.ord_date, o.ord_no;

17. SELECT 
    s.salesman_id AS "Salesman ID",
    s.name AS "Salesman Name",
    s.city AS "Salesman City",
    s.commission AS "Commission",
    c.customer_id AS "Customer ID",
    c.cust_name AS "Customer Name",
    c.city AS "Customer City",
    c.grade AS "Customer Grade",
    c.salesman_id AS "Assigned Salesman ID"
FROM salesman s
CROSS JOIN customer c
ORDER BY s.salesman_id, c.customer_id;


18. SELECT 
    s.salesman_id AS "Salesman ID",
    s.name AS "Salesman Name",
    s.city AS "City",
    s.commission AS "Commission",
    c.customer_id AS "Customer ID",
    c.cust_name AS "Customer Name",
    c.grade AS "Customer Grade",
    c.salesman_id AS "Assigned Salesman ID"
FROM salesman s
JOIN customer c
ON s.city = c.city
ORDER BY s.salesman_id, c.customer_id;

19. SELECT 
    s.salesman_id AS "Salesman ID",
    s.name AS "Salesman Name",
    s.city AS "City",
    s.commission AS "Commission",
    c.customer_id AS "Customer ID",
    c.cust_name AS "Customer Name",
    c.grade AS "Customer Grade",
    c.salesman_id AS "Assigned Salesman ID"
FROM salesman s
CROSS JOIN customer c
WHERE s.city IS NOT NULL  -- Salesman must belong to a city
AND c.grade IS NOT NULL   -- Customer must have a grade
ORDER BY s.salesman_id, c.customer_id;

20. SELECT 
    s.salesman_id, 
    s.name AS salesman_name, 
    s.city AS salesman_city, 
    c.customer_id, 
    c.cust_name AS customer_name, 
    c.city AS customer_city, 
    c.grade
FROM salesman s
CROSS JOIN customer c
WHERE s.city <> c.city 
AND c.grade IS NOT NULL;

21. CREATE TABLE company_mast (
    com_id INT PRIMARY KEY,
    com_name VARCHAR(50) NOT NULL
);
CREATE TABLE item_mast (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(100) NOT NULL,
    pro_price DECIMAL(10,2) NOT NULL,
    pro_com INT,
    FOREIGN KEY (pro_com) REFERENCES company_mast(com_id)
);
INSERT INTO company_mast (com_id, com_name) VALUES
(11, 'Samsung'),
(12, 'iBall'),
(13, 'Epsion'),
(14, 'Zebronics'),
(15, 'Asus'),
(16, 'Frontech');
INSERT INTO item_mast (pro_id, pro_name, pro_price, pro_com) VALUES
(101, 'Mother Board', 3200.00, 15),
(102, 'Key Board', 450.00, 16),
(103, 'ZIP drive', 250.00, 14),
(104, 'Speaker', 550.00, 16),
(105, 'Monitor', 5000.00, 11),
(106, 'DVD drive', 900.00, 12),
(107, 'CD drive', 800.00, 12),
(108, 'Printer', 2600.00, 13),
(109, 'Refill cartridge', 350.00, 13),
(110, 'Mouse', 250.00, 12);
    SELECT 
    i.pro_id, 
    i.pro_name, 
    i.pro_price, 
    c.com_id, 
    c.com_name
FROM item_mast i
INNER JOIN company_mast c 
ON i.pro_com = c.com_id;

22. SELECT 
    i.pro_name AS Item_Name, 
    i.pro_price AS Price, 
    c.com_name AS Company_Name
FROM item_mast i
INNER JOIN company_mast c 
ON i.pro_com = c.com_id;

23. SELECT 
    c.com_name AS Company_Name, 
    AVG(i.pro_price) AS Average_Price
FROM item_mast i
INNER JOIN company_mast c 
ON i.pro_com = c.com_id
GROUP BY c.com_name;

24. SELECT c.COM_NAME, AVG(i.PRO_PRICE) AS AVG_PRICE
FROM item_mast i
JOIN company_mast c ON i.PRO_COM = c.COM_ID
GROUP BY c.COM_NAME
HAVING AVG(i.PRO_PRICE) >= 350;

25. SELECT i.PRO_NAME, i.PRO_PRICE, c.COM_NAME
FROM item_mast i
JOIN company_mast c ON i.PRO_COM = c.COM_ID
WHERE i.PRO_PRICE = (
    SELECT MAX(i2.PRO_PRICE) 
    FROM item_mast i2 
    WHERE i2.PRO_COM = i.PRO_COM
);

26. CREATE TABLE emp_department (
    DPT_CODE INT PRIMARY KEY,
    DPT_NAME VARCHAR(50),
    DPT_ALLOTMENT DECIMAL(10,2)
);
CREATE TABLE emp_details (
    EMP_IDNO INT PRIMARY KEY,
    EMP_FNAME VARCHAR(50),
    EMP_LNAME VARCHAR(50),
    EMP_DEPT INT,
    FOREIGN KEY (EMP_DEPT) REFERENCES emp_department(DPT_CODE)
);
INSERT INTO emp_department (DPT_CODE, DPT_NAME, DPT_ALLOTMENT) VALUES
(57, 'IT', 65000),
(63, 'Finance', 15000),
(47, 'HR', 240000),
(27, 'RD', 55000),
(89, 'QC', 75000);
INSERT INTO emp_details (EMP_IDNO, EMP_FNAME, EMP_LNAME, EMP_DEPT) VALUES
(127323, 'Michale', 'Robbin', 57),
(526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57);
SELECT e.EMP_IDNO, e.EMP_FNAME, e.EMP_LNAME, d.DPT_NAME, d.DPT_ALLOTMENT
FROM emp_details e
JOIN emp_department d ON e.EMP_DEPT = d.DPT_CODE;

27. SELECT e.EMP_FNAME, e.EMP_LNAME, d.DPT_NAME, d.DPT_ALLOTMENT
FROM emp_details e
JOIN emp_department d ON e.EMP_DEPT = d.DPT_CODE;


28. SELECT e.EMP_FNAME, e.EMP_LNAME
FROM emp_details e
JOIN emp_department d ON e.EMP_DEPT = d.DPT_CODE
WHERE d.DPT_ALLOTMENT > 50000;

29. SELECT d.DPT_NAME
FROM emp_details e
JOIN emp_department d ON e.EMP_DEPT = d.DPT_CODE
GROUP BY d.DPT_NAME
HAVING COUNT(e.EMP_IDNO) > 2;















