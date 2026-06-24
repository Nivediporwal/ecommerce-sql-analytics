-- E-Commerce Customer Behavior Analytics
-- Author: Nivedi Porwal
-- Database: ecommerce_analytics
-- Tool: MySQL Workbench



-- Total Revenue

SELECT ROUND(SUM(revenue),2) AS Total_Revenue
FROM ecommerce_data;



-- Total Customers

SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM ecommerce_data;



-- Total Purchases

SELECT COUNT(*) AS Total_Purchases
FROM ecommerce_data
WHERE purchased = 1;



-- Conversion Rate

SELECT
ROUND(
100 * SUM(purchased)/COUNT(*),
2
) AS Conversion_Rate
FROM ecommerce_data;



-- Cart Abandonment Rate

SELECT
ROUND(
100 * SUM(cart_abandoned)/COUNT(*),
2
) AS Cart_Abandonment_Rate
FROM ecommerce_data;



-- Top 10 Product Categories by Revenue

SELECT
product_category,
ROUND(SUM(revenue),2) AS Revenue
FROM ecommerce_data
GROUP BY product_category
ORDER BY Revenue DESC
LIMIT 10;



--Revenue by Device Type

SELECT
device_type,
ROUND(SUM(revenue),2) AS Revenue
FROM ecommerce_data
GROUP BY device_type
ORDER BY Revenue DESC;



--Revenue by Marketing Channel

SELECT
marketing_channel,
ROUND(SUM(revenue),2) AS Revenue
FROM ecommerce_data
GROUP BY marketing_channel
ORDER BY Revenue DESC;



--Purchase Rate by Device

SELECT
device_type,
ROUND(
100 * AVG(purchased),
2
) AS Purchase_Rate
FROM ecommerce_data
GROUP BY device_type;



--Rank Marketing Channels

SELECT
marketing_channel,
SUM(revenue) AS Revenue,
RANK() OVER(
ORDER BY SUM(revenue) DESC
) AS Revenue_Rank
FROM ecommerce_data
GROUP BY marketing_channel;



--Top Customers

SELECT
customer_id,
SUM(revenue) AS Revenue,
RANK() OVER(
ORDER BY SUM(revenue) DESC
) AS Customer_Rank
FROM ecommerce_data
GROUP BY customer_id
LIMIT 20;



--Customer Segmentation

SELECT
customer_id,
SUM(revenue) AS Total_Revenue,
CASE
WHEN SUM(revenue) >= 5000 THEN 'VIP'
WHEN SUM(revenue) >= 2000 THEN 'Regular'
ELSE 'Low Value'
END AS Customer_Segment
FROM ecommerce_data
GROUP BY customer_id;
