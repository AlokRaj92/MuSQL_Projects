use analysis;
select * from hr;

update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
	when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

ALTER TABLE HR
modify column birthdate date;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;
ALTER TABLE hr
modify column hire_date date;

-- 1. What is the gender breakdown of employees in the company?

select Gender, count(gender) as Count from hr
group by Gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

select race, count(race) as Count from hr
group by race;


-- 3. What is the age distribution of employees in the company?

select first_name, year(current_date()) - year(birthdate) as age from hr; 

-- 4. How many employees work at headquarters versus remote locations?

select Location, count(Location) as Total_Count from hr
group by Location;

-- 5. What is the average length of employment for employees who have been terminated?

select avg(year(date(termdate)) - year(hire_date)) as Avg_length from hr;

-- 6. How does the gender distribution vary across departments and job titles?

select Department, Jobtitle, Gender, count(gender) as gender from hr
group by Department, Jobtitle, Gender;

-- 7. What is the distribution of job titles across the company?

select Jobtitle, count(Jobtitle) as Distribution from hr
group by Jobtitle;

-- 8. What is the distribution of employees across locations by city and state?

select location_city, location_state, count(*) as Emp_Count from hr
group by location_city, location_state
order by count(*) desc;

-- 9. How has the company's employee count changed over time based on hire and term dates?

select year(hire_date) as Year, count(hire_date) as Hired, count(year(termdate)) as Termination, 
(count(hire_date) - count(year(termdate))) as Changes, 
round(((count(hire_date) - count(year(termdate)))/100),2) as Change_Percent
from hr
group by Year order by Year;

-- 10. What is the tenure distribution for each department?

select Department,avg((year(termdate) - year(hire_date))) as Avg_Tenure from hr
group by Department order by Avg_Tenure desc;
