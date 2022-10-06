use customers_orders;

create table students
(
id int primary key auto_increment,
first_name varchar(100)
);

create table papers
(
title varchar(100),
grade int,
student_id int,
foreign key(student_id) references students(id) on delete cascade
);

desc papers;

INSERT INTO students (first_name) VALUES 
('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');

insert into papers(student_id,title, grade)
VALUES (1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

select * from students;
select * from papers;

-- print first_name, title, grade
select first_name, title, grade 
from students
join papers on students.id = papers.student_id
order by grade desc;

-- alternate soultions 
select first_name, title, grade 
from students
right join papers on students.id = papers.student_id
order by grade desc; 

-- display all students and their grades(even if not submitted)
select first_name, title, grade 
from students
left join papers on students.id = papers.student_id
order by grade asc; 

-- replace null values with 0 for grade and 'missing' for title
select first_name, 
ifnull(title, 'missing') 
 ifnull(grade, '0')
from students
left join papers on students.id = papers.student_id
order by grade asc; 

-- display the average grades for everyone, and use 0 for the ones who did not submit 
select first_name, ifnull(avg(grade), 0) as avg
from students
left join papers on students.id = papers.student_id
group by id;

-- adding a status "passing" or failing 
select first_name, 
ifnull(avg(grade), 0) as avg,
CASE 
         WHEN Avg(grade) IS NULL THEN 'FAILING' 
--          because null >= 75 = null 
         WHEN Avg(grade) >= 75 THEN 'PASSING' 
         ELSE 'FAILING' 
       end AS passing_status 
from students
left join papers on students.id = papers.student_id
group by id;