-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-08-12

with cte_calculation as 
(select
    d.faculty_id,
    d.full_name,
    count(m.id) as visit_count,
    avg(visit_fee) as avg_exam_fee,
    sum(visit_fee) as total_exam_fee
from medical_visits m
join doctors d on d.id = m.doctor_id
group by full_name
)

select
    faculty_name,
    full_name as doctor_name,
    visit_count,
    avg_exam_fee,
    total_exam_fee,
    rank() over(order by total_exam_fee desc) as overall_rank,
    dense_rank() over(partition by faculty_id order by total_exam_fee desc) as rank_in_faculty
from cte_calculation c
join faculties f on f.id = c.faculty_id
