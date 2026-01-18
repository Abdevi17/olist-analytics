-- Late delivery rate
SELECT
  COUNT(*) AS total_orders,
  COUNT(is_late) AS orders_with_delivery_info,
  SUM(is_late) AS late_orders,
  ROUND(100.0 * SUM(is_late)::numeric / NULLIF(COUNT(is_late),0), 2) AS late_delivery_pct
FROM v_orders_12m;

-- Review score vs late delivery
SELECT
  is_late,
  COUNT(*) AS orders,
  ROUND(AVG(review_score)::numeric, 2) AS avg_review_score,
  ROUND(100.0 * SUM(CASE WHEN review_score IN (1,2) THEN 1 ELSE 0 END)::numeric / COUNT(*), 2) AS pct_low_reviews
FROM v_orders_12m
WHERE review_score IS NOT NULL AND is_late IS NOT NULL
GROUP BY is_late
ORDER BY is_late;

-- Monthly revenue + AOV (price + freight)
WITH items_12m AS (
  SELECT
    v.purchase_month,
    oi.order_id,
    (oi.price + oi.freight_value) AS item_revenue
  FROM v_orders_12m v
  JOIN order_items oi ON oi.order_id = v.order_id
)
SELECT
  purchase_month,
  ROUND(SUM(item_revenue)::numeric, 2) AS total_revenue,
  COUNT(DISTINCT order_id) AS orders,
  ROUND(SUM(item_revenue)::numeric / NULLIF(COUNT(DISTINCT order_id),0), 2) AS aov
FROM items_12m
GROUP BY purchase_month
ORDER BY purchase_month;
