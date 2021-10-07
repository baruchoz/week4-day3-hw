-- Question 1
SELECT first_name, last_name, district
FROM customer
JOIN address 
ON customer.address_id = address. address_id
WHERE address.district = 'Texas'

-- Question 2
SELECT customer.first_name, customer.last_name, payment.amount
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99

-- Question 3

SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- Question 4

SELECT * 
FROM city
WHERE country_id = 66

SELECT address_id
FROM address
JOIN city
ON address.city_id = city.city_id
WHERE city.country_id = 66

SELECT first_name, last_name
FROM customer
WHERE customer.address_id IN(
	SELECT address_id
	FROM address
	JOIN city
	ON address.city_id = city.city_id
	WHERE city.country_id = 66
);

-- Question 5

SELECT first_name, last_name, COUNT(payment.amount)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY  first_name, last_name
ORDER BY 2 DESC 
LIMIT 1

-- Question 6

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


-- Question 7






-- Question 8





