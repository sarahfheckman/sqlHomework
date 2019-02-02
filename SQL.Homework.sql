USE sakila;

-- 1a
SELECT first_name, last_name from actor;

-- 1b
SELECT concat(first_name, ' ', last_name) "Actor Name" from actor;

-- 2a
SELECT * FROM actor WHERE first_name = "Joe";

-- 2b
SELECT * FROM actor WHERE last_name LIKE "%GEN%";

-- 2c
SELECT last_name, first_name FROM actor WHERE last_name LIKE "%LI%";

-- 2d
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor ADD COLUMN `Describe` BLOB;

-- 3b
ALTER TABLE actor DROP COLUMN `Describe`;

-- 4a
SELECT last_name "Last Name", COUNT(*) "Count" FROM actor
WHERE last_name is not null
GROUP BY last_name;

-- 4b
SELECT last_name "Last Name", COUNT(*) "Count" FROM actor
WHERE last_name is not null
GROUP BY last_name
HAVING COUNT(*) >= 2;

-- 4c
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = "HARPO"
WHERE last_name = "WILLIAMS" AND first_name = "GROUCHO";

-- 4d
SET SQL_SAFE_UPDATES = 0;
UPDATE actor
SET first_name = "GROUCHO"
WHERE last_name = "WILLIAMS" AND first_name = "HARPO";

-- 5a
DROP TABLE IF EXISTS address;
CREATE TABLE address (
address_id INT NOT NULL,
address VARCHAR(50),
address2 VARCHAR(50),
district VARCHAR(20),
city_id INT,
postal_code VARCHAR(10),
phone VARCHAR(20),
location GEOMETRY,
last_update TIMESTAMP,
primary key (address_id)
);

-- 6a
SELECT staff.last_name, staff.first_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;

-- 6b
SELECT staff.last_name, staff.first_name, SUM(payment.amount) "Total Rung Up"
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE "2005-04-%";

-- 6c
SELECT film.title, COUNT(film_actor.actor_id) "Number of Actors"
FROM film
INNER JOIN film_actor ON
film.film_id = film_actor.film_id
GROUP BY film.title;

-- 6d
SELECT film.title, COUNT(inventory.inventory_id) "Number of Copies in Inventory"
FROM film
INNER JOIN inventory ON
film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";

-- 6e
SELECT customer.last_name, customer.first_name, SUM(payment.amount) "Total Paid"
FROM customer
INNER JOIN payment ON
customer.customer_id = payment.customer_id
GROUP BY last_name;

-- 7a
SELECT title
FROM film
WHERE title LIKE "K%" OR title LIKE "Q%";

-- 7b
SELECT first_name, last_name
	FROM actor
	WHERE actor_id
	IN (
		SELECT actor_id
        FROM film_actor
        WHERE film_id
        IN (
			SELECT film_id
            FROM film
            WHERE title = "Alone Trip"
		)
);

-- 7c
SELECT customer.first_name, customer.last_name, customer.email 
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country = "Canada";

-- 7d
SELECT title
	FROM film 
	WHERE film_id
    IN (
		SELECT film_id
        FROM film_category
        WHERE category_id
        IN (
			SELECT category_id
            FROM category
            WHERE `name` = "Family"
            )
		);
        
-- 7e
SELECT film.title "Most Popular", COUNT(film.title) "Times Rented"
FROM film
INNER JOIN inventory ON
film.film_id = inventory.film_id
INNER JOIN rental ON 
inventory.inventory_id = rental.inventory_id
GROUP BY title
ORDER BY "Times Rented" DESC;

-- 7F
SELECT store.store_id "Store", SUM(payment.amount) "Gross Revenue"
FROM store
INNER JOIN store ON 
store.store_id = customer.store_id
INNER JOIN customer ON
customer.customer_id = payment.payment_id
GROUP BY store_id;

-- 7G
SELECT country
	FROM country
	WHERE country_id
    IN (
		SELECT country_id
        FROM city
        WHERE city_id
        IN (
			SELECT city_id
            FROM address
            WHERE address_id
				IN(
					SELECT address_id
                    FROM store
                    WHERE store_id
                    )
				)
	
		);
        
-- 7h

        