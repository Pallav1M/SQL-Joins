create DATABASE tv_review_app;

use tv_review_app;

create table Reviewers
(
id int primary key AUTO_INCREMENT,
first_name varchar(100),
last_name varchar(100)
    );

create table Series
(
    id int primary key AUTO_INCREMENT,
    title varchar(100),
    released_year year(4),
    genre varchar(100)
);

create table Reviews
(
id int primary key AUTO_INCREMENT,
ratings decimal(2,1),
series_id int,
    reviewer_id int,
    FOREIGN key(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
    );
    
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
    
INSERT INTO reviews(series_id, reviewer_id, ratings) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
select * from reviews;
select * from reviewers;
select * from series;

-- display all titles and their ratings 
select title, ratings 
from series
join reviews 
on series.id = reviews.series_id;

-- display average ratings for every title (ignore the ones without ratings

select title, avg(ratings) as 'average rating'
from series
join reviews 
on series.id = reviews.series_id
group by series.id
-- (to avoid grou by series with same name)
order by avg(ratings);

-- display first and last name of revewers, and their ratings

select first_name, last_name,ratings
from reviewers 
 left join reviews
--  (for all reviewers even without ratings) else use inner join
on reviewers.id = reviews.reviewer_id
order by first_name, last_name;

select first_name, last_name,ratings
from reviewers 
join reviews
on reviewers.id = reviews.reviewer_id
order by first_name, last_name;

--  IS SAME AS 

select first_name, last_name,ratings
from  reviews
join  reviewers
on reviewers.id = reviews.reviewer_id
order by first_name, last_name;

-- Find the unreviewed series 
select * from series;
select distinct genre from series;
select * from reviews;

select title, ratings 
from series 
left join reviews on series.id = reviews.series_id;

select title, ratings 
from series 
left join reviews on series.id = reviews.series_id
where ratings is null;

-- display the genres and their average ratings 
select * from series;
select distinct genre from series;

select genre, round(avg(ratings),2) as 'average rating'
from series
inner join reviews on series.id = reviews.series_id
group by genre;

-- reviewer statistics

select * from reviewers;
select * from reviews;

select first_name,
 last_name,
 round(ifnull(avg(ratings),0),2) as 'avg rating',
 count(ratings) as 'rating count',
 ifnull(min(ratings), 0) as 'min rating',
 ifnull(max(ratings), 0) as 'max rating',
case
         WHEN count(ratings) > 0 then 'active'
         ELSE 'inactive' 
       end AS status
from reviewers
left join reviews on reviewers.id = reviews.reviewer_id
group by reviewers.id;

-- display title, rating, reviewer (3 table join)

select * from reviewers;
select * from reviews;
select * from series;

select title, ratings, concat(first_name,' ', last_name) as 'reviewer'
from series
inner join reviews on series.id = reviews.series_id
inner join reviewers on reviews.reviewer_id = reviewers.id
order by title;

