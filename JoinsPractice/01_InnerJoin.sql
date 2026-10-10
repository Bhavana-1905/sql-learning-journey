-- ==========================================
-- TOPIC: INNER JOIN
-- DATABASE: SQL Server - AdventureWorksDW
-- ==========================================

-- CONCEPT:
-- A JOIN is used to combine related data from two or more tables.
-- In a database, information is often stored in separate tables.
-- For example, DimProduct stores product details, while
-- FactInternetSales stores sales transaction details.

-- WHAT IS INNER JOIN?
-- INNER JOIN returns only the rows that have matching values
-- in both tables, based on the specified join condition.
-- Rows without a match are excluded from the result.

-- WHY DO WE USE INNER JOIN?
-- We use INNER JOIN when we need related information from
-- different tables, such as product names with their sales details.

-- HOW DOES IT WORK?
-- ProductKey is the common column in DimProduct and FactInternetSales.
-- SQL Server compares ProductKey values in both tables.
-- When the values match, the related columns appear in the result.
-- A product with multiple sales records can appear multiple times.

-- SYNTAX:
-- SELECT columns
-- FROM Table1 AS t1
-- INNER JOIN Table2 AS t2
--     ON t1.CommonColumn = t2.CommonColumn;

-- Note: In SQL Server, JOIN alone means INNER JOIN.

-- EXAMPLE 1: Display sales order numbers with product names.
SELECT f.SalesOrderNumber, d.EnglishProductName
FROM FactInternetSales AS f
INNER JOIN DimProduct AS d
    ON f.ProductKey = d.ProductKey;

-- EXAMPLE 2: Display sales records where SalesAmount is greater than 1000.
-- ORDER BY sorts the results from highest to lowest sales amount.
SELECT f.SalesOrderNumber, d.EnglishProductName, f.OrderQuantity, f.SalesAmount
FROM FactInternetSales AS f
INNER JOIN DimProduct AS d
    ON f.ProductKey = d.ProductKey
WHERE f.SalesAmount > 1000
ORDER BY f.SalesAmount DESC;

-- EXAMPLE 3: Calculate total sales for each product.
-- SUM() adds sales amounts, and GROUP BY groups rows by product name.
SELECT d.EnglishProductName, SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales AS f
INNER JOIN DimProduct AS d
    ON f.ProductKey = d.ProductKey
GROUP BY d.EnglishProductName
ORDER BY TotalSales DESC;

-- EXAMPLE 4: Display products whose total sales exceed 50000.
-- HAVING filters groups after the totals have been calculated.
SELECT d.EnglishProductName, SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales AS f
INNER JOIN DimProduct AS d
    ON f.ProductKey = d.ProductKey
GROUP BY d.EnglishProductName
HAVING SUM(f.SalesAmount) > 50000
ORDER BY TotalSales DESC;

-- EXAMPLE 5: Filter individual sales first, then filter product totals.
-- WHERE filters individual rows; HAVING filters grouped results.
SELECT d.EnglishProductName, SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales AS f
INNER JOIN DimProduct AS d
    ON f.ProductKey = d.ProductKey
WHERE f.SalesAmount > 1000
GROUP BY d.EnglishProductName
HAVING SUM(f.SalesAmount) > 50000
ORDER BY TotalSales DESC;

-- KEY TAKEAWAYS:
-- 1. INNER JOIN returns only matching rows.
-- 2. ON specifies how the tables are related.
-- 3. Table aliases make queries shorter and easier to read.
-- 4. Use WHERE to filter rows and HAVING to filter groups.
-- 5. Use INNER JOIN when matching records from both tables are required.
