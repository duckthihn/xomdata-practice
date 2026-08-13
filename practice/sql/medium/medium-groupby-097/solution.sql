-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-08-13

with post_cte as
(
select
    user_id,
    post_type,
    post_date,
    (like_count + comment_count + share_count) as total_interactions
from posts
)
select
    u.full_name,
    p.post_type,
    p.post_date,
    total_interactions,
    rank() over(order by total_interactions desc) as overall_rank,
    row_number() over(partition by u.full_name order by total_interactions desc, post_date) as rank_in_author,
    round(total_interactions * 100.0 / max(total_interactions) over(), 2) as pct_of_top
from post_cte p
join users u on u.id = p.user_id

order by overall_rank, full_name, rank_in_author
limit 10
