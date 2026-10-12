-- Topic: FULL OUTER JOIN
-- FULL OUTER JOIN returns all matching rows from both tables.
-- It also returns unmatched rows from both tables.
-- Missing values from the opposite table appear as NULL.

-- Syntax:
-- SELECT columns
-- FROM TableA
-- FULL OUTER JOIN TableB
--     ON TableA.common_column = TableB.common_column;

-- Example 1: Display all products and their sales.
-- Includes products with no sales and sales records without a matching product.
SELECT d.ProductKey, d.EnglishProductName, f.SalesOrderNumber, f.SalesAmount
FROM DimProduct AS d
FULL OUTER JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey;

-- Example 2: Find unmatched rows from either table.
-- NULL in the sales table means a product has no matching sales.
-- NULL in the product table means a sales record has no matching product.
SELECT d.ProductKey, d.EnglishProductName, f.ProductKey AS SalesProductKey, f.SalesOrderNumber, f.SalesAmount
FROM DimProduct AS d
FULL OUTER JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
WHERE d.ProductKey IS NULL OR f.ProductKey IS NULL;

-- Example 3: Find products that have no matching sales.
SELECT d.ProductKey, d.EnglishProductName
FROM DimProduct AS d
FULL OUTER JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
WHERE f.ProductKey IS NULL;

-- Example 4: Find sales records without a matching product.
SELECT f.ProductKey, f.SalesOrderNumber, f.SalesAmount
FROM DimProduct AS d
FULL OUTER JOIN FactInternetSales AS f
    ON d.ProductKey = f.ProductKey
WHERE d.ProductKey IS NULL;

-- Key takeaways:
-- FULL OUTER JOIN keeps unmatched rows from both tables.
-- LEFT JOIN keeps all rows from the left table.
-- RIGHT JOIN keeps all rows from the right table.
-- ON defines how rows match; WHERE filters the result.