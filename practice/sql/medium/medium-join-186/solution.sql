-- Xom Data · Goals and cards by team
-- Problem: https://xomdata.com/practice/medium-join-186
-- Solved: 2026-08-14

with player_stats as (
    select
        p.team_id,
        count(distinct p.id) as player_count
    from players p
    group by p.team_id
),
goal_stats as (
    select
        p.team_id,
        count(g.id) as total_goals_scored
    from players p
    join goals g on p.id = g.player_id
    group by p.team_id
),
penalty_stats as (
    select
        p.team_id,
        count(pe.id) as penalty_count
    from players p
    join penalties pe on p.id = pe.player_id
    group by p.team_id
)

select
    t.team_name,
    t.city,
    coalesce(ps.player_count, 0) as player_count,
    coalesce(gs.total_goals_scored, 0) as total_goals_scored,
    coalesce(pe.penalty_count, 0) as penalty_count,
    round(coalesce(gs.total_goals_scored, 0) * 1.0 / nullif(ps.player_count, 0) ,2) as goals_per_player,
    round(coalesce(pe.penalty_count, 0) * 1.0 / nullif(ps.player_count,0) , 2) as cards_per_player,
    rank() over(order by gs.total_goals_scored desc) as scoring_rank,
    sum(gs.total_goals_scored) over(order by gs.total_goals_scored desc) as cumulative_goals
from teams t
left join player_stats ps on t.id = ps.team_id
left join goal_stats gs on t.id = gs.team_id
left join penalty_stats pe on t.id = pe.team_id
