import pandas as pd
import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns

# --- DB CONNECTION ---
conn = psycopg2.connect(
    host="localhost",
    database="olist_analytics",
    user="postgres",
    password="Analyst17@"  # replace
)

# --- LOAD ANALYTICS VIEW ---
query = """
SELECT
  purchase_date,
  purchase_month,
  is_late,
  delivery_delay_days,
  review_score
FROM v_orders_12m
WHERE review_score IS NOT NULL
  AND is_late IS NOT NULL;
"""

df = pd.read_sql(query, conn)

print(df.head())
print(df.shape)

#/question1/#

df.groupby("is_late")["review_score"].agg(
    orders="count",
    avg_review="mean"
).reset_index()

sns.boxplot(x="is_late", y="review_score", data=df)
plt.xticks([0,1], ["On-time", "Late"])
plt.title("Review Score Distribution: On-time vs Late Deliveries")
plt.xlabel("Delivery Status")
plt.ylabel("Review Score")
plt.show()

#/question2/#

delay_df = df[df["delivery_delay_days"] >= 0]

sns.scatterplot(
    x="delivery_delay_days",
    y="review_score",
    data=delay_df,
    alpha=0.3
)
plt.title("Delivery Delay vs Review Score")
plt.xlabel("Delivery Delay (days)")
plt.ylabel("Review Score")
plt.show()

#correlation#
delay_df[["delivery_delay_days", "review_score"]].corr()

#/question3/#

rev_query = """
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
  SUM(item_revenue) AS revenue
FROM items_12m
GROUP BY purchase_month
ORDER BY purchase_month;
"""

rev_df = pd.read_sql(rev_query, conn)

sns.lineplot(x="purchase_month", y="revenue", data=rev_df)
plt.title("Monthly Revenue Trend (Last 12 Months)")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.show()
