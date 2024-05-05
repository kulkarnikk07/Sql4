
-- Problem 1 : The Number of Seniors and Juniors to Join the Company	(https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/)
with CTE as(
SELECT employee_id,experience, sum(salary) over(partition by experience order by salary) rsum 
    FROM Candidates
    )

select 'Senior' as experience, count(distinct employee_id) 'accepted_candidates' 
from CTE where experience = 'Senior' and rsum <=70000

UNION
    
select 'Junior' as experience, count(distinct employee_id) 'accepted_candidates' 
from CTE where experience = 'Junior' and rsum <= (select 70000 - ifnull(max(rsum),0) from CTE where experience = 'Senior' and rsum<=70000);


-- Problem 2 : League Statistics		(https://leetcode.com/problems/league-statistics/ )

with CTE as(
    select m1.home_team_id as 'r1', m1.away_team_id as 'r2', m1.home_team_goals as 'r3', m1.away_team_goals as 'r4'
    from Matches m1

    UNION ALL

    select m2.away_team_id as'r1', m2.home_team_id as 'r2', m2.away_team_goals as 'r3', m2.home_team_goals as'r4'
    from Matches m2
)

    select t.team_name, count(c.r1) as 'matches_played'
    ,sum(
        case
        when c.r3 > c.r4 then 3
        when c.r3 = c.r4 then 1
        else 0
        END
        ) as 'points'     
    ,sum(c.r3) 'goal_for', sum(c.r4) 'goal_against', sum(c.r3) - sum(c.r4) 'goal_diff'    
    from Teams t
    left join CTE c
    on t.team_id = c.r1
    group by t.team_name
    order by points desc, goal_diff desc, t.team_name;

-- Problem 3 : Sales Person		(https://leetcode.com/problems/sales-person/ )

select s.name
from salesperson s
where s.sales_id not in(
select o.sales_id
from orders o
left join company c
on c.com_id = o.com_id
where c.name = 'RED'
)

-- Problem 4 : Friend Requests II	(https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/ )

with CTE as(
select requester_id  as 'r1' from RequestAccepted 
UNION ALL
select accepter_id as 'r1' from RequestAccepted
)
select r1 as 'id', count(r1) num from CTE
group by r1
order by count(r1) desc
limit 1

