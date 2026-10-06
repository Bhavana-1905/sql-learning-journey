-- SQL Server String Concatenation Practice
-- Table: DimEmployee
--
-- Topics:
-- 1. String concatenation using +
-- 2. SPACE()
-- 3. CONCAT()
-- 4. CONCAT_WS()
-- 5. SELECT INTO
-- 6. ALTER TABLE
-- 7. UPDATE


-- 1. Retrieve employee name columns
-- SELECT is used to retrieve data from a table.
-- Here we retrieve the employee key and name-related columns.

SELECT EmployeeKey, FirstName, MiddleName, LastName
FROM DimEmployee;


-- 2. Combine FirstName and LastName using +
-- The + operator can be used to concatenate strings.
-- ' ' adds one space between FirstName and LastName.
--
-- Example:
-- John + ' ' + Smith
-- Result: John Smith

SELECT FirstName + ' ' + LastName AS FullName
FROM DimEmployee;


-- 3. Using SPACE() with +
-- SPACE(n) returns n number of spaces.
-- SPACE(5) adds five spaces between FirstName and LastName.

SELECT FirstName + SPACE(5) + LastName AS FullName
FROM DimEmployee;


-- 4. Combine FirstName, MiddleName and LastName using +
-- SPACE(3) adds three spaces between each name part.
--
-- Example:
-- John + three spaces + David + three spaces + Smith

SELECT FirstName + SPACE(3) + MiddleName + SPACE(3) + LastName AS FullName
FROM DimEmployee;


-- 5. Retrieve the original name columns
-- This retrieves the original employee information.

SELECT EmployeeKey, FirstName, MiddleName, LastName
FROM DimEmployee;


-- 6. CONCAT()
-- CONCAT() combines multiple values into one string.
-- SPACE(1) adds one space between each name part.
--
-- Syntax:
-- CONCAT(value1, value2, value3, ...)

SELECT CONCAT(FirstName, SPACE(1), MiddleName, SPACE(1), LastName) AS FullName
FROM DimEmployee;


-- 7. CONCAT_WS() with a space separator
-- CONCAT_WS() means "CONCATENATE WITH SEPARATOR".
-- The first argument is the separator.
-- SPACE(1) means one space is placed between the values.
--
-- Syntax:
-- CONCAT_WS(separator, value1, value2, value3, ...)

SELECT CONCAT_WS(SPACE(1), FirstName, MiddleName, LastName) AS FullName
FROM DimEmployee;


-- 8. CONCAT_WS() with a hyphen separator
-- Here '-' is used as the separator.
--
-- Example:
-- John-David-Smith

SELECT CONCAT_WS('-', FirstName, MiddleName, LastName) AS FullName
FROM DimEmployee;


-- 9. Retrieve employee details with FullName
-- We can retrieve the original columns and create a
-- calculated FullName column at the same time.
-- AS FullName gives the calculated column a meaningful name.

SELECT EmployeeKey, FirstName, MiddleName, LastName,
       CONCAT_WS(SPACE(1), FirstName, MiddleName, LastName) AS FullName
FROM DimEmployee;


-- 10. Create a new table using SELECT INTO
-- SELECT INTO creates a new table and copies the selected
-- columns and their data into it.
--
-- Source table: DimEmployee
-- New table: EmpBk

SELECT EmployeeKey, FirstName, MiddleName, LastName
INTO EmpBk
FROM DimEmployee;


-- 11. Add a new column using ALTER TABLE
-- ALTER TABLE changes the structure of an existing table.
-- Here we add a new column called FullName.
-- VARCHAR(50) allows up to 50 characters.

ALTER TABLE EmpBk
ADD FullName VARCHAR(50);


-- 12. Update the FullName column
-- UPDATE modifies existing rows in a table.
-- Here we populate FullName using CONCAT_WS().
-- One space is used as the separator between the names.

UPDATE EmpBk
SET FullName = CONCAT_WS(SPACE(1), FirstName, MiddleName, LastName);


-- 13. View the final table
-- SELECT * retrieves all columns and all rows from EmpBk.
-- This allows us to see the newly created FullName column.

SELECT *
FROM EmpBk;