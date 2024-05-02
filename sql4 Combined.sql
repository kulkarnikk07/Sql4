
#1 Problem 1 : The Number of Seniors and Juniors to Join the Company	(https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/)
with CTE as(
SELECT employee_id,experience, sum(salary) over(partition by experience order by salary) rsum 
    FROM Candidates
    )

select 'Senior' as experience, count(distinct employee_id) 'accepted_candidates' 
from CTE where experience = 'Senior' and rsum <=70000

UNION
    
select 'Junior' as experience, count(distinct employee_id) 'accepted_candidates' 
from CTE where experience = 'Junior' and rsum <= (select 70000 - ifnull(max(rsum),0) from CTE where experience = 'Senior' and rsum<=70000);


#2 Problem 2 : League Statistics		(https://leetcode.com/problems/league-statistics/ )



#3 Problem 3 : Sales Person		(https://leetcode.com/problems/sales-person/ )



#4 Problem 4 : Friend Requests II	(https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/ )

