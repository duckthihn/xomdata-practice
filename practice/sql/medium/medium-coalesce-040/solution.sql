-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-08-13

select
    g.genre_name,
    count(b.id) as book_count,
    COALESCE(round(avg(price), 0), 0) as avg_price,
    COALESCE(min(price), 0) as min_price,
    COALESCE(max(price), 0) as max_price,
    COALESCE((max(price) - min(price)), 0) as price_range,
    rank() over(order by count(b.id) desc) as coverage_rank,
    NTILE(3) OVER (ORDER BY COUNT(b.id) DESC, g.id) AS library_focus
from genres g
left join books b on g.id = b.genre_id
group by g.genre_name
order by coverage_rank, g.genre_name
