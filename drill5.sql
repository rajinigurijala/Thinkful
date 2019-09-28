--2.
select namefirst, namelast, inducted from people peo
left outer join hof_inducted hof
on peo.playerid = hof.playerid
--3.
select birthyear, deathyear, birthcountry, namefirst, namelast 
from people peo 
left outer join hof_inducted hof
on peo.playerid = hof.playerid
where hof.yearid= '2006' 
and hof.inducted = 'Y' 
and votedby = 'Negro League'
--4.
select sal.yearid, sal.playerid, sal.teamid, sal.salary, hof.category
from salaries sal 
inner join hof_inducted hof 
on sal.playerid = hof.playerid
--5.
select sal.playerid, sal.yearid, teamid, lgid, salary, inducted
from hof_inducted hof full outer join salaries sal
on hof.playerid = sal.playerid;
--6.
select * from hof_inducted
union all
select * from hof_not_inducted;
--
select * from hof_inducted
union 
select * from hof_not_inducted;
--7.
select namelast, namefirst, sum(salary)
from salaries left outer join people
on salaries.playerid = people.playerid
group by namelast, namefirst
order by namelast, namefirst;
--8.
select hofn.playerid, yearid, namefirst, namelast 
from hof_inducted hofn left outer join people peo
on hofn.playerid = peo.playerid
union all 
select hofn.playerid, yearid, namefirst, namelast 
from hof_not_inducted hofn left outer join people peo
on hofn.playerid = peo.playerid;
--9.
select concat(namelast,', ', namefirst) as namefull, yearid, inducted
from hof_inducted hof left outer join people peo
on hof.playerid = peo.playerid
where yearid >= 1980
union all 
select concat(namelast,', ', namefirst) as namefull, yearid, inducted
from hof_not_inducted hofn left outer join people peo
on hofn.playerid = peo.playerid
where yearid >= 1980
order by yearid,  inducted desc, namefull;
--10.
select yearid, teamid, playerid, salary
from salaries
where salary in
	(select max(salary)
	from salaries
	group by yearid, teamid)
order by salary desc;
--
select yearid, teamid, salaries.playerid, salary, namelast, namefirst
from salaries left outer join people
	 on salaries.playerid = people.playerid
where salary in
	(select max(salary)
	from salaries
	group by yearid, teamid)
order by salary desc;
--11.
select birthyear, deathyear, namefirst, namelast
from people
where birthyear > any
	(select	birthyear
	from people
	where playerid = 'ruthba01')
order by birthyear;
--12.
select namefirst, namelast, 
	case 	when birthcountry = 'usa' then 'USA'
	else 'non-USA'
end as usaborn
from people
order by 3;
--13. 
select round(avg(case when throws = 'R' then height end),2) as right_height,
       round(avg(case when throws = 'L' then height end),2) as left_height
from people 
--14.
with team_sal as
(select teamid, max(salary) as max_sal
from salaries
where yearid > 2010
group by teamid)
select round(avg(max_sal),2) as avg_max_sal
from team_sal;























