## ASSIGNMENT 2: Movies Database
use films;
show tables;
select * from film_category;
desc film_category;
select * from category;
select * from film;
select * from actor;
select * from address;
select * from city;
select * from country;
select * from film actor;
select * from language;


# Q1) Which categories of movies released in 2018? Fetch with the number of movies. 

select category.name as category_name,count(film.film_id) as no_of_movies
from film join film_category on film.film_id=film_category.film_id
join category on  film_category.category_id=category.category_id
where film.release_year=2018
group by category.name
order by no_of_movies desc;


# Q2) Update the address of actor id 36 to “677 Jazz Street”.
select actor.actor_id,address.address
from actor join address on actor.address_id=address.address_id
where actor_id=36;
UPDATE address
SET address = '677 Jazz Street'
WHERE address_id = (SELECT address_id FROM actor WHERE actor_id = 36);

#or
update address
inner join actor
on actor.address_id=address.address_id
set address ="677 Jazz Street"
where actor.actor_id=36;

# Q3) Add the new actors (id : 105 , 95) in film  ARSENIC INDEPENDENCE (id:41).
insert into film_actor(actor_id,film_id)
values (105,41),(95,41);

# Q4) Get the name of films of the actors who belong to India.
select film.title,country.country
from film join film_actor on film.film_id=film_actor.film_id
join actor on film_actor.actor_id=actor.actor_id
join address on actor.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id
where country.country='India';



# Q5) How many actors are from the United States?
select count(actor.address_id) as actors_of_usa, country.country
from actor join address on actor.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id
where country.country='United States';


# Q6) Get all languages in which films are released in the year between 2001 and 2010.
select language.name,film.release_year from language
join film on language.language_id=film.language_id
where film.release_year between 2001 and 2010;



# Q7) The film ALONE TRIP (id:17) was actually released in Mandarin, update the info.
SELECT language_id
FROM language
WHERE name = 'Mandarin';

select * from film
where title='alone trip';
update film
set language_id=4
where film_id=17;

#or
update film
set language_id=(select language.language_id
				 from language where language.name='Mandarin')
where film.film_id=17;



# Q8) Fetch cast details of films released during 2005 and 2015 with PG rating.
select film.title,
concat(actor.first_name,' ' ,actor.last_name)as actor_name,
film.release_year,film.rating
from film join film_actor
on film.film_id=film_actor.film_id
join actor on actor.actor_id=film_actor.actor_id
where film.release_year between 2005 and 2015
and film.rating='PG';


# Q9) In which year most films were released?
select release_year, count(film_id) as no_of_films
from film 
group by release_year
order by no_of_films desc
limit 1;

# Q10) In which year least number of films were released?
select release_year, count(film_id) as no_of_films
from film 
group by release_year
order by no_of_films asc
limit 1;


#Q11) Get the details of the film with maximum length released in 2014 .
select film.title,film.film_id
from film 
where film.release_year=2014
order by length desc
limit 1;
#Q12) Get all Sci- Fi movies with NC-17 ratings and language they are screened in.
select film.title,language.name from film 
join film_category
on film.film_id=film_category.film_id
join category on category.category_id=film_category.category_id
join language on language.language_id=film.language_id
where category.name='sci-fi'
and film.rating='nc-17';
#Q13) The actor FRED COSTNER (id:16) shifted to a new address:
 #055,  Piazzale Michelangelo, Postal Code - 50125 , District - Rifredi at Florence, Italy. 
#Insert the new city and update the address of the actor.
create view country_view as
select country_id from country
where country='italy';

create view city_view as
select city_id from city
where city='florence'
and country_id=(select country_id from country_view);

select * from address;
insert into address(address_id,address,address2,district,city_id,postal_code,phone)
values (1000,'055,  Piazzale Michelangelo',null,'Rifredi',(select city_id from city_view),'50125' ,' ');

create view address_view as 
select address_id from address
where address ='055,piazzale michelangelo'and postal_code='50125';
drop view address_view;

update actor
set address_id=(select address_id from address_view)
where actor_id =16;
select * from country where country='italy';
select * from city where city ='florence';
select * from address where city_id=603;



#Q14) A new film “No Time to Die” is releasing in 2020 whose details are : 
#Description: Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.
Language: English
Org. Language : English
Length : 100
Rental duration : 6
Rental rate : 3.99
Rating : PG-13
Replacement cost : 20.99
Special Features = Trailers,Deleted Scenes

Insert the above data.

Q15) Assign the category Action, Classics, Drama  to the movie “No Time to Die” .

Q16) Assign the cast: PENELOPE GUINESS, NICK WAHLBERG, JOE SWANK to the movie “No Time to Die” .

Q17) Assign a new category Thriller  to the movie ANGELS LIFE.

Q18) Which actor acted in most movies?

Q19) The actor JOHNNY LOLLOBRIGIDA was removed from the movie GRAIL FRANKENSTEIN. How would you update that record?

Q20) The HARPER DYING movie is an animated movie with Drama and Comedy. Assign these categories to the movie.

Q21) The entire cast of the movie WEST LION has changed. The new actors are DAN TORN, MAE HOFFMAN, SCARLETT DAMON. How would you update the record in the safest way?

Q22) The entire category of the movie WEST LION was wrongly inserted. The correct categories are Classics, Family, Children. How would you update the record ensuring no wrong data is left?

Q23) How many actors acted in films released in 2017?

Q24) How many Sci-Fi films released between the year 2007 to 2017?

Q25) Fetch the actors of the movie WESTWARD SEABISCUIT with the city they live in.

Q26) What is the total length of all movies played in 2008?

Q27) Which film has the shortest length? In which language and year was it released?

Q28) How many movies were released each year?

Q29)  How many languages of movies were released each year?.

Q30) Which actor did least movies?
