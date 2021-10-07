-- Create table for our Presidents/Customer
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	Last_name VARCHAR(100),
	email VARCHAR(100),
	address VARCHAR(100),
	cust_state VARCHAR(2),
	zipcode VARCHAR(5)
);

SELECT * FROM customer

ALTER TABLE customer
	ALTER COLUMN zipcode TYPE INTEGER USING zipcode::integer;
	
ALTER TABLE customer
ADD COLUMN city VARCHAR(100);
	
--Create Orders Table for Presidents
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	amount NUMERIC(5,2),
	cust_id INTEGER,
	FOREIGN KEY(cust_id) REFERENCES customer(customer_id)
);

SELECT * FROM order_

-- Insert Data into our Database
INSERT INTO customer(
	customer_id,
	first_name,
	last_name,
	email,
	address,
	city,
	cust_state,
	zipcode
) VALUES(
	1,
	'George',
	'Washington',
	'gwash@usa.gov',
	'3200 Mt. Vernon Hwy',
	'Mt. Vernon',
	'VA',
	22121
);

INSERT INTO customer(first_name, last_name, email, address, city, cust_state, zipcode)
VALUES('John', 'Adams', 'jadams@usa.gov', '1200 Hancock Rd', 'Quincy', 'MA', '03242');

INSERT INTO customer(first_name, last_name, email, address, city, cust_state, zipcode)
VALUES('Thomas', 'Jefferson', 'tjeff@america.com', '123 Monticello Ave', 'Monticello', 'VA', '28463'),
('James', 'Madison', 'jmad@president.com', '1350 Congress Pkwy', 'Arlington', 'VA', '32554'),
('James', 'Monroe', 'jmonroe@usa.gov', '2050 Monroe Dr', 'Charlottesville', 'VA', '21314');

SELECT * FROM customer

ALTER TABLE customer
ALTER COLUMN zipcode  TYPE VARCHAR(5);

UPDATE customer
SET zipcode = '03242'
WHERE customer_id = 2;

--Insert data for Order Table
Insert INTO order_(amount, cust_id)
VALUES(99.99, 1),
(75.43, 1),
(123.45, 3),
(55.55, 4),
(100.00, NULL);

SELECT * FROM order_;

SELECT * FROM customer;

SELECT * 
FROM customer 
JOIN order_ --Join is just for returned data comparison. Doesnt create new tables, or Database
ON customer.customer_id = order_.cust_id;

-- Inner Join with GROUP BY
SELECT customer_id, first_name, last_name, SUM(amount) AS total_spent
FROM customer
JOIN order_
ON customer.customer_id = order_.cust_id
GROUP BY customer_id
ORDER BY total_spent DESC;


-- Inner Join with Alias
-- """"""""""""""""""??



-- Inner Join
--SELECT order_id, customer.customer_id, first_name, last_name, email, amount
--FROM order_
--JOIN customer
--ON customer.customer_id = order_.customer_id;


-- Left Join
--SELECT order_id, customer.customer_id, first_name, last_name, email, amount
--FROM order_ -- Left Table
--LEFT JOIN customer -- Right Table
--ON customer.customer_id = order_.customer_id;



-- RIGHT Join
--SELECT *
--FROM order_ -- Left Table
--RIGHT JOIN customer -- Right Table
--ON customer.customer_id = order_.customer_id;

-- RIGHT Join
--SELECT *
--FROM customer -- Left Table
--RIGHT JOIN order_ -- Right Table
--ON customer.customer_id = order_.customer_id;



