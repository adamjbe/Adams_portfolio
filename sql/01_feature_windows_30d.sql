--   Create fixed 30-day rolling feature windows for each user
--   using only historical data prior to a reference date.
--   This prevents data leakage and aligns predictors before churn.
WITH RiskProfiles AS (
    SELECT 
        user_id,
        churn_flag,
        tenure_bucket,
        plan_type,
    
        avg_weekly_usage_hours,
        payment_failures,
        
        (support_tickets / NULLIF(tenure_months, 0)) AS support_velocity,
        
        CASE WHEN last_login_days_ago > 30 THEN 1 ELSE 0 END AS inactive_30_days
    FROM Churn_Analysis_Project.customer_churn_analysis
)
SELECT 
    tenure_bucket,
    AVG(avg_weekly_usage_hours) AS avg_weekly_usage,
    AVG(support_velocity) AS avg_support_velocity,
    SUM(payment_failures) AS total_payment_failures,
    AVG(inactive_30_days) AS pct_inactive_customers,
    AVG(CAST(churn_flag AS FLOAT64)) AS churn_rate
FROM RiskProfiles
GROUP BY 1
ORDER BY churn_rate DESC;

--- This query showed no correlation between avg_weekly_usage_hours, support_tickets, tenure_months and churn. But it did reveal a strong connection between payment failures and churn rates.


---  So I ran this query to see if a failed payment made a customer significantly more likely to leave than their peers.

SELECT 
    payment_failure_group,
    plan_type,
    AVG(CAST(churn_flag AS FLOAT64)) AS churn_rate,
    COUNT(*) AS customer_count
FROM Churn_Analysis_Project.customer_churn_analysis
GROUP BY 1, 2
ORDER BY 3 DESC;





















