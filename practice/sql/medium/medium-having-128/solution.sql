-- Xom Data · Employees averaging over 5 overtime hours
-- Problem: https://xomdata.com/practice/medium-having-128
-- Solved: 2026-08-31

with average as (
    select
        e.full_name,
        e.employee_code,
        avg(a.work_days) as avg_work_days,
        avg(a.overtime_hours) as avg_overtime_hours,
        avg(p.net_salary) as avg_salary
    from employees e
    join attendance a on e.id = a.employee_id
    join payroll p on e.id = p.employee_id
    group by e.full_name
),

derived as (
    select *,
        round(avg_overtime_hours / avg_work_days, 4) as overtime_intensity
    from average
    where avg_overtime_hours > 5 and avg_work_days >= 18
),

ranking as (
    select *,
        rank() over (order by overtime_intensity desc) as intensity_rank,
        ntile(4) over(order by overtime_intensity desc) as workload_quartile
    from derived
)


select * from ranking
