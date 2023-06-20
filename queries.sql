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
GROUP BY work_performed, health

--


