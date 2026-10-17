/*
=========================================================
TOPIC: WINDOW FUNCTIONS
DATABASE: SQL Server
TABLE: employees
=========================================================
*/


/*
1. CREATE EMPLOYEES TABLE

Run this section only if the employees table
does not already exist.
*/
CREATE TABLE employees
(
    empId INT IDENTITY(1,1) PRIMARY KEY,
    empName VARCHAR(100),
    city VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);


/*
2. INSERT SAMPLE DATA

Run this section only once to avoid duplicate records.
*/

INSERT INTO employees (empName, city, department, salary)
VALUES
('John', 'NYC', 'Sales', 50000),
('Aman', 'Pune', 'IT', 45000),
('Rahul', 'London', 'IT', 35000),
('Ajay', 'Pune', 'Sales', 25000),
('Suraj', 'London', 'IT', 55000),
('Rakesh', 'Pune', 'Sales', 22000),
('Sam', 'NYC', 'IT', 42000),
('Raju', 'Delhi', 'Sales', 20000),
('Samy', 'Pune', 'IT', 25000),
('Don', 'NYC', 'IT', 55000),
('Kittu', 'Delhi', 'Sales', 75000),
('Ram', 'Pune', 'IT', 40000),
('Maaya', 'Kerala', 'Marketing', 48000),
('Krishna', 'Goa', 'Marketing', 37000);


/*
3. VIEW EMPLOYEE DATA
*/

SELECT *
FROM employees
ORDER BY empId;


/*
4. RANK()

Tied salaries receive the same rank.
The next rank is skipped after a tie.
*/

SELECT
    empId,
    empName,
    department,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS SalaryRank
FROM employees;


/* RANK() WITH PARTITION BY */

SELECT
    empId,
    empName,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS DepartmentRank
FROM employees;


/*
5. DENSE_RANK()

Tied salaries receive the same rank.
Ranks are not skipped after a tie.
*/

SELECT
    empId,
    empName,
    department,
    salary,
    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS DenseSalaryRank
FROM employees;


/* DENSE_RANK() WITH PARTITION BY */

SELECT
    empId,
    empName,
    department,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS DepartmentDenseRank
FROM employees;


/*
6. ROW_NUMBER()

Assigns a unique sequential number to each row.
*/

SELECT
    empId,
    empName,
    department,
    salary,
    ROW_NUMBER() OVER (
        ORDER BY salary DESC, empId
    ) AS RowNum
FROM employees;


/* ROW_NUMBER() WITH PARTITION BY */

SELECT
    empId,
    empName,
    department,
    salary,
    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC, empId
    ) AS DepartmentRowNum
FROM employees;


/*
7. PERCENT_RANK()

Returns a relative rank between 0 and 1.
A single-row partition returns 0.
*/

SELECT
    empId,
    empName,
    department,
    salary,
    PERCENT_RANK() OVER (
        ORDER BY salary
    ) AS SalaryPercentRank
FROM employees;


/* PERCENT_RANK() FOR EACH DEPARTMENT */

SELECT
    empId,
    empName,
    department,
    salary,
    PERCENT_RANK() OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS DepartmentPercentRank
FROM employees;


/*
8. LAG()

LAG() retrieves a value from a previous row.
Syntax: LAG(column, offset, default_value)
*/

SELECT
    empId,
    empName,
    salary,
    LAG(salary) OVER (
        ORDER BY empId
    ) AS PreviousSalary
FROM employees;


/* Get the salary from two rows earlier */

SELECT
    empId,
    empName,
    salary,
    LAG(salary, 2) OVER (
        ORDER BY empId
    ) AS SalaryTwoRowsBefore
FROM employees;


/* Specify a default value */

SELECT
    empId,
    empName,
    salary,
    LAG(salary, 1, 0) OVER (
        ORDER BY empId
    ) AS PreviousSalary
FROM employees;


/* Get the previous salary within each department */

SELECT
    empId,
    empName,
    department,
    salary,
    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY empId
    ) AS PreviousDepartmentSalary
FROM employees;


/* Compare current salary with previous salary */

SELECT
    empId,
    empName,
    salary,
    LAG(salary) OVER (
        ORDER BY empId
    ) AS PreviousSalary,
    salary - LAG(salary) OVER (
        ORDER BY empId
    ) AS SalaryDifference
