CREATE DATABASE Task;
Go
use Task;
go

task1 
CREATE TABLE STUDENTS (STUD_ID INT , SECTION VARCHAR (5), AGE INT CHECK(AGE>=19));
EXEC sp_helpconstraint STUDENTS;

task 2
CREATE TABLE PRODUCTS (PROD_ID INT NOT NULL, PROD_NAME VARCHAR(20) NOT NULL);
INSERT INTO PRODUCTS VALUES(1,'Monitor'),(1,'Keyboard');
SELECT * FROM PRODUCTS;
UPDATE TOP(1) PRODUCTS 
SET PROD_ID = 2
WHERE PROD_ID = 1;
select * from PRODUCTS;

task 3
CREATE TABLE CUSTOMER(CUST_ID INT , CUST_NAME VARCHAR(20));
ALTER TABLE CUSTOMER ADD CONSTRAINT CHECK_CUSTOMER CHECK (CUST_ID >= 6);
INSERT INTO CUSTOMER VALUES (7,'ABHI'),(8,'NAVEE'),(9,'MOHAN');
SELECT * FROM CUSTOMER;
