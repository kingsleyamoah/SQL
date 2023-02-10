-- create a stored procedure to return invoices for customer names  
-- with a balance > 0
USE sql_invoicing

 DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance() 
BEGIN
	SELECT invoice_id, client_id,
	invoice_total - payment_total AS balance
	FROM invoices 
	WHERE invoice_total - payment_total
	GROUP BY invoice_id, client_id;
END $$

DELIMITER ;

-- Stored Procedure that returns all clients by state 
DELIMITER $$
CREATE PROCEDURE get_clients_by_state(
state CHAR(2)
) 
BEGIN 

	SELECT * 
	FROM clients c
	WHERE c.state = state; 
END$$

DELIMITER ; 

-- Creating a stored procedure to calculate Risk factor: 
DELIMITER $$
CREATE PROCEDURE get_risk_factor() 
BEGIN 
     DECLARE risk_factor DECIMAL(9,2) DEFAULT 0; 
     DECLARE invoices_total DECIMAL(9,2);
     DECLARE invoices_count INT; 

     SELECT COUNT(*), SUM(invoice_total) 
     INTO invoices_count, invoices_total 
     FROM invoices; 

-- formula for calculating risk factor is invoices total / number of invoices * 5
     SET risk_factor = invoices_total / invoices_count * 5; 
  
     SELECT risk_factor; 
END$$get_invoices_by_client

DELIMITER ; 