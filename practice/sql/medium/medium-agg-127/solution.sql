-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-11-13

WITH employee_summary AS (
    SELECT 
        e.id,
        e.full_name,
        e.employee_code,
        d.department_name,
        SUM(p.net_salary) AS total_received_salary,
        (
            SELECT COUNT(*) 
            FROM leaves l 
            WHERE l.employee_id = e.id AND l.status = 'approved'
        ) AS leave_count
    FROM employees e
    JOIN payroll p ON e.id = p.employee_id
    JOIN departments d ON d.id = e.department_id
    GROUP BY e.id, e.full_name, e.employee_code, d.department_name
)
SELECT 
    full_name,
    employee_code,
    department_name,
    total_received_salary,
    leave_count,
    ROUND(100.0 * (total_received_salary - AVG(total_received_salary) OVER (PARTITION BY department_name)) / AVG(total_received_salary) OVER (PARTITION BY department_name), 2) as pct_above_dept_avg
FROM employee_summary
ORDER BY total_received_salary DESC, employee_code
LIMIT 10;
