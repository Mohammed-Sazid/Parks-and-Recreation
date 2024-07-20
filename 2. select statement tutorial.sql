select * 
from employee_demographics;     #Under schemas which ever is bold , it will go there to pull the table 
								# if you double click sys and try to do it it will give error

-- so in that case you add the filename/database to it.
select *
from parks_and_recreation.employee_demographics;                               
                           
-- select statement works with column
select first_name, 
last_name,  
birth_date,
age,
10 * (age + 10)                       # in select statement we can do calculation, 
from employee_demographics;
                        
# PEMDAS is followed when doing calculation  
select DISTINCT first_name
from employee_demographics;

select distinct gender
from employee_demographics;

select distinct gender, first_name
from employee_demographics;

# its about uniqe values	

# uploading this to github or saving and sending it to somebody

# Where statement
# select is used to filter column and where is used to filter rows

# 3. Where statement 

select * 
from employee_salary
where first_name = 'Leslie'; # '=' is comparison operator

select * 
from employee_salary
where salary >= 50000; # '=' is comparison operator

select * 
from employee_salary
where salary <= 50000; # '=' is comparison operator

select * 
from employee_demographics
where gender != 'female';

select * 
from employee_demographics
where birth_date > '1985-01-01';

-- And or not logical operators

select * 
from employee_demographics
where birth_date > '1985-01-01' 
and gender = 'male';

select * 
from employee_demographics
where birth_date > '1985-01-01' 
or gender = 'male';

select * 
from employee_demographics
where (first_name = 'leslie' and age = 44) or age > 55;

-- LIke statement , looking for pattern not for a exact match
-- two special characters can be added to like statement  (% means anything and _ means a specific value)
select * 
from employee_demographics
where first_name like 'jer%';           # so this one look for jer then anything after it will return          

select * 
from employee_demographics
where first_name like '%er%';           # so this one look for er then anything before or after it will return          

select * 
from employee_demographics
where first_name like 'a%';             #          

select * 
from employee_demographics
where first_name like 'a__';            # 

select * 
from employee_demographics
where first_name like 'a___';           # Number of underscore specifies how many characters it exactly must have. 

select * 
from employee_demographics
where first_name like 'a___%';          # We can combine _ and %

select * 
from employee_demographics
where birth_date like '1989%';          # We can combine _ and %

# 4. Group by and order by

# The GROUP BY clause in MySQL is used to group rows that have the same values in specified columns into summary rows, 
# like "find the total number of customers in each country." 
# It's often used in conjunction with aggregate functions such as COUNT, SUM, AVG, MAX, and MIN.

select gender, avg(age) as Average_Age
from employee_demographics
group by gender
;

# so here grouping rows that have same values in gender(male and femeale)
# then finding average age of those group.
# so group first then the function you want to perform on each group. here group is gender and the function is avg age

select gender, count(*) as counts 
from employee_demographics
group by gender
;

select *
from employee_salary
;

select dept_id, count(*) as Num_of_employees
from employee_salary
group by dept_id
;

select dept_id, sum(salary) as total_salary
from employee_salary
group by dept_id
having total_salary > 100000
;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender
;

-- Order By
select * 
from employee_demographics
order by age ASC
;

select * 
from employee_demographics
order by age desc
;

select * 
from employee_demographics
order by  gender , age desc
;

-- very important : if we order by age first, the gender column dont get used. alter
-- IF there were same age for different gender than it would have ordered the gender.

select * 
from employee_demographics
order by  age , gender
;
-- not a good practice
-- if we know the column number we can order by the coilumn number 
select * 
from employee_demographics
order by  5 , 4
;

-- having vs where 

select gender , avg(age)
from employee_demographics
where avg(age) > 40
group by gender
;

-- In SQL, you cannot directly use aggregate functions like AVG in the WHERE clause because 
-- WHERE filters rows before grouping and aggregation. Instead, you should use the 
-- HAVING clause to filter aggregated results. Here's how you can correct and execute your query:

