-- A. Check total customers and churned customers

SELECT 
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn;

-- b.Count of male vs female customers

SELECT 
    gender,
    COUNT(*) AS Total_Customers
FROM Telecom_Churn
GROUP BY gender;

------------------------------- Churn Behavior Analysis ------------------------------

-- a. churn by Gender

SELECT 
    gender,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY gender
ORDER BY Churn_Rate DESC;

--- b. Churn by Multi-Screen Users

SELECT 
    multi_screen,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY multi_screen
ORDER BY Churn_Rate DESC;

-- c. Churn by Mail Subscription

SELECT 
    mail_subscribed,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY mail_subscribed
ORDER BY Churn_Rate DESC;


---------------------------- 3. Service & Usage Patterns ----------------------------

-- a. Average metrics for churned vs non-churned

SELECT 
    churn,
    ROUND(AVG(age), 1) AS Avg_Age,
    ROUND(AVG(weekly_mins_watched), 1) AS Avg_Weekly_Mins,
    ROUND(AVG(customer_support_calls), 1) AS Avg_Support_Calls,
    ROUND(AVG(maximum_days_inactive), 1) AS Avg_Inactive_Days
FROM Telecom_Churn
GROUP BY churn;

-- b. Churn rate by number of customer support calls

SELECT 
    customer_support_calls,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY customer_support_calls
ORDER BY customer_support_calls;

-- c. Churn rate by inactivity

SELECT 
    CASE 
        WHEN maximum_days_inactive BETWEEN 0 AND 2 THEN '0-2 Days'
        WHEN maximum_days_inactive BETWEEN 3 AND 5 THEN '3-5 Days'
        WHEN maximum_days_inactive BETWEEN 6 AND 10 THEN '6-10 Days'
        ELSE '10+ Days'
    END AS Inactive_Range,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY 
    CASE 
        WHEN maximum_days_inactive BETWEEN 0 AND 2 THEN '0-2 Days'
        WHEN maximum_days_inactive BETWEEN 3 AND 5 THEN '3-5 Days'
        WHEN maximum_days_inactive BETWEEN 6 AND 10 THEN '6-10 Days'
        ELSE '10+ Days'
    END
ORDER BY Churn_Rate DESC;


------------------------------- 4. Time-Based Insights

-- a. Churn rate by year

SELECT 
    year,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY year
ORDER BY year;


----------------------- ---------------------------------

-- a. Top 10 high-risk customers (most inactive & high support calls)

SELECT TOP 10 
    customer_id,
    age,
    gender,
    customer_support_calls,
    maximum_days_inactive,
    weekly_mins_watched,
    churn
FROM Telecom_Churn
ORDER BY churn DESC, customer_support_calls DESC, maximum_days_inactive DESC;


-- b. Most active loyal customers

SELECT TOP 10 
    customer_id,
    gender,
    weekly_mins_watched,
    videos_watched,
    churn
FROM Telecom_Churn
WHERE churn = 0
ORDER BY weekly_mins_watched DESC;


-- 6.Churn by Age Group
SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 40 THEN '25-40'
        WHEN age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(churn) AS Churned_Customers,
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM Telecom_Churn
GROUP BY 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 40 THEN '25-40'
        WHEN age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END
ORDER BY Churn_Rate DESC;