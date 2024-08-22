 create database HRanalysis;

use HRanalysis;

-- Total Data Files

select *from departments
select *from dept_emp
select *from dept_manager
select *from employees
select *from salaries
select *from titles 



-- Data Cleaning & Preparation

exec sp_rename 'dbo.departments.["dept_no"]', 'dept_no', 'column'
exec sp_rename 'dbo.departments.["dept_name"]', 'dept_name', 'column'
exec sp_rename 'dbo.employees.sex', 'gender', 'column'

alter table salaries alter column salary bigint
alter table employees alter column birth_date date
alter table employees alter column hire_date date



-- Data Analysis & Insights


-- Determine how many employees work in each department

select
dept_name as 'Department Name',
count('dept_no') as 'Total Employees'
from departments left join dept_emp on 
departments.dept_no=dept_emp.dept_no
group by dept_name




-- Identify the top 10 highest paid employees in the company

select top 10
first_name as 'First Name',
last_name as 'Last Name',
dept_name as 'Department Name',
salary as Salary
from employees join salaries
on employees.emp_no=salaries.emp_no
join dept_emp on 
dept_emp.emp_no=salaries.emp_no
join departments on
departments.dept_no=dept_emp.dept_no
order by salary desc



-- Calculate the average salary for each departments

select
dept_name as 'Department Name',
avg(salary) as 'Average Salary' 
from dept_emp join salaries
on dept_emp.emp_no=salaries.emp_no
join departments on 
departments.dept_no=dept_emp.dept_no
group by dept_name



-- Compare the average salary of male and female employees

select 
gender as Gender,
avg(salary) as 'Average Salary'
from employees join salaries
on employees.emp_no=salaries.emp_no
group by gender




-- compare the how many employees work in company basis of genders

select 
gender as Gender,
count(gender) as 'Employee Count'
from employees
group by gender



-- Analyze the employees in company on the basis of their ages

select 
datediff(year, birth_date,hire_date) as Age,
count(datediff(year, birth_date,hire_date)) as 'Count Employees'
from employees
group by datediff(year, birth_date,hire_date)
order by 'Count Employees' desc




-- Caculate the ratio of managers to employees in each department

select 
dept_name as 'Department Name',
count(emp_no) as 'Total Managers'
from departments join dept_manager
on departments.dept_no=dept_manager.dept_no
group by dept_name



-- Analyze how many employees hired in each year

select 
year(hire_date) as Years,
count(emp_no) as  'Total Employees'
from employees
group by year(hire_date)
order by year(hire_date)



-- Calculate the total salary expence for each department

select
dept_name as 'Department Name',
sum(salary) as 'Salaries Expances'
from departments join dept_emp
on departments.dept_no=dept_emp.dept_no
join salaries
on dept_emp.emp_no=salaries.emp_no
group by dept_name
order by sum(salary)




-- identify the employees who are not cureently assigned to any department

select
count(dept_no) as 'Not Assigned Employees'
from dept_emp
where dept_no is null




-- Calculate the average salary by team member distribution

select 
title as 'Employee Distribution',
avg(salary) as 'Average Salary'
from titles join employees
on titles.title_id=employees.emp_title_id
join salaries
on employees.emp_no=salaries.emp_no
group by title
order by 'Average Salary' desc




-- Calculate the number of employees by team member distribution

select
title as 'Employee Distribution',
count(emp_title_id) as Salaries
from titles join employees
on titles.title_id=employees.emp_title_id
group by title
order by Salaries desc 





-- Calculate the number of employees as gender by team member distribution 

select
title as 'Employee Distribution',
sum(case when gender='M' then 1 else 0 end) as Male,
sum(case when gender='F' then 1 else 0 end) as Female
from titles join employees
on titles.title_id=employees.emp_title_id
group by title



-- Analyze the department managers by gender

select 
gender as Gender,
count(dept_no) as 'Managers Counts'
from employees join dept_manager
on employees.emp_no=dept_manager.emp_no
group by gender



-- Calculate the total salary expence for by team member distribution 

select
title as 'Employee Distribution',
sum(salary) as Salary
from titles join employees
on titles.title_id=employees.emp_title_id
join salaries
on salaries.emp_no=employees.emp_no
group by title
order by sum(salary) desc


-- Calculate the average salary for employee based on hired year 

select
year(hire_date) as 'Hired Year',
avg(salary) as Salary
from employees join salaries
on employees.emp_no = salaries.emp_no
group by year(hire_date)
order by 'Hired Year' asc



-- Analyze how the company monthly salary has changed over the time

select
month(hire_date) as 'Hired Month',
avg(salary) as Salary
from employees join salaries
on employees.emp_no = salaries.emp_no
where year(hire_date) =1999
group by 
month(hire_date)
order by 'Hired Month' asc



-- Analyze how many employees were hired each month in a specific year 

select 
month(hire_date) as 'Hired Month',
count(emp_no) as 'Total Employees'
from employees
where year(hire_date)=1995
group by month(hire_date)
order by 'Hired Month' asc



-- Determine the distribution of employees birthdays by month

select
month(birth_date) as 'Birth Month',
count(emp_no) as 'Birthdays In Each Months'
from employees
group by month(birth_date)
order by 'Birth Month' asc