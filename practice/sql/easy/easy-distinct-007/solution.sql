-- Xom Data · Stock exchanges
-- Problem: https://xomdata.com/practice/easy-distinct-007
-- Solved: 2026-08-21

select
    distinct(exchange)
from stocks
order by exchange