select gender , avg(age)
from employee_demographics
group by gender
having avg(age) > 40
;

-- using where clause and having clause in one query 
-- using Where to filter at row level
-- using Having to filter at aggregate level function , having only works after group by 

select * 
from employee_salary
;

select occupation , avg(salary)
from employee_salary
where occupation like '%manager%' 
group by occupation
having avg(salary) > 75000
;

-- Limit and Aliasing 

-- limit specifies how many rows you want in output

select * 
from employee_demographics
limit 3
;

-- combining with oorder by
select * 
from employee_demographics
order by age desc
limit 7
;

-- additional parameter for the limit 
select * 
from employee_demographics
order by age desc
limit 2 , 5
;

-- here it skips the first 2 and show the next one or whatever number you specify

-- Aliasing : Just a way to change column names

select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40
;

-- Intermediate Sql by ALex the Analyst

-- Joins : allows you to combine two tables or more together if they have common column , not same name but as long as the data is the same

select * 
from employee_demographics;
select * 
from employee_salary;

-- inner join : An INNER JOIN in MySQL (and other SQL databases) is used to combine rows from two or more tables based on a related column between them. 
-- The INNER JOIN keyword selects records that have matching values in both tables. If there is no match, the result set does not include rows from either table.

select * 
from employee_demographics 
inner join employee_salary
	on employee_demographics.employee_id = employee_salary.employee_id
;

-- Ron doesnt now show up coz on demographics employee id 2 does not exist

select employee_demographics.first_name, employee_salary.occupation 
from employee_demographics 
inner join employee_salary
	on employee_demographics.employee_id=employee_salary.employee_id
;

-- Key Points
-- Combines Rows: It combines rows from two or more tables based on a related column between them.
-- Common Column: The join condition specifies the common column(s) used to match rows between tables.
-- Filtered Results: Only rows with matching values in both tables are included in the result set.

-- Doing the whole thing using Alisasing so the ON clause is shorter

select * 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select first_name , occupation 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;
-- it wont work since first name exist on bosth tables , so sql dont know which table to pull from. THus the ambiguity
-- in case of occupation , it only exist in salary table , so no need to specify sal.occupation. there are no ambiguity

select dem.first_name , occupation 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- Outer Join 
-- Left Join will take everything from the left table even if there is no matches then it will only return the matches from the right table
select *
from employee_demographics as dem
left join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select * 
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- Self Join , tie the table to itself . Why??
-- work on it again
select * 
from employee_salary  as emp1
join employee_salary  as emp2
	on emp1.employee_id = emp2.employee_id
;

-- A better example : Finding people that works in the same department

select e1.employee_id, e1.first_name, e2.employee_id, e2.first_name
from employee_salary as e1
inner join employee_salary as e2
on e1.dept_id = e2.dept_id
 -- where e1.employee_id < e2.employee_id
;
-- no clue how to stop repeating
select * 
from employee_salary;

-- joining multiple tables
select * 
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
;
-- even though there is dept.id on the first table, its mathching the rows. the way it works 
-- the first join creates the table, like a virtual table, and the the secong join works based on 
-- mathcing number of the column of virtual table and department table


select * 
from parks_departments
;

-- Go to chatgpt and ask it summarize all four joins using an example

-- Union

select first_name, last_name
from employee_demographics
union distinct
select first_name, last_name
from employee_salary
;
-- by default union only grabs the distinct value. so from the salary table we got ron but everyone else was repeated. thats why it doesnot show
-- to see everything we can do UNION ALL . SO Union all gives just the distinct values . 
select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary
;

 
select first_name, last_name , 'old' as label
from employee_demographics
where age > 50
union all
select first_name, last_name
from employee_salary
;

-- It does not work because select statement is not returning the same number of columns . 3 vs 2

