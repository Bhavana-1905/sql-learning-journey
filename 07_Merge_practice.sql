/*
TOPIC: MERGE
DATABASE: SQL Server
PURPOSE: Update matching employees and insert new employees.

TARGET TABLE: dbo.employees
SOURCE TABLE: dbo.EmployeeUpdates

IMPORTANT:
- empId in the target is an IDENTITY column.
- Run the source table setup only once.
- Check existing IDs before inserting source IDs.
*/

------------------------------------------------------------
-- 1. CREATE SOURCE TABLE
-- Run only if the table does not already exist.
------------------------------------------------------------

CREATE TABLE dbo.EmployeeUpdates
(
    empId INT PRIMARY KEY,
    empName VARCHAR(50),
    department VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10,2)
);

------------------------------------------------------------
-- 2. INSERT SOURCE DATA
-- Run this section only once.
------------------------------------------------------------

INSERT INTO dbo.EmployeeUpdates
    (empId, empName, department, city, salary)
VALUES
    (1,  'John',   'IT',        'Hyderabad', 60000),
    (2,  'Aman',   'Finance',   'Pune',      55000),
    (5,  'Suraj',  'IT',        'London',    65000),
    (7,  'Sam',    'HR',        'Chennai',   48000),
    (10, 'Don',    'IT',        'NYC',       60000),
    (17, 'Maaya',  'Marketing', 'Kerala',    52000),
    (19, 'Pooja',  'HR',        'Delhi',     45000),
    (20, 'Naveen', 'Sales',     'Pune',      47000);

------------------------------------------------------------
-- 3. VIEW BOTH TABLES
------------------------------------------------------------

SELECT *
FROM dbo.employees
ORDER BY empId;

SELECT *
FROM dbo.EmployeeUpdates
ORDER BY empId;

------------------------------------------------------------
-- 4. MERGE: UPDATE MATCHING EMPLOYEES
------------------------------------------------------------

MERGE INTO dbo.employees AS T
USING dbo.EmployeeUpdates AS S
    ON T.empId = S.empId

WHEN MATCHED THEN
    UPDATE SET
        T.empName = S.empName,
        T.salary = S.salary,
        T.department = S.department,
        T.city = S.city;

------------------------------------------------------------
-- 5. MERGE: UPDATE CHANGED VALUES AND INSERT NEW ROWS
--
-- Preserve source IDs for newly inserted rows.
-- Check that IDs do not belong to different employees.
------------------------------------------------------------

SET IDENTITY_INSERT dbo.employees ON;

MERGE INTO dbo.employees AS T
USING dbo.EmployeeUpdates AS S
    ON T.empId = S.empId

WHEN MATCHED AND
    (
        T.empName <> S.empName
        OR T.salary <> S.salary
        OR T.department <> S.department
        OR T.city <> S.city
    )
THEN
    UPDATE SET
        T.empName = S.empName,
        T.salary = S.salary,
        T.department = S.department,
        T.city = S.city

WHEN NOT MATCHED BY TARGET THEN
    INSERT (empId, empName, department, city, salary)
    VALUES (S.empId, S.empName, S.department, S.city, S.salary);

SET IDENTITY_INSERT dbo.employees OFF;

------------------------------------------------------------
-- 6. VERIFY THE FINAL RESULT
------------------------------------------------------------

SELECT *
FROM dbo.employees
ORDER BY empId;

------------------------------------------------------------
-- 7. FIND SOURCE EMPLOYEES NOT PRESENT IN THE TARGET
-- This query only checks data; it does not modify anything.
------------------------------------------------------------

SELECT S.*
FROM dbo.EmployeeUpdates AS S
LEFT JOIN dbo.employees AS T
    ON T.empId = S.empId
WHERE T.empId IS NULL;

/*
KEY POINTS:

WHEN MATCHED:
Updates rows whose empId matches in both tables.

WHEN MATCHED AND:
Updates only when the specified values differ.

WHEN NOT MATCHED BY TARGET:
Inserts source rows that have no matching target row.

WHEN NOT MATCHED BY SOURCE:
Handles target rows missing from the source.
Do not delete these rows unless the requirement calls for it.

IDENTITY_INSERT:
Allows explicit values to be inserted into an IDENTITY column.

NOTE:
The <> comparison does not detect every change involving NULL.
*/