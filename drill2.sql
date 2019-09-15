--Write a query that returns a list of all the unique values in the 'country' field.
select distinct country from ksprojects


--How many unique values are there for the main_category field? What about for the category field?
select count(distinct main_category) as distinct_main_cat,count(distinct category) as distinct_cat from ksprojects
--15 and 158

--Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category.
select main_category, category, count(distinct main_category) as distinct_main_cat,count(distinct category) as distinct_cat from ksprojects 
group by main_category, category
order by main_category

--How many unique categories are in each main_category?
select main_category,count(distinct category) as distinct_cat from ksprojects
group by main_category


--Write a query that returns the average number of backers per main_category, rounded to the nearest whole number and sorted from high to low.
select round(avg(backers),0) avg_backers,main_category
from ksprojects
group by main_category
order by avg_backers desc


select * from ksprojects
--Write a query that shows, for each category, how many campaigns were successful and 
--the average difference per project between dollars pledged and the goal.
select category,  count(state) campaign_state, avg(usd_pledged - goal) as diff
from ksprojects
where state = 'successful'
group by category


--Write a query that shows, for each main category, how many projects had zero backers for that category
--and the largest goal amount for that category (also for projects with zero backers).
select main_category, category, count(backers) as zero_backers, max(goal) largest_goal
from ksprojects
where backers = 0
group by main_category, category


--For each category, find the average USD per backer, and return only those results for which the average USD per backer is < $50, 
--sorted high to low. Hint: Division by NULL is not possible, so use NULLIF to replace NULLs with 0 in the average calculation.
select category, avg(usd_pledged/NULLIF(backers,0)) as avd_usd
from ksprojects
group by category
having avg(usd_pledged/NULLIF(backers,0)) < 50


--Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers.
select main_category, count(*) num_proj_succ
from ksprojects
where backers between 5 and 10
and state = 'successful'
group by main_category

--Get a total of the amount ‘pledged’ for each type of currency grouped by its respective currency. Sort by ‘pledged’ from high to low.
select sum(pledged) as total_amount, currency
from ksprojects
group by currency
order by total_amount desc


--Excluding Games and Technology records in the main_category field, 
--return the total of all backers for successful projects by main_category where the total was more than 100,000. Sort by main_category from A to Z.
select main_category, sum(backers) total_backers
from ksprojects
group by main_category
having main_category not in ('Games','Technology')
and sum(backers) > 100000