select first_name, last_name , 'old man' as label
from employee_demographics
where age > 40 and gender = 'male'
union      
select first_name, last_name , 'old female' as label
from employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name , 'highly paid' as label
from employee_salary
where salary > 70000
order by first_name, last_name
;        
        
-- string functions

select length('skyfall')
;

select first_name, length(first_name) as name_length
from employee_demographics
order by name_length desc
;

select upper('sky');
select lower('SKY');

select first_name, upper(first_name)
from employee_demographics
;

-- TRIM : gets rid of white space at front or back
select trim('                       sky          ');
select ('                       sky          ');
-- see the difference between trim or no trim
-- similar is ltrim and rtrim

-- substring : Left and right

select first_name,
left(first_name,4)
from employee_demographics
;

select first_name,
right(first_name,4)
from employee_demographics
;
select first_name,
left(first_name,4),
right(first_name,4),
substring(first_name,3,2),     -- 3 represnts where to start and 2 how many characters to go 
birth_date,
substring(birth_date,6,2) as Birth_Month
from employee_demographics
;

-- Replace
select first_name, replace(first_name, 'a','z')
from employee_demographics
;

-- locate 
select locate('x' , 'alexander');

select first_name, locate('an',first_name)
from employee_demographics
;

select first_name, last_name ,
concat (first_name,' ' ,last_name) as full_name
from employee_demographics
;

-- CASE statements
-- allows you to  add logic to your select statement like if/else

select first_name, 
last_name, 
case 
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'Old'
	when age > 50 then 'older'
end as Age_Bracket
from employee_demographics
;

-- pay increase and bonus
-- <  50000 = 5%
-- >= 50000 = 7%
-- finance = 10%

select first_name,last_name,salary,
case 
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
end as New_Salary,
case
	when dept_id = 6 then salary * .10 
end as Bonus
from employee_salary
;


-- subqueries

select *
from employee_demographics
where employee_id in
				( select employee_id
					from employee_salary
                    where dept_id = 1)
;

-- lets see if someone makes more than average 

select first_name, salary,
( select avg(salary)
from employee_salary)
from employee_salary
;

select gender , avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

-- Order in SQL Engine, From and where happens first. Then Group by. then Aggregate function

select avg(`max(age)`)
from ( select gender , avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender) as agg_table
;
-- the inner query needs aliasing in SQL. It also helps to refer and work with the result in outer query

select avg(max_age)
from ( select gender , avg(age), max(age) as max_age, min(age), count(age)
from employee_demographics
group by gender) as agg_table
;

