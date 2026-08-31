-- Xom Data · Top 3 products by sales in each category
-- Problem: https://xomdata.com/practice/hard-topn-001
-- Solved: 2026-08-31

with cte as (
    select
        category,
        name as product_name,
        units_sold,
        dense_rank() over(partition by category order by units_sold desc) as rank_in_cat
    from products
)


select * from cte
where rank_in_cat <= 3
