-- Question 1:
-- Display all columns from the employees table 
select *
from employees;
-- The * symbol displays all columns.

--Question 2:
--Display only employee name and salary
select name, salary
from employees;
--Question 3:
--Display employee name, department, city
select name, department, city
from employees;
--SELECT chooses the specific columns we want to display
--FROM specifies the table from which data is retrieved

--Question 4:
--Display employee name with a custom column name
select name as emp_name
from employees;
--AS creates an alias as temporary display name
