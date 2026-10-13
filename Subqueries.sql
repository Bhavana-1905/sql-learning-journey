-- Topic: SQL Subqueries
-- Database: SQL Server (AdventureWorksDW)
-- Tables used: DimProduct and FactInternetSales
--
-- Concept:
-- A subquery is a query written inside another SQL query.
-- The inner query provides a value or set of values to the outer query.
-- 1. Scalar subquery
-- A scalar subquery returns one value.
-- Example: Find products with the highest list price.
SELECT EnglishProductName, ListPrice
FROM DimProduct
WHERE ListPrice = (
    SELECT MAX(ListPrice)
    FROM DimProduct
);

-- Practice 1:
-- Find products whose ListPrice is greater than the overall average ListPrice.
select EnglishProductName, ListPrice
from DimProduct 
where ListPrice > (
select avg(ListPrice) from DimProduct
)
-- 2. IN subquery
-- IN checks whether a value matches any value returned by the inner query.
-- Example: Find products in subcategories that contain a product priced above 1000.
SELECT EnglishProductName, ProductSubcategoryKey, ListPrice
FROM DimProduct
WHERE ProductSubcategoryKey IN (
    SELECT ProductSubcategoryKey
    FROM DimProduct
    WHERE ListPrice > 1000
      AND ProductSubcategoryKey IS NOT NULL
);

-- Practice 2:
-- Find products whose ProductSubcategoryKey appears among products priced below 100.
-- Exclude NULL subcategory keys in the inner query.
select EnglishProductName, ProductSubcategoryKey, ListPrice
from DimProduct
where ProductSubcategoryKey in (
select ProductSubcategoryKey
from DimProduct
where ListPrice < 100 and ProductSubcategoryKey is not null
)

-- 3. NOT IN subquery
-- NOT IN checks whether a value does not match any value returned by the inner query.
-- NULLs in the inner result can make NOT IN behave unexpectedly, so exclude them.
-- Example: Find products whose subcategory is not represented by a product priced above 1000.
SELECT EnglishProductName, ProductSubcategoryKey
FROM DimProduct
WHERE ProductSubcategoryKey NOT IN (
    SELECT ProductSubcategoryKey
    FROM DimProduct
    WHERE ListPrice > 1000
      AND ProductSubcategoryKey IS NOT NULL
);

-- Practice 3:
-- Find products whose ProductSubcategoryKey is not among the keys for products priced below 100.
-- Exclude NULL subcategory keys in the inner query.
select EnglishProductName, ProductSubcategoryKey, ListPrice
from DimProduct
where ProductSubcategoryKey not in (
select ProductSubcategoryKey
from DimProduct
where ListPrice < 100 and ProductSubcategoryKey is not null
)

-- 4. Correlated subquery
-- A correlated subquery refers to a column from the outer query.
-- Here, the inner query calculates the average price for the current product's subcategory.
-- Example: Find products priced above their own subcategory's average.
SELECT p.EnglishProductName, p.ProductSubcategoryKey, p.ListPrice
FROM DimProduct AS p
WHERE p.ProductSubcategoryKey IS NOT NULL
  AND p.ListPrice > (
      SELECT AVG(p2.ListPrice)
      FROM DimProduct AS p2
      WHERE p2.ProductSubcategoryKey = p.ProductSubcategoryKey
  );

-- Practice 4:
-- Find products priced below the average ListPrice in their own subcategory.
-- Return EnglishProductName, ProductSubcategoryKey, and ListPrice.
select p.EnglishProductname, p.Productsubcategorykey, p.Listprice
from DimProduct as p
where p.ProductSubcategoryKey is not null
and p.ListPrice < (
select avg(P2.listprice)
from DimProduct as p2
where p.ProductSubcategoryKey=p2.ProductSubcategoryKey
)
-- 5. EXISTS
-- EXISTS checks whether the inner query returns at least one row.
-- Example: Find products that have at least one matching sales record.
SELECT p.EnglishProductName, p.ProductKey
FROM DimProduct AS p
WHERE EXISTS (
    SELECT 1
    FROM FactInternetSales AS f
    WHERE f.ProductKey = p.ProductKey
);

-- Practice 5:
-- Find products that have no matching sales records.
-- Hint: Use NOT EXISTS.
select p.EnglishProductName, p.ProductKey
from DimProduct as p
where not exists(
select *
from FactInternetSales as f
where f.ProductKey=p.ProductKey
)

-- 6. NOT EXISTS
-- NOT EXISTS is true when the inner query returns no matching rows.
-- Example: Find products with no matching sales records.
SELECT p.EnglishProductName, p.ProductKey
FROM DimProduct AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM FactInternetSales AS f
    WHERE f.ProductKey = p.ProductKey
);

-- Practice 6:
-- Find products that have at least one matching sales record with SalesAmount greater than 1000.
-- Return EnglishProductName and ProductKey. Use EXISTS.
select p.EnglishProductName, p.ProductKey
from DimProduct p
where exists(
select *  
from factinternetsales as f
where f.ProductKey=p.ProductKey
and f.SalesAmount>1000
)

-- 7. Subquery in the FROM clause
-- A subquery in FROM creates a derived table (a temporary result set for this query).
-- The derived table must have an alias in SQL Server.
-- Example: Calculate total sales per product, then show products with total sales above 50000.
SELECT p.EnglishProductName, sales_by_product.TotalSales
FROM DimProduct AS p
INNER JOIN (
    SELECT ProductKey, SUM(SalesAmount) AS TotalSales
    FROM FactInternetSales
    GROUP BY ProductKey
) AS sales_by_product
    ON sales_by_product.ProductKey = p.ProductKey
WHERE sales_by_product.TotalSales > 50000;

-- Practice 7:
-- Use a subquery in FROM to calculate average ListPrice for each ProductSubcategoryKey.
-- Return only subcategories whose average ListPrice is greater than 1000.
-- Return ProductSubcategoryKey and AvgListPrice.
select productsubcategorykey, avglistprice
from  (
select productsubcategorykey, avg(ListPrice) as avglistprice
from DimProduct 
group by ProductSubcategoryKey
)as D
where avglistprice>1000

-- Key takeaways:
-- Scalar subquery: returns one value.
-- IN / NOT IN: compare a value against a set of values.
-- Correlated subquery: refers to the outer query's row.
-- EXISTS / NOT EXISTS: test whether matching rows exist.
-- FROM subquery: creates a derived table that can be queried or joined.
-- A subquery is not always faster than a JOIN; choose the clearest correct approach.
