-- ============================================
-- Topic: LEFT JOIN
-- Database: AdventureWorksDW
-- Tables: DimProduct and FactInternetSales
-- ============================================

-- CONCEPT:
-- LEFT JOIN returns every row from the left table
-- and matching rows from the right table.
-- If no matching row exists, right-table columns return NULL.

-- SYNTAX:
-- SELECT columns
-- FROM LeftTable AS l
-- LEFT JOIN RightTable AS r
--     ON l.CommonColumn = r.CommonColumn;

-- EXAMPLE 1: Display products and their sales amounts.
-- Products without sales are also included.

SELECT d.ProductKey, d.EnglishProductName, f.SalesAmount
FROM DimProduct AS d
LEFT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey;


-- EXAMPLE 2: Find products with no matching sales records.
-- The NULL check identifies products with no matching row.

SELECT d.ProductKey, d.EnglishProductName
FROM DimProduct AS d
LEFT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
WHERE f.ProductKey IS NULL;


-- EXAMPLE 3: Calculate total sales for each product.
-- ISNULL displays 0 when a product has no sales.

SELECT d.ProductKey, d.EnglishProductName,
       ISNULL(SUM(f.SalesAmount), 0) AS TotalSales
FROM DimProduct AS d
LEFT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
GROUP BY d.ProductKey, d.EnglishProductName;


-- EXAMPLE 4: Display products with total sales above 50000.
-- HAVING filters groups after aggregation.

SELECT d.ProductKey, d.EnglishProductName,
       SUM(f.SalesAmount) AS TotalSales
FROM DimProduct AS d
LEFT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
GROUP BY d.ProductKey, d.EnglishProductName
HAVING SUM(f.SalesAmount) > 50000;


-- EXAMPLE 5: Count sales records for every product.
-- COUNT(f.ProductKey) returns 0 when no match exists.
-- This counts sales rows, not necessarily unique orders.

SELECT d.ProductKey, d.EnglishProductName,
       COUNT(f.ProductKey) AS TotalSalesRecords
FROM DimProduct AS d
LEFT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
GROUP BY d.ProductKey, d.EnglishProductName;


-- EXAMPLE 6: Count sales records above 1000 for every product.
-- The condition is in ON so all products are preserved.
-- Products without qualifying sales receive a count of 0.

SELECT d.ProductKey, d.EnglishProductName,
       COUNT(f.SalesAmount) AS QualifyingSalesRecords
FROM DimProduct AS d
LEFT JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
    AND f.SalesAmount > 1000
GROUP BY d.ProductKey, d.EnglishProductName;


-- IMPORTANT TAKEAWAYS:
-- 1. LEFT JOIN preserves all rows from the left table.
-- 2. Unmatched right-table columns contain NULL.
-- 3. WHERE f.ProductKey IS NULL finds products with no matching sales.
-- 4. COUNT(f.ProductKey) counts matching sales rows.
-- 5. ISNULL(SUM(...), 0) displays 0 instead of NULL.
-- 6. HAVING filters aggregated results.
-- 7. A filter in ON controls which right-table rows can match.
-- 8. A WHERE filter on right-table columns can remove unmatched rows.
