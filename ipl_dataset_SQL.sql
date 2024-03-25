use practice;
select * from ipl_dataset;
-- Q1. What is the maximum number of matches played by an individual player in a season?

select Player, Mat from ipl_dataset
order by Mat desc limit 5;

-- Q2. What is the highest average of a player in a season?

select Player, Avg from ipl_dataset
order by Avg desc;

-- Q3. What is the average number of matches played by a player in a season?

select Player, avg(Mat) from ipl_dataset
group by Player;

-- Q4. Check the list of players who has an average greater than 50 as well strike rate above 120.

select Player, Avg from ipl_dataset
where Avg > 50;

-- Q5. Please check the list of players who has an average greater than 40 and balls faced less than 100.

select * from ipl_dataset
where Avg > 40 and BF < 100;

-- Q6. Please check the list of players who scored more than 300 runs with an average greater than 45 & strike rate above 130.

select * from ipl_dataset
where Runs > 300 and Avg > 45 and SR > 130;

-- Q7. Players who scroed alteast one century in this season.

SELECT * FROM ipl_dataset
WHERE `100` >= 1;

-- Q8. Players who scored atleast 4 half centuries in this season.

SELECT * FROM ipl_dataset
WHERE `50` >= 4;

-- Q9. Check the list of players who hit more than 45 boundARIES and more than 10 sixes in this season.

select * from ipl_dataset
where 4s > 45 and 6s >10;

-- Q10. Top 30 players with most runs in a season v/s matches played.

select Player, Mat, Inns, Runs from ipl_dataset
order by Runs desc limit 30; 

-- Q11. Top 30 players with highest number of sixes.

select * from ipl_dataset
order by 6s desc limit 30;


