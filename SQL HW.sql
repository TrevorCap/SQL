/* Make sure we are using Sakila */
use sakila;

/* 1a */
select first_name as 'First Name', last_name as 'Last Name' 
from actor ;

/* 1b */
select concat(first_name, ' ', last_name) as 'Actor Name'
from actor;

/* 2a */
select * from actor
where first_name = 'JOE';

/* 2b */
select * from actor
where last_name Like '%GEN%';

/* 2c */
select * from actor
where last_name Like '%LI%'
order by last_name asc, first_name asc;

/* 2d */
select country_id as 'Country ID', country as 'Country'
from country
where country IN ('Afghanistan', 'Bangladesh', 'China');

/* 3a */
alter table actor
add column description blob;

/* 3b */
alter table actor
drop column description;

/* 4a */
select last_name as 'Last Name', count(last_name) as '# of Occurences'
from actor
group by last_name 
order by last_name asc;

/* 4b */
select last_name as 'Last Name', count(last_name) as '# of Occurences'
from actor
group by last_name
having count(last_name) >1;

/* Determines actor id to replace*/
select actor_id from actor
where first_name = 'GROUCHO' AND last_name = 'williams';
/*Realized there was a better way to do this, leaving in the code for posterity*/

/* 4c */
update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' AND last_name = 'williams';

/* 4d */
update actor
set first_name = 'GROUCHO'
where first_name = 'HARPO' AND last_name = 'williams';

/* 5a */
describe address;

/* 6a */
select s.first_name as 'First', s.last_name as 'Last', a.address as 'Address'
from staff s
left join address a on (s.address_id = a.address_id);

/* 6b */
SELECT payment.staff_id as 'Staff ID', staff.first_name as 'First', staff.last_name as 'Last', sum(payment.amount) as 'Total Processed'
FROM staff 
INNER JOIN payment 
ON staff.staff_id = payment.staff_id AND payment_date LIKE '2005-08%'
group by payment.staff_id;

/* 6c */
select f.title as 'Title', count(a.actor_id) as 'Number of Actors'
from film f
inner join film_actor a
on f.film_id = a.film_id
group by f.title;

/* 6d */
select count(i.inventory_id) as 'Count of Copies', f.title as 'Title'
from inventory i 
inner join film f 
on i.film_id = f.film_id
group by(f.title)
having f.title = 'Hunchback Impossible';

/* 6e */
select c.first_name as 'First', c.last_name as 'Last', sum(p.amount) as 'Total Paid'
from payment p 
inner join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by c.last_name;

/* 7a */
select title
from film f
inner join language l
on l.language_id = f.language_id
where f.title like 'K%' and l.name = 'English' or f.title like 'Q%' and l.name = 'English'
order by title;

/* 7b */
select a.first_name as 'First', a.last_name as 'Last'
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film f
on f.film_id = fa.film_id
where f.title = 'Alone Trip'
order by a.last_name;

select * from actor;

/* 7c */
select c.first_name as 'First', c.last_name as 'Last', c.email as 'Email Address'
from customer c
join address a 
on c.address_id = a.address_id
join city e
on e.city_id = a.city_id
join country z
on e.country_id = z.country_id
where z.country = 'Canada'
order by c.last_name;

/* 7d */
select f.title as 'Family-Friendly Films'
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on c.category_id = fc.category_id
where c.name = 'Family'
order by f.title;

/* 7e */
SELECT f.title as 'Title', COUNT(rental_id) AS 'Rentals'
FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY `Rentals` DESC;

/* 7f */
SELECT s.store_id as 'Store ID', SUM(amount) AS 'Rental Revenue'
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
JOIN inventory i
ON i.inventory_id = r.inventory_id
JOIN store s
ON s.store_id = i.store_id
GROUP BY s.store_id;

/* 7g */
SELECT s.store_id as 'Store ID', c.city as 'City', e.country as 'Country'
FROM store s
JOIN address a 
ON s.address_id = a.address_id
JOIN city c
ON c.city_id = a.city_id
JOIN country e
ON e.country_id = c.country_id;

/* 7h */
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc 
ON c.category_id=fc.category_id
JOIN inventory i 
ON fc.film_id=i.film_id
JOIN rental r 
ON i.inventory_id=r.inventory_id
JOIN payment p 
ON r.rental_id=p.rental_id
GROUP BY c.name 
ORDER BY Gross DESC 
LIMIT 5;

/* 8a */
Create view top_revenue as
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc 
ON c.category_id=fc.category_id
JOIN inventory i 
ON fc.film_id=i.film_id
JOIN rental r 
ON i.inventory_id=r.inventory_id
JOIN payment p 
ON r.rental_id=p.rental_id
GROUP BY c.name 
ORDER BY Gross DESC 
LIMIT 5;

/* 8b */
select * from top_revenue;

/* 8c */
drop view top_revenue;
