--1. Identify the top 10 customers and their email so we can reward them
select concat(customer.first_name,' ',customer.last_name ) as full_name,customer.customer_id,customer.email,count(rental_id) as jumlah_rental
from customer 
inner join rental on customer.customer_id = rental.customer_id
group by customer.customer_id  
order by 4 desc 
limit 10;

--2. Identify the bottom 10 customers and their emails
select concat(customer.first_name,' ',customer.last_name ) as full_name,customer.customer_id,customer.email,count(rental_id) as jumlah_rental
from customer 
inner join rental on customer.customer_id = rental.customer_id
group by customer.customer_id  
order by 4 asc  
limit 10;

--3.What are the most profitable movie genres (ratings)?
select category.name as genre, count(*) as jumlah_peminat, sum(amount) as pendapatan_per_genre
from category
inner join film_category on category.category_id = film_category.category_id 
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id 
inner join payment on rental.rental_id = payment.rental_id
group by category.name 
order by 2 desc; 
 

--4.How many rented movies were returned late, early, and on time? 
select case 
	when rental_duration > date_part('day',return_date - rental_date) then 'returned early'
	when rental_duration = date_part('day',return_date - rental_date) then 'returned on time'
	else 'returned late'
end as status_pengembalian ,
count(*) as jumlah_film
from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by 1
order by 2 desc ;
	

--5. What is the customer base in the countries where we have a presence?
select country.country as negara,count(customer_id) as jumlah_customer
from country 
inner join city on country.country_id = city.country_id
inner join address on city.city_id = address.city_id
inner join customer on address.address_id = customer.address_id 
group by country.country_id
order by 2 desc;

--6. Which country is the most profitable for the business?
select country.country as negara,sum (amount) as jumlah_pendapatan  
from country 
inner join city on country.country_id = city.country_id
inner join address on city.city_id = address.city_id
inner join customer on address.address_id = customer.address_id 
inner join payment on customer.customer_id = payment.customer_id 
group by country.country_id
order by 2 desc;

--7.What is the average rental rate per movie genre (rating)?
select category.name as genre, avg(rental_rate) as rata_rata_tarif_sewa  
from category 
inner join film_category on category.category_id = film_category.category_id 
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id 
inner join payment on rental.rental_id = payment.rental_id
group by 1
order by 2 desc ;

