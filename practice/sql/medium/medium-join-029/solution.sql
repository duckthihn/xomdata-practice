-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-08-24

with cte as (
    select
    *,
    count(id) as subjects_taught
    from subjects
    group by lecturer_id
)

select
    l.full_name,
    l.academic_degree,
    subjects_taught,
    rank() over(order by subjects_taught desc) as workload_rank,
    sum(subjects_taught) over(order by subjects_taught desc, full_name) as cumulative_subjects

from lecturers l
join cte s on l.id = s.lecturer_id
