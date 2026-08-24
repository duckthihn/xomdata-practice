-- Xom Data · Employees paid above their department average
-- Problem: https://xomdata.com/practice/medium-subquery-110
-- Solved: 2026-08-24

with cte as
(
    select
        *,
        avg(salary) over(partition by department_id) as dept_avg_salary
    from employees    
)

select 
    e.full_name,
    d.dept_name,
    e.salary,
    round(e.dept_avg_salary,0) as dept_avg_salary,
    round(salary * 100.0 / dept_avg_salary - 100,2) as premium_pct
from cte e
join departments d on d.id = e.department_id
where salary > dept_avg_salary
order by premium_pct desc, full_name
