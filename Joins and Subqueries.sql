-- Grouping data by State and city: 
SELECT state, city, 
   SUM(invoice_total) AS total_sales 
  FROM invoices i 
  JOIN clients c USING (client_id)  
  GROUP BY state, city; 


-- write a query to display the payment date, payment method 
-- and the total payment for transactions made. 
SELECT p.date, pm.name as payment_method, 
SUM(amount) AS total_payments 
FROM payments p 
JOIN payment_methods pm 
ON p.payment_id = pm.payment_method_id 
GROUP BY date, payment_method  
ORDER BY date; 


-- write a query to get the customers located in Virginia 
-- who have spent more than $100 
SELECT c.customer_id, c.first_name, c.last_name, 
SUM(oi.quantity * oi.unit_price) AS total_sales 
FROM customers c 
JOIN orders o USING (customer_id) 
JOIN order_items oi USING (order_id) 
WHERE state = 'VA' 
GROUP BY c.customer_id, c.first_name, c.last_name 
HAVING total_sales > 100; 


-- SUBQUERIES 
-- Write a query that finds the products that are more expensive than Lettuce (id = 3) 
select * 
from products 
where unit_price > (
	SELECT unit_price 
    FROM products
    WHERE product_id=3
    );


  -- Write a query that finds employees who earns more than average: 

use sql_hr;

SELECT * 
FROM employees
WHERE salary > (
	SELECT avg(salary)
    FROM employees
    );
    
-- Write a query using the sql_store database and find all products 
-- that have never been ordered: 

USE sql_store; 
SELECT * 
FROM products 
WHERE product_id NOT IN (
SELECT DISTINCT product_id 
from order_items
) 
; 

-- using the sql_store database, write a query that finds customers 
-- who have ordered lettuce (id = 3)
-- Select customer_id, first_name, last_name 
SELECT * 
FROM customers 
WHERE customer_id IN ( 
	SELECT o.customer_id
    FROM order_items oi
    JOIN orders o USING(order_id)
    WHERE product_id = 3
    )