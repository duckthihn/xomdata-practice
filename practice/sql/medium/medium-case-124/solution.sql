-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-08-11

WITH student_avg AS (
    SELECT
        s.full_name,
        s.student_code,
        AVG(sc.final_score) AS avg_score
    FROM students s
    INNER JOIN scores sc
        ON s.id = sc.student_id
    GROUP BY
        s.id,
        s.full_name,
        s.student_code
)

SELECT
    full_name,
    student_code,
    ROUND(avg_score, 2) AS avg_score,
    CASE
        WHEN avg_score >= 9 THEN 'Excellent'
        WHEN avg_score >= 8 THEN 'Good'
        WHEN avg_score >= 7 THEN 'Fair'
        WHEN avg_score >= 5 THEN 'Average'
        ELSE 'Poor'
    END AS grade,
    DENSE_RANK() OVER(ORDER BY avg_score DESC) AS class_rank
FROM student_avg
