-- Retail Operations Intelligence Dashboard
-- SQL analysis queries for portfolio project
-- Dataset: data/retail_operations_sample.csv

-- 1. Monthly sales and profit trend
SELECT 
  DATE_TRUNC('month', order_date) AS month,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS profit_margin_pct
FROM retail_orders
GROUP BY 1
ORDER BY 1;

-- 2. Product categories ranked by revenue and profitability
SELECT
  category,
  SUM(units_sold) AS units_sold,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS margin_pct
FROM retail_orders
GROUP BY category
ORDER BY total_sales DESC;

-- 3. Stockout risk by category
SELECT
  category,
  COUNT(*) AS order_lines,
  SUM(stockout_flag) AS stockout_risk_count,
  ROUND(AVG(stockout_flag) * 100, 2) AS stockout_risk_rate,
  ROUND(AVG(processing_hours), 2) AS avg_processing_hours
FROM retail_orders
GROUP BY category
ORDER BY stockout_risk_rate DESC;

-- 4. Fulfillment mode performance
SELECT
  fulfillment_mode,
  COUNT(*) AS orders,
  ROUND(AVG(processing_hours), 2) AS avg_processing_hours,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM retail_orders
GROUP BY fulfillment_mode
ORDER BY avg_processing_hours ASC;

-- 5. Discount impact on profitability
SELECT
  discount,
  COUNT(*) AS order_lines,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS margin_pct
FROM retail_orders
GROUP BY discount
ORDER BY discount;
