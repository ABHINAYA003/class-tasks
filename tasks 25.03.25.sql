CREATE DATABASE Task3;
GO
use Task3;
GO

1. CREATE TABLE Salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);
INSERT INTO Salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);
CREATE TABLE Orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES Salesman(salesman_id)
);
INSERT INTO Orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001);
SELECT o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id
FROM Orders o
JOIN Salesman s ON o.salesman_id = s.salesman_id
WHERE s.name = 'Paul Adam';


2. SELECT o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id
FROM Orders o
JOIN Salesman s ON o.salesman_id = s.salesman_id
WHERE s.city = 'London';

3. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE customer_id = 3007;

4. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE ord_date = '2012-10-10'
AND purch_amt > (
    SELECT AVG(purch_amt)
    FROM Orders
    WHERE ord_date = '2012-10-10'
);

5. SELECT o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id
FROM Orders o
JOIN Salesman s ON o.salesman_id = s.salesman_id
WHERE s.city = 'New York';

6. SELECT commission
FROM Salesman
WHERE city = 'Paris';

7. CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES Salesman(salesman_id)
);
INSERT INTO Customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidor', 'Moncow', 200, 5007); 
SELECT c.customer_id, c.cust_name, c.city, c.grade, c.salesman_id
FROM Customer c
JOIN Salesman s ON c.salesman_id = s.salesman_id
WHERE s.name = 'Mc Lyon' AND c.customer_id < 2001;

8. SELECT grade, COUNT(*) AS customer_count
FROM Customer
WHERE city = 'New York' 
AND grade > (SELECT AVG(grade) FROM Customer)
GROUP BY grade;

9. SELECT o.ord_no, o.purch_amt, o.ord_date, o.salesman_id
FROM Orders o
JOIN Salesman s ON o.salesman_id = s.salesman_id
WHERE s.commission = (SELECT MAX(commission) FROM Salesman);

10. SELECT o.ord_no, o.purch_amt, o.ord_date, o.customer_id, o.salesman_id, c.cust_name
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.ord_date = '2012-08-17';

11. SELECT s.salesman_id, s.name
FROM Salesman s
JOIN (
    SELECT salesman_id
    FROM Customer
    GROUP BY salesman_id
    HAVING COUNT(customer_id) > 1
) c ON s.salesman_id = c.salesman_id;

12. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt > (SELECT AVG(purch_amt) FROM Orders);

13. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt >= (SELECT AVG(purch_amt) FROM Orders);

14. SELECT ord_date, SUM(purch_amt) AS total_amount
FROM Orders
GROUP BY ord_date
HAVING SUM(purch_amt) >= (SELECT MAX(purch_amt) FROM Orders) + 1000;

15. SELECT * 
FROM Customer
WHERE EXISTS (
    SELECT 1 
    FROM Customer 
    WHERE city = 'London'
);

16. SELECT s.salesman_id, s.name, s.city, s.commission
FROM Salesman s
JOIN Customer c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name, s.city, s.commission
HAVING COUNT(c.customer_id) > 1;

17. SELECT s.salesman_id, s.name, s.city, s.commission
FROM Salesman s
JOIN Customer c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name, s.city, s.commission
HAVING COUNT(c.customer_id) = 1;

18. SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission
FROM Salesman s
JOIN Customer c ON s.salesman_id = c.salesman_id
JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING COUNT(ord_no) > 1
);

19. SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission
FROM Salesman s
WHERE s.city IN (
    SELECT DISTINCT city 
    FROM Customer
);

20. SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission
FROM Salesman s
WHERE s.city IN (
    SELECT DISTINCT city 
    FROM Customer
);

21. SELECT DISTINCT s.salesman_id, s.name, s.city, s.commission
FROM Salesman s
WHERE s.name < ANY (
    SELECT cust_name FROM Customer
);

22. SELECT c1.customer_id, c1.cust_name, c1.city, c1.grade, c1.salesman_id
FROM Customer c1
WHERE c1.grade > ALL (
    SELECT c2.grade
    FROM Customer c2
    WHERE c2.city > 'New York'
);

23. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt > ANY (
    SELECT purch_amt
    FROM Orders
    WHERE ord_date = '2012-09-10'
);

24. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt < ANY (
    SELECT purch_amt
    FROM Orders
    WHERE customer_id IN (
        SELECT customer_id
        FROM Customer
        WHERE city = 'London'
    )
);

25. SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id
FROM Orders
WHERE purch_amt < (
    SELECT MAX(purch_amt)
    FROM Orders
    WHERE customer_id IN (
        SELECT customer_id
        FROM Customer
        WHERE city = 'London'
    )
);

26. SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade > ANY (
    SELECT grade
    FROM Customer
    WHERE city = 'New York'
);

