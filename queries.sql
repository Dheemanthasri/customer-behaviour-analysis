SELECT * FROM customer

--revenue generated based on gender
SELECT gender, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender

--top 5 products with highest average review rate
SELECT item_purchased,ROUND( AVG(review_rating::numeric) ,2)AS "Average Product Rating"
FROM customer
GROUP BY item_purchased
ORDER BY AVG(review_rating)
limit 5;

--do subscribed customer spend more? compare average spend
--and total revenue 
SELECT subscription_status,
COUNT(customer_id) AS total_customers,
ROUND(AVG(purchase_amount),2) AS avg_spend,
ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY subscription_status
ORDER BY total_revenue, avg_spend DESC;

--segmenting customers into new, returning and loyal 
WITH customer_type AS (
    SELECT 
        customer_id,
        previous_purchases,
        CASE
            WHEN previous_purchases = 1 THEN 'New'
            WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
            ELSE 'Loyal'
        END AS customer_segment
    FROM customer
)

SELECT 
    customer_segment,
    COUNT(*) AS "Number of customers"
FROM customer_type
GROUP BY customer_segment;


-- are repeated buyers likely yo subscribe?
SELECT subscription_status,
COUNT(customer_id)AS repeat_buyers
FROM customer
WHERE previous_purchases>5
GROUP by subscription_status

--revenue contribution of each age group
SELECT age_group,
SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC;