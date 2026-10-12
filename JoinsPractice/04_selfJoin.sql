-- ============================================
-- Topic: SELF JOIN
-- Database: AdventureWorksDW
-- Table: DimEmployee
-- ============================================

-- CONCEPT:
-- A SELF JOIN joins a table with itself.
-- We use aliases to treat the same table as two references.
-- Example: matching employees with their managers.

-- SYNTAX:
-- SELECT columns
-- FROM TableName AS a
-- JOIN TableName AS b
--     ON a.CommonColumn = b.CommonColumn;


-- EXAMPLE 1: Display employees and their managers.
-- Employee and manager details come from the same table.

SELECT e.FirstName AS EmployeeName,
       m.FirstName AS ManagerName
FROM DimEmployee AS e
LEFT JOIN DimEmployee AS m
    ON e.ParentEmployeeKey = m.EmployeeKey;


-- EXAMPLE 2: Display only employees who have a manager.
-- INNER JOIN excludes employees without a matching manager.

SELECT e.FirstName AS EmployeeName,
       m.FirstName AS ManagerName
FROM DimEmployee AS e
INNER JOIN DimEmployee AS m
    ON e.ParentEmployeeKey = m.EmployeeKey;


-- EXAMPLE 3: Display employees who report to the same manager.
-- e1 and e2 represent two employee rows.
-- The EmployeeKey condition prevents an employee matching themselves.

SELECT e1.FirstName AS Employee1,
       e2.FirstName AS Employee2,
       e1.ParentEmployeeKey AS ManagerKey
FROM DimEmployee AS e1
INNER JOIN DimEmployee AS e2
    ON e1.ParentEmployeeKey = e2.ParentEmployeeKey
    AND e1.EmployeeKey < e2.EmployeeKey
WHERE e1.ParentEmployeeKey IS NOT NULL;


-- EXAMPLE 4: Find employees with the same first name.
-- The EmployeeKey condition avoids matching a row with itself
-- and avoids duplicate pairs in reverse order.

SELECT e1.FirstName AS Employee1,
       e2.FirstName AS Employee2
FROM DimEmployee AS e1
INNER JOIN DimEmployee AS e2
    ON e1.FirstName = e2.FirstName
    AND e1.EmployeeKey < e2.EmployeeKey;


-- IMPORTANT TAKEAWAYS:
-- 1. A SELF JOIN joins a table to itself.
-- 2. Aliases distinguish the two references to the table.
-- 3. INNER JOIN returns only matching rows.
-- 4. LEFT JOIN can preserve rows without a matching row.
-- 5. Use a condition such as EmployeeKey < EmployeeKey
--    between aliases to avoid duplicate pairs and self-matches.
