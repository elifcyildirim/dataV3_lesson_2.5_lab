-- Lab 2.5
USE SAKILA;

-- Q1 Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor
WHERE first_name= 'Scarlett';

-- Q2 How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(*) AS 'no of available films' FROM sakila.rental
WHERE NOT return_date LIKE ' '; -- alternative: WHERE return_date is not null;

SELECT COUNT(*) AS 'no of films that are currentl rented' FROM sakila.rental
WHERE return_date is null;

-- Q3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MAX(length) as 'max_duration' FROM film;
SELECT MIN(length) as 'min_duration' FROM film;

-- Q4 What's the average movie duration expressed in format (hours, minutes)?
SELECT sec_to_time((AVG(length)*60)) FROM film;

-- SELECT AVG(length) FROM film;
-- SELECT length FROM film

-- Q5 How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) FROM sakila.actor;

-- Q6 Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(payment_date), MIN(payment_date)) FROM sakila.payment; 

-- SELECT MAX(payment_date) FROM sakila.payment
-- ORDER BY payment_date ASC;

-- SELECT MIN(payment_date) FROM sakila.payment
-- ORDER BY payment_date ASC;


-- Q7 Show rental info with additional columns month and weekday. Get 20 results. (weekday?)
SELECT *, date_format(CONVERT(left(rental_date,10),DATE), '%M') AS 'rental_month', 
	      date_format(CONVERT(left(rental_date,10),DATE), '%D') AS 'rental_day',
		  DAYNAME(rental_date) as 'weekday'
FROM sakila.rental
LIMIT 20;

-- useful:
-- WEEKDAY(rental_date) as 'weekday',
-- DAYOFWEEK(rental_date) as 'day of the week',

-- Q8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE
WHEN weekday(rental_date) = 5 OR weekday(rental_date) = 6 then 'weekend'
ELSE 'workday'
END AS 'day_type'
FROM sakila.rental;

-- Q9 Get release years.
SELECT release_year FROM sakila.film;

-- Q10 Get all films with ARMAGEDDON in the title. ANSWER
SELECT * 
FROM sakila.film
WHERE title LIKE ('%ARMAGEDDON%');

-- Q11 Get all films which title ends with APOLLO.
SELECT * 
FROM sakila.film
WHERE right(title,6) in ('APOLLO');

-- Q12 Get 10 the longest films.
SELECT * FROM film
ORDER BY length DESC
LIMIT 10;

-- Q13 How many films include Behind the Scenes content?
SELECT COUNT(*) FROM film
WHERE special_features LIKE '%BEHIND THE SCENES%';