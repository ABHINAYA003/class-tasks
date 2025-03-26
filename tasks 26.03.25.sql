CREATE DATABASE Task4;
GO
CREATE DATABASE DestinationDB;
GO
USE Task4;
GO
CREATE SCHEMA CustomSchema AUTHORIZATION dbo;
GO
CREATE TABLE CustomSchema.Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT,
    Department NVARCHAR(50)
);
INSERT INTO CustomSchema.Employees (EmployeeID, Name, Age, Department)
VALUES (1, 'Abhi', 30, 'HR'),
       (2, 'Akash', 28, 'IT'),
       (3, 'Kishore', 35, 'Finance');
USE Task4;
GO

task 1:

SELECT * INTO dbo.Employees FROM Task4.CustomSchema.Employees;
Select * from dbo.Employees;


task 2:

USE Task4;
GO
CREATE SCHEMA CustomSchema AUTHORIZATION dbo;
GO
SELECT * INTO DestinationDB.CustomSchema.Employees FROM Task4.CustomSchema.Employees;

task 3:

USE DestinationDB;
GO
CREATE LOGIN Userc WITH PASSWORD = 'Abhi123'; 
CREATE USER Userc FOR LOGIN Userc;
GRANT SELECT ON SCHEMA::CustomSchema TO Userc; 
REVOKE ALTER ON SCHEMA::CustomSchema FROM Userc;
DENY CONTROL ON SCHEMA::CustomSchema TO Userc; 