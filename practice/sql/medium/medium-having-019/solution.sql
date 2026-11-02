-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-11-02

WITH cte AS (
    SELECT
        s.id,
        s.store_name,
        s.reputation_score,
        COUNT(o.id) AS order_count
    FROM sellers s
    JOIN orders o ON s.id = o.seller_id
    WHERE s.reputation_score >= 4.5
    GROUP BY s.id, s.store_name, s.reputation_score
    HAVING COUNT(o.id) >= 3
)

SELECT
    store_name,
    reputation_score,
    order_count,
    RANK() OVER (ORDER BY order_count DESC) AS rank_by_orders,
    SUM(order_count) OVER (
        ORDER BY order_count DESC, id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_orders
FROM cte
ORDER BY rank_by_orders, id;
