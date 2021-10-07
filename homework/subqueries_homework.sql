-- Question 1. List all customers who live in Texas (use JOINs)
SELECT customer_id, first_name, last_name, district
FROM customer
JOIN address 
ON customer.address_id = address. address_id
WHERE address.district = 'Texas';
-- Answer: 5 people live in Texas


-- Question 2. Get all payments above $6.99 with the Customer’s full name

-- Can concat with    CONCAT(first_name, ' ', last_name) AS full_name
SELECT customer.first_name, customer.last_name, payment.amount
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99;
--Answer: 1406 rows


-- Question 3. Show all customer names who have made payments over $175 (use subqueries)

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);
--Answer: 6 customers made payments over $175

-- Question 4. List all customers that live in Nepal (use the city table)

SELECT first_name, last_name
FROM customer
WHERE customer.address_id IN(
	SELECT address_id
	FROM address
	JOIN city
	ON address.city_id = city.city_id
	WHERE city.country_id = 66
);

SELECT *
FROM customer
WHERE address_id = (
	SELECT address_id
	FROM address
	WHERE city_id = (
		SELECT city_id
		FROM city
		WHERE country_id = (
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
);
-- Answer is Kevin Schuler 


-- Question 5. Which staff member had the most transactions?

SELECT first_name, last_name, COUNT(payment.amount)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY  first_name, last_name
ORDER BY COUNT(*) DESC 
LIMIT 1;

SELECT staff.staff_id, first_name, last_name, COUNT(*)
FROM payment
JOin staff
On staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(*) DESC;

-- Answer: John Stephens

-- Question 6. What film had the most actors in it?

-- My solution
SELECT film.title, actor_id
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IN (
	SELECT film_actor.actor_id 
	FROM film_actor
	JOIN actor
	ON film_actor.actor_id = actor.actor_id
	GROUP BY film.title, film_actor.actor_id
	ORDER BY film_actor.actor_id
);

SELECT film.title, film_actor.film_id, actor.actor_id 
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id 
JOIN actor
ON actor.actor_id = film_actor.actor_id
ORDER BY film_id;

--Couldnt get anything to work but these were my two thought processes ^

-- Brian Solution
SELECT f.film_id, f.title, f.description, COUNT(*) AS number_of_actors
FROM film_actor AS f_a
JOIN film AS f
ON f_a.film_id = f.film_id
GROUP BY f.film_id
ORDER BY number_of_actors DESC
LIMIT 1;
-- Answer: Lambs Cincinatti with 15 actors


-- Question 7. Which actor has been in the least movies?

SELECT a_.actor_id, a_.first_name, a_.last_name, COUNT(*) as number_of_films
FROM film_actor AS f_a
JOIN actor AS a_
ON f_a.actor_id = a_.actor_id
GROUP BY a_.actor_id
ORDER BY number_of_films
LIMIT 1;

-- Answer: Emily Dee with 14 films

-- Question 8. How many districts have more than 5 customers in it?

SELECT district, COUNT(*)
FROM address
GROUP BY district
HAVING COUNT(*) > 5;

-- Answer: 9 Districts




