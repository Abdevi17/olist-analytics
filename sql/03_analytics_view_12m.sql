DROP VIEW IF EXISTS v_orders_12m;

CREATE VIEW v_orders_12m AS
WITH max_date AS (
  SELECT MAX(order_purchase_timestamp) AS max_purchase
  FROM orders
),
recent_orders AS (
  SELECT o.*
  FROM orders o
  CROSS JOIN max_date m
  WHERE o.order_purchase_timestamp >= (m.max_purchase - INTERVAL '12 months')
)
SELECT
  o.order_id,
  o.customer_id,
  o.order_status,
  o.order_purchase_timestamp::date AS purchase_date,
  DATE_TRUNC('month', o.order_purchase_timestamp)::date AS purchase_month,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,
  CASE
    WHEN o.order_delivered_customer_date IS NULL OR o.order_estimated_delivery_date IS NULL THEN NULL
    WHEN o.order_delivered_customer_date::date > o.order_estimated_delivery_date::date THEN 1
    ELSE 0
  END AS is_late,
  CASE
    WHEN o.order_delivered_customer_date IS NULL OR o.order_estimated_delivery_date IS NULL THEN NULL
    ELSE (o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date)
  END AS delivery_delay_days,
  r.review_score
FROM recent_orders o
LEFT JOIN reviews r ON r.order_id = o.order_id;
