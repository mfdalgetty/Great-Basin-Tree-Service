-- See sales made by each employee 

SELECT SUM(sales_price), employee_id
FROM appointment
GROUP BY employee_id;

-- Calculate sales price per quarter

SELECT SUM(sales_price), quarter, year
FROM quarterly_sales q
JOIN appointment a ON a.appointment_id = q.appointment_id
GROUP BY year, quarter
ORDER BY year, quarter;

-- Observe what the most popular tree treatment is by quarter

SELECT COUNT(work_performed), work_performed, quarter, year
FROM appointment a
JOIN quarterly_sales q ON q.appointment_id = a.appointment_id
GROUP BY work_performed, year, quarter
ORDER BY year, quarter;

-- Observe what the most common work type is on healthy trees

SELECT COUNT(work_performed), work_performed, health FROM tree
WHERE health = 'Healthy'
GROUP BY work_performed, health;

-- Select the top 3 tree species worked on the most

SELECT tree_species, COUNT(*) AS appointment_count
FROM tree t
JOIN appointment a ON t.date = a.date
GROUP BY tree_species
ORDER BY appointment_count DESC
LIMIT 3;

-- Select trees that have been removed

SELECT *
FROM appointment
WHERE work_performed ILIKE '%removal%';

-- Calculate the average product cost and quantity for each product and company

SELECT company_name, product_name, AVG(product_cost)::money AS avg_Cost, ROUND(AVG(quantity),2) AS avg_quantity
FROM inventory
GROUP BY company_name, product_name;

-- Display the top 5 employees who have traveled the most to perform work for customers

SELECT e.employee_id, e.employee_name, SUM(a.distance) AS total_distance
FROM employee e
JOIN appointment a ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY total_distance DESC
LIMIT 5;

