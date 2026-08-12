-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-08-12

WITH cte AS (
    SELECT
        subject_id,
        count(id) AS student_count,
        round(avg(final_score), 2) AS avg_score,
        round(
            100.0 * sum(CASE WHEN final_score >= 5 THEN 1 ELSE 0 END) / count(id), 2) AS pass_rate,
        rank() OVER (ORDER BY avg(final_score) DESC) AS rank_by_avg
    FROM grades g
    GROUP BY subject_id
)
SELECT
    subject_name,
    credits,
    student_count,
    avg_score,
    pass_rate,
    rank_by_avg,
    ntile (4) over (order by avg_score DESC, subject_name) as difficulty_quartile
FROM cte a
join subjects b on a.subject_id = b.id
order by rank_by_avg ASC, subject_name
