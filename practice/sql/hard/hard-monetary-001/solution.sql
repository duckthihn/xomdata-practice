-- Xom Data · Chia khách thành năm hạng chi tiêu
-- Problem: https://xomdata.com/practice/hard-monetary-001
-- Solved: 2026-08-28

with total_spent as (
    select
        customer_id,
        sum(amount) as total_spent
    from orders
    group by customer_id
)


select
    customer_id,
    total_spent,
    ntile(5) over(order by total_spent desc) as spend_rank
from total_spent
