-- Business Problems

-- 1. count the number of movies vs tv shows
select 
type, count(*) as total_count
from netflix
group by type;

--2) list all the movies released in the specific year (eg 2020)
select * from netflix
where release_year = 2020
and type = 'Movie'
order by show_id;

--3) Find th top 5 countries with the most content on netflix
select
unnest(string_to_array(country,',')) as countries,
count(show_id) as most_content
from netflix
group by 1
order by 2 desc limit 5;

--4) identify the longest movie
select * from netflix
where
type = 'Movie'
and
duration = (select max(duration) from netflix)
order by duration desc limit 1;

--5) find content added in the last 5 years
select * from netflix
where
to_date(date_added, 'Month DD, YYYY') >= current_date - interval '5 years';

--6) find all the movies/tv shoes directed by 'rajiv chilaka'
select * from netflix
where director like '%Rajiv Chilaka%';

--7) list all tv shows with more than 5 seasons
select * from netflix
where
type = 'TV Show'
and
split_part(duration,' ',1):: numeric > 5;

--8) find the number of items in each genre
select
unnest(string_to_array(listed_in,',')) as genre,
count(show_id) as total_content
from netflix
group by 1;

--9) List all movies that are documentries
select * from netflix
where listed_in like '%Documentaries%';

--10) find all content without a director
select * from netflix
where director is null;

--11) find how many movies salman khan apeared in last 10 years
select * from netflix
where
casts Ilike '%Salman Khan%'
and
release_year > extract(year from current_date) - 10;

--12) find the top 10 actors who have appeared in thr highest number of movies produced in india
select
unnest(string_to_array(casts,',')) as actors,
count(*) as total_content
from netflix
where country ilike '%india%'
and type = 'Movie'
group by 1
order by 2 desc
limit 10;




