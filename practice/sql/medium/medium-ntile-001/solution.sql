-- Xom Data · Splitting customers into four spending tiers
-- Problem: https://xomdata.com/practice/medium-ntile-001
-- Solved: 2026-08-27

-- Viết SQL của bạn ở đây
select
    customer_name,
    total_spent,
    ntile(4) over(order by total_spent DESC, customer_name) as spend_quartile
from customer_spending
order by total_spent desc, spend_quartile, customer_name
