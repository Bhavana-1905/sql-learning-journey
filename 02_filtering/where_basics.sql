-- Employees with salary greater than 60000
SELECT *
FROM employees
WHERE salary > 60000;

SELECT *
FROM employees
where department='IT';

select *
FROM employees
where city='Chennai';

select *
from employees
where salary BETWEEN 50000 and 70000