WITH seller_perf AS (
  SELECT
    oi.seller_id,
    COUNT(DISTINCT v.order_id) AS orders,
    ROUND(SUM(oi.price + oi.freight_value)::numeric, 2) AS revenue,
    ROUND(100.0 * SUM(CASE WHEN v.is_late = 1 THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(v.is_late),0), 2) AS late_pct,
    ROUND(AVG(v.review_score)::numeric, 2) AS avg_review
  FROM v_orders_12m v
  JOIN order_items oi ON oi.order_id = v.order_id
  GROUP BY oi.seller_id
)
SELECT *
FROM seller_perf
WHERE orders >= 30
ORDER BY late_pct DESC, revenue DESC
LIMIT 20;
