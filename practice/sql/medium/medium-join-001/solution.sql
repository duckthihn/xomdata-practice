-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-08-13

select
    c.full_name,
    count(o.id) as order_count,
    coalesce(sum(o.total_amount),0) as total_spending,
    coalesce(avg(o.total_amount), 0) as avg_order_value,
    row_number() over(order by sum(o.total_amount) desc, c.full_name) as spending_rank
from orders o
join customers c on o.customer_id = c.id
group by full_name
