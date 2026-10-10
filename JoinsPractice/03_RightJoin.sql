-- ============================================
-- Topic: RIGHT JOIN
-- Database: AdventureWorksDW
-- Tables: DimProduct and FactInternetSales
-- ============================================

-- CONCEPT:
-- RIGHT JOIN returns every row from the right table
-- and matching rows from the left table.
-- If no matching row exists, left-table columns return NULL.

-- SYNTAX:
-- SELECT columns
-- FROM LeftTable AS l
-- RIGHT JOIN RightTable AS r
--     ON l.CommonColumn = r.CommonColumn;


-- EXAMPLE 1: Display sales records and product names.
-- All rows from FactInternetSales are preserved.

SELECT f.ProductKey, d.EnglishProductName, f.SalesAmount
FROM DimProduct AS d
RIGHT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey;


-- EXAMPLE 2: Count sales records for each product.
-- Every sales row is preserved by the RIGHT JOIN.

SELECT d.ProductKey, d.EnglishProductName,
       COUNT(f.ProductKey) AS TotalSalesRecords
FROM DimProduct AS d
RIGHT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
GROUP BY d.ProductKey, d.EnglishProductName;


-- EXAMPLE 3: Calculate total sales for each product
-- represented in FactInternetSales.

SELECT d.ProductKey, d.EnglishProductName,
       SUM(f.SalesAmount) AS TotalSales
FROM DimProduct AS d
RIGHT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
GROUP BY d.ProductKey, d.EnglishProductName;


-- EXAMPLE 4: Display sales records with sales above 1000.
-- WHERE filters the final result.

SELECT f.SalesOrderNumber, d.EnglishProductName, f.SalesAmount
FROM DimProduct AS d
RIGHT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
WHERE f.SalesAmount > 1000;


-- EXAMPLE 5: Find sales records without a matching product.
-- This returns rows only if a sales record's ProductKey
-- has no matching ProductKey in DimProduct.

SELECT f.ProductKey, f.SalesOrderNumber, f.SalesAmount
FROM DimProduct AS d
RIGHT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
WHERE d.ProductKey IS NULL;


-- IMPORTANT TAKEAWAYS:
-- 1. RIGHT JOIN preserves all rows from the right table.
-- 2. Matching rows from the left table are included.
-- 3. Unmatched left-table columns return NULL.
-- 4. WHERE can filter out rows preserved by the join.
-- 5. RIGHT JOIN can often be rewritten as LEFT JOIN
--    by reversing the order of the tables.