27. SELECT s.name AS salesperson_name, s.city, SUM(o.purch_amt) AS total_order_amount
FROM Salesman s
JOIN Customer c ON s.city = c.city
JOIN Orders o ON s.salesman_id = o.salesman_id
GROUP BY s.name, s.city
ORDER BY total_order_amount DESC;


28. SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade NOT IN (SELECT DISTINCT grade FROM Customer WHERE city = 'London');

29. SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade NOT IN (SELECT DISTINCT grade FROM Customer WHERE city = 'Paris');

30. SELECT customer_id, cust_name, city, grade, salesman_id
FROM Customer
WHERE grade NOT IN (SELECT DISTINCT grade FROM Customer WHERE city = 'Dallas');

31. CREATE TABLE company_mast (
    COM_ID INT PRIMARY KEY,
    COM_NAME VARCHAR(50) NOT NULL
);
INSERT INTO company_mast (COM_ID, COM_NAME) VALUES
(11, 'Samsung'),
(12, 'iBall'),
(13, 'Epsion'),
(14, 'Zebronics'),
(15, 'Asus'),
(16, 'Frontech');
CREATE TABLE item_mast (
    PRO_ID INT PRIMARY KEY,
    PRO_NAME VARCHAR(50) NOT NULL,
    PRO_PRICE DECIMAL(10,2) NOT NULL,
    PRO_COM INT,
    FOREIGN KEY (PRO_COM) REFERENCES company_mast(COM_ID)
);
INSERT INTO item_mast (PRO_ID, PRO_NAME, PRO_PRICE,PRO_COM) VALUES
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
    AVG(i.PRO_PRICE) AS Average_Price, 
    c.COM_NAME AS Company
FROM item_mast i
JOIN company_mast c ON i.PRO_COM = c.COM_ID
GROUP BY c.COM_NAME;

32. SELECT c.COM_NAME AS Company, 
       AVG(i.PRO_PRICE) AS Average_Price
FROM item_mast i
JOIN company_mast c ON i.PRO_COM = c.COM_ID
WHERE i.PRO_PRICE >= 350
GROUP BY c.COM_NAME;

33. SELECT i.PRO_NAME AS Product_Name, 
       i.PRO_PRICE AS Price, 
       c.COM_NAME AS Company
FROM item_mast i
JOIN company_mast c ON i.PRO_COM = c.COM_ID
WHERE i.PRO_PRICE = (
    SELECT MAX(i2.PRO_PRICE)
    FROM item_mast i2
    WHERE i2.PRO_COM = i.PRO_COM
);

34. CREATE TABLE emp_details (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(50),
    emp_lname VARCHAR(50),
    emp_dept INT
);
INSERT INTO emp_details (emp_idno, emp_fname, emp_lname, emp_dept) VALUES
(127323, 'Michale', 'Robbin', 57),
(526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57),
(539569, 'George', 'Mardy', 27),
(733843, 'Mario', 'Saule', 63),
(631548, 'Alan', 'Snappy', 27),
(839139, 'Maria', 'Foster', 57);
SELECT emp_idno, emp_fname, emp_lname, emp_dept
FROM emp_details
WHERE emp_lname IN ('Gabriel', 'Dosio');

35. SELECT emp_idno, emp_fname, emp_lname, emp_dept
FROM emp_details
WHERE emp_dept IN (89, 63);

36. CREATE TABLE emp_department (
    dpt_code INT PRIMARY KEY,
    dpt_name VARCHAR(50),
    dpt_allotment DECIMAL(10,2)
);
INSERT INTO emp_department (dpt_code, dpt_name, dpt_allotment) VALUES
(57, 'IT', 65000),
(63, 'Finance', 15000),
(47, 'HR', 240000),
(27, 'RD', 55000),
(89, 'QC', 75000);
SELECT e.emp_fname, e.emp_lname
FROM emp_details e
JOIN emp_department d ON e.emp_dept = d.dpt_code
WHERE d.dpt_allotment > 50000;

37. SELECT dpt_code, dpt_name, dpt_allotment
FROM emp_department
WHERE dpt_allotment > (SELECT AVG(dpt_allotment) FROM emp_department);

38. SELECT d.dpt_name
FROM emp_department d
JOIN emp_details e ON d.dpt_code = e.emp_dept
GROUP BY d.dpt_code, d.dpt_name
HAVING COUNT(e.emp_idno) > 2;

39. WITH DepartmentRank AS (
    SELECT dpt_code, dpt_allotment,
           DENSE_RANK() OVER (ORDER BY dpt_allotment) AS rank
    FROM emp_department
)
SELECT e.emp_fname, e.emp_lname
FROM emp_details e
JOIN DepartmentRank d ON e.emp_dept = d.dpt_code
WHERE d.rank = 2;



























