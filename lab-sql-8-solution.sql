use sakila;

## 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select * from film;
select title, length,
row_number() over(order by length) as "rank"
from film
where length is not null and length > 0;

## 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
## In your output, only select the columns title, length, rating and rank.
select * from film;
select title, length, rating,
row_number() over(partition by rating order by length desc) as "rank"
from film
where length is not null and length > 0;

## 3. How many films are there for each of the categories in the category table? 
## Hint: Use appropriate join between the tables "category" and "film_category".
select * from film_category; ## category_id, film_id
select * from category; ## category_id
select category_id, count(f.film_id) as "films"
from film_category f
join category c using (category_id)
group by category_id;

## 4. Which actor has appeared in the most films?
## Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears
select * from film_actor; ## actor_id
select * from actor; ## actor_id, first_name, last_name
select a.actor_id, a.first_name, a.last_name, count(f.film_id) as films
from actor a
join film_actor f on a.actor_id = f.actor_id
group by a.actor_id
order by films desc
limit 1;

## 5. Which is the most active customer (the customer that has rented the most number of films)? 
## Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select * from customer; ## customer_id, first_name, last_name
select * from rental; ## rental_id, customer_id
select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as times_rented
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id
order by times_rented desc
limit 1;

## 6. Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
## This query might require using more than one join statement. Give it a try. 
## We will talk about queries with multiple join statements later in the lessons.
## Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
select * from film; ## f.film_id, f.title
select * from inventory; ## i.film_id, i.invetory_id
select * from rental; ## r.rental_id, r.inventory_id

select f.title, count(r.rental_id) as times_rented
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.title
order by times_rented desc
limit 1;
