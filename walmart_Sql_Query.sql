use analysis;
select * from walmart;
-- 1. How many unique cities does the data have?

select count(distinct(city)) from walmart;

-- 2. In which city is each branch?

select city from walmart
where branch in ('A','B','C')
group by city;

-- 3. How many unique product lines does the data have?

select count(distinct(`product line`)) as unique_product from walmart;

-- 4. What is the most common payment method?

select payment, count(payment) as common_pay_method from walmart
group by payment
order by count(payment) desc limit 1;

-- 5. What is the most selling product line?

select `product line`, count(`product line`) as most_selling_product from walmart
group by `product line` 
order by count(`product line`) desc 
limit 1;

alter table walmart
add column months varchar(30);
UPDATE walmart
SET months = monthname(`date`);

-- 6. What is the total revenue by month?

select months, round(sum(total),2) as revenue from walmart
group by months;

-- 7. What month had the largest COGS?

select months, round(sum(cogs),2) as largest_cogs from walmart
group by months order by round(sum(cogs),2) desc limit 1;


-- 8. What product line had the largest revenue?

select `product line`, round(sum(total),2) as largest_revenue from walmart
group by `product line` order by round(sum(total),2) desc limit 1;


-- 9. What is the city with the largest revenue?

select city, round(sum(total),2) as largest_revenue from walmart
group by city order by round(sum(total),2) desc limit 1;

-- 10. What product line had the largest VAT?

select `product line`, round(sum(`tax 5%`)) as largest_Vat from walmart
group by `product line` order by round(sum(`tax 5%`)) desc limit 1;

-- 11. Fetch each product line and add a column to those product line showing "Good", "Bad". 
-- Good if its greater than average sales

alter table walmart
add column feedback varchar(30);

UPDATE walmart
SET feedback = (
    SELECT 
        CASE
            WHEN total > avg_total THEN 'Good'
            ELSE 'Bad'
        END
    FROM (
        SELECT sum(total), ROUND(AVG(total),2) AS avg_total
        FROM walmart
    ) AS subquery
);

-- 12. Which branch sold more products than average product sold? 

select branch, `product line`,sum(total) from walmart
group by branch, `product line` 
having sum(total) > (select round(avg(total),2) from walmart)
order by sum(total) desc limit 1;

select  branch, `product line`,sum(Quantity) from walmart
group by  branch, `product line`
having sum(Quantity) > (select avg(Quantity) from walmart)
order by sum(Quantity) desc ;

-- 13. What is the most common product line by gender?

select gender, `product line`,count(`product line`) from walmart
group by gender, `product line` order by count(`product line`) desc limit 1; 


-- 14. What is the average rating of each product line?

select  `product line`, round(avg(Rating),2) as rating from walmart
group by  `product line`;

-- 15.  Number of sales made in each time of the day per weekday ?

select dayname(date) as weekday, time, sum(total) as sales from walmart
group by weekday, time;

-- 16. Which of the customer types brings the most revenue?

select `customer type`, round(sum(total),2) as revenue from walmart
group by `customer type`;


-- 17. Which city has the largest tax percent/ VAT (**Value Added Tax**)?

select city, round(sum(`tax 5%`),2) as Total_Vat from walmart
group by city order by Total_Vat desc limit 1;

-- 18. Which customer type pays the most in VAT?

select `customer type`, round(sum(`tax 5%`),2) as total_tax from walmart
group by `customer type` order by total_tax desc limit 1;

-- 19. How many unique customer types does the data have?

select count(distinct(`customer type`)) as type_of_customer from walmart;

-- 20. How many unique payment methods does the data have?

select distinct(payment) as Unique_Payment_Method from walmart;

-- 21. What is the most common customer type?

select `customer type`, count(`customer type`) from walmart
group by `customer type` 
order by `customer type` limit 1;

-- 22. Which customer type buys the most?

select `customer type`, round(sum(total)) as most_buys from walmart
group by `customer type` order by most_buys desc limit 1;

-- 23. What is the gender of most of the customers?

select gender, count(gender) as most_buy from walmart
group by gender order by most_buy desc limit 1;

-- 24. What is the gender distribution per branch?

select Branch, Gender, count(gender) as Gender_Count from walmart
group by Branch, Gender order by Branch;

-- 25. Which time of the day do customers give most ratings?

select Time, count(rating) as Most_Rating from walmart
group by Time order by Most_Rating desc limit 5; 

-- 26. Which time of the day do customers give most ratings per branch?

select Branch, Time, count(rating) as Most_Rating from walmart
group by Branch, Time order by Branch, Most_Rating desc limit 5; 

-- 27. Which day fo the week has the best avg ratings?

select dayname(date) as Weekday, avg(rating) as Avg_Rating from walmart
group by Weekday order by Avg_Rating desc limit 1;

-- 28.  Which day of the week has the best average ratings per branch?

select Branch, dayname(date) as Weekday, avg(rating) as Avg_Rating from walmart
group by Branch, Weekday order by Weekday, Avg_Rating desc;