FROM employees;


/*
9. LEAD()

LEAD() retrieves a value from a following row.
*/

SELECT
    empId,
    empName,
    salary,
    LEAD(salary) OVER (
        ORDER BY empId
    ) AS NextSalary
FROM employees;


/* Get the salary two rows ahead */

SELECT
    empId,
    empName,
    salary,
    LEAD(salary, 2) OVER (
        ORDER BY empId
    ) AS SalaryTwoRowsAhead
FROM employees;


/* Specify a default value */

SELECT
    empId,
    empName,
    salary,
    LEAD(salary, 1, 0) OVER (
        ORDER BY empId
    ) AS NextSalary
FROM employees;


/* Get the next salary within each department */

SELECT
    empId,
    empName,
    department,
    salary,
    LEAD(salary) OVER (
        PARTITION BY department
        ORDER BY empId
    ) AS NextDepartmentSalary
FROM employees;


/*
10. FIRST_VALUE()

Returns the first value based on the window ordering.
*/


/* Highest salary in the overall result */

SELECT
    empId,
    empName,
    salary,
    FIRST_VALUE(salary) OVER (
        ORDER BY salary DESC, empId
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS HighestSalary
FROM employees;


/* Lowest salary in the overall result */

SELECT
    empId,
    empName,
    salary,
    FIRST_VALUE(salary) OVER (
        ORDER BY salary ASC, empId
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS LowestSalary
FROM employees;


/* Highest salary in each department */

SELECT
    empId,
    empName,
    department,
    salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC, empId
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS HighestSalaryInDepartment
FROM employees;


/* Name of the highest-paid employee in each department */

SELECT
    empId,
    empName,
    department,
    salary,
    FIRST_VALUE(empName) OVER (
        PARTITION BY department
        ORDER BY salary DESC, empId
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS HighestPaidEmployee
FROM employees;


/*
11. COMBINE LAG() AND LEAD()

Show previous, current, and next salaries.
*/

SELECT
    empId,
    empName,
    LAG(salary) OVER (
        ORDER BY empId
    ) AS PreviousSalary,
    salary AS CurrentSalary,
    LEAD(salary) OVER (
        ORDER BY empId
    ) AS NextSalary
FROM employees;


/*
12. BUSINESS USE CASES
*/


/* Top 3 employees by salary in each department */

WITH EmployeeRanking AS
(
    SELECT
        empId,
        empName,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC, empId
        ) AS RowNum
    FROM employees
)
SELECT
    empId,
    empName,
    department,
    salary
FROM EmployeeRanking
WHERE RowNum <= 3
ORDER BY department, salary DESC;


/* Highest-paid employee(s) in each department, including ties */

WITH EmployeeRanking AS
(
    SELECT
        empId,
        empName,
        department,
        salary,
        RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS SalaryRank
    FROM employees
)
SELECT
    empId,
    empName,
    department,
    salary
FROM EmployeeRanking
WHERE SalaryRank = 1
ORDER BY department;


/* Compare each employee's salary with the previous employee */

SELECT
    empId,
    empName,
    salary,
    LAG(salary) OVER (
        ORDER BY empId
    ) AS PreviousSalary,
    salary - LAG(salary) OVER (
        ORDER BY empId
    ) AS SalaryDifference
FROM employees
ORDER BY empId;


/* Compare salaries within each department */

SELECT
    empId,
    empName,
    department,
    salary,
    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary, empId
    ) AS PreviousSalaryInDepartment
FROM employees
ORDER BY department, salary;


/*
13. QUICK REVISION

RANK()
- Ties receive the same rank.
- Ranks are skipped after ties.

DENSE_RANK()
- Ties receive the same rank.
- Ranks are not skipped.

ROW_NUMBER()
- Assigns a unique sequential number to each row.

PERCENT_RANK()
- Returns a relative rank between 0 and 1.

LAG()
- Retrieves a value from a previous row.

LEAD()
- Retrieves a value from a following row.

FIRST_VALUE()
- Returns the first value based on window ordering
  and the window frame.

PARTITION BY
- Divides rows into groups for window calculations.

ORDER BY inside OVER()
- Defines the order used by the window function.

Window functions calculate values across related rows
without collapsing the rows into one row per group.
*/