-- Windows Functions
-- <Window Function>(<Arguments>) OVER (                        SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date) AS dept_total_salary
--    [PARTITION BY <column_list>]
--   [ORDER BY <order_list>]
--    [<Window Frame Clause>]
-- )
select gender , avg(salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
;

-- doing this by window function


select dem.first_name, dem.last_name , gender, avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

-- below code is wrong
select dem.first_name, dem.last_name ,gender , avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name ,gender
;

-- another example : rollin total
select dem.first_name, dem.last_name , gender, salary , sum(salary) over(partition by gender order by dem.employee_id) as Rolling_Total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;
 -- things only can be done by  window function

select dem.first_name, dem.last_name , gender, salary ,
row_number() over(partition by gender order by salary desc) as row_num,
rank () over(partition by gender order by salary desc) as rank_num,
dense_rank () over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

-- Advances Sql Alex The Analyst

-- Common Table expressions : define a subquery to reference in main query
-- structure below
/*
WITH cte_name (column1, column2, ...)
AS
(
    -- CTE query definition
    SELECT column1, column2, ...
    FROM table_name
    WHERE conditions
)
-- Main query that references the CTE
SELECT *
FROM cte_name;

*/

select * 
from employee_salary
;

select gender, avg(salary), max(salary), min(salary), count(salary)
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
;

with cte_example as
( 
select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
)

select avg(avg_sal)
from cte_example
;
-- Doing the same thing with subquery
select avg(avg_sal)
from (
select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
) as example_subquery
;

-- multiple ctes within one

with 
cte_example as
(
select employee_id, gender, birth_date
from employee_demographics
where birth_date > '1985-01-01'
), 
cte_example2 as
(
select employee_id, salary
from employee_salary
where salary > 50000 
)
select *
from cte_example
join cte_example2
	on cte_example.employee_id = cte_example2.employee_id
;

with cte_example2 as
(
select employee_id, salary
from employee_salary
where salary > 50000 
)

select * 
from cte_example2
;
-- One more thing , instead of alisaing the column name , we can put it inside right after naming the cte
-- It will override whatever inside. 
with cte_example (Gender, Average, Max, Min, Count) as
( 
select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
)

select *
from cte_example
;

-- Temporary Tables : are visible only within the session it is created
-- Its like Ctes but you can change and play with it before entering it into a complex query

-- 2 ways to do it

CREATE TEMPORARY TABLE temp_table (
	first_name varchar(50),
	last_name varchar(50),
	favorite_movie varchar(100)
);
select *
from temp_table;
;
insert into temp_table
values('Mohammed','Sazid','Arrival')
;
select *
from employee_salary;
;

create temporary table salary_over_50k
select *
from employee_salary
where salary >= 50000
;
select * 
from salary_over_50K
;

-- Stored Procedure

/*
DELIMITER //

CREATE PROCEDURE ProcedureName (
    IN input_param DataType, 
    OUT output_param DataType
)
BEGIN
    -- SQL statements
    -- Example: SELECT some_value INTO output_param FROM some_table WHERE some_column = input_param;
END //

DELIMITER ;

-- Example call to the stored procedure
CALL ProcedureName(input_value, @output_value);

-- Select to view the output parameter
SELECT @output_value;
*/

select *
from employee_salary 
where salary >= 50000;
-- use parks_and_recreation (optional)
create procedure large_salaries()
select *
from employee_salary 
where salary >= 50000;

call large_salaries()
;
create procedure large_salaries2()
select *
from employee_salary 
where salary >= 50000;
select *
from employee_salary 
where salary >= 50000;

call large_salaries2()
;

-- Only the first query works. coz semicolon is a delimeter.
delimiter $$
create procedure large_salaries3()
begin
	select *
	from employee_salary 
	where salary >= 50000;
	select *
	from employee_salary 
	where salary >= 10000;
end $$
; 
delimiter ;

call large_salaries3()
;

-- creating store procedure from SCHEMAS

-- parameters

delimiter $$
create procedure large_salaries4(input_id int)
begin
	select *
	from employee_salary 
	where employee_id = input_id
    ;
end $$
; 
delimiter ;
call large_salaries4(5)
;

-- Triggers and Events
-- trigger is a block of code that gets executed when an event takes place on a different tavle
-- writing a trigger when something gets updated is one table , it also gets updated in other table

/*
CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements
END;
*/

delimiter $$
create trigger employee_insert 
	after insert on employee_salary				-- what(insert) event and when(after - something happens in one table then) need to take place
												-- 						      (before - if data gets deleted from one table) 
	for each row 
begin
	insert into employee_demographics (employee_id,first_name,last_name)
	values (new.employee_id,new.first_name,new.last_name);

end
$$
delimiter ;
-- look under employee salary for the trigger
-- triggering it
insert into employee_salary (employee_id,first_name,last_name, occupation, salary, dept_id)
values (14, 'mohammed','sazid','homeless',5000,null)
;

select * 
from employee_salary;

select *
from employee_demographics;

-- EVENTS : An event takes place when it is scheduled

-- writing an event when a person it hits a certain age , its record gets deleted

select *
from employee_demographics;
delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete	
	from employee_demographics
	where age >= 60;
end
$$
delimiter ;

-- if some reason it does not work , do below:
show variables like 'event%';































































        
        
        
        
        
        
        
        
        
        
        
        
        