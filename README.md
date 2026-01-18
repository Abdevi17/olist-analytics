Project Overview

This project analyzes delivery performance and customer satisfaction for a multi-seller e-commerce marketplace using real-world data. The goal is to identify how delivery delays impact customer reviews and revenue, and to propose data-driven business actions.

The analysis mirrors real Data Analyst work: business framing → SQL modeling → Python analysis → insights → recommendations.

Business Problem

What impact do delivery delays have on customer satisfaction and revenue? What operational improvements should the business focus on in order to sustain growth?

Leadership observed slowing revenue growth alongside increasing customer complaints. This project uses historical order, delivery, and review data to quantify the impact of delivery performance.

Scope & Assumptions

Time period: Most recent 12 months available in the dataset

Late delivery definition: Delivered after estimated delivery date

Revenue proxy: Price + freight value

Focus priorities:

Revenue growth

Customer satisfaction

Tech Stack

PostgreSQL – data modeling & KPI aggregation

SQL – joins, CTEs, window-style aggregations

Python (Pandas, Matplotlib, Seaborn) – analysis & visualization

VS Code – development

Dataset

OLIST Brazilian E-Commerce Dataset (multi-table, real marketplace data)

Tables used:

orders

order_items

payments

reviews

customers

products

sellers

Key KPIs

Revenue & Growth

Total revenue

Monthly revenue trend

Average Order Value (AOV)

Delivery Performance

Late delivery rate (%)

Delivery delay (days)

Customer Satisfaction

Average review score

Review distribution (on-time vs late)

Analysis Process

Built a 12-month analytics view in PostgreSQL

Engineered delivery delay and late-delivery indicators

Aggregated KPIs using SQL

Validated insights using Python visualizations

Translated findings into business recommendations

Key Findings

Late deliveries are consistently associated with lower customer review scores

On-time deliveries show higher and more stable satisfaction

Even short delivery delays increase the likelihood of low ratings

Revenue shows seasonal patterns rather than steady growth

Business Recommendations

Reduce delivery delays to improve customer satisfaction

Track delivery KPIs as leading indicators of revenue health

Incorporate delivery performance into seller evaluations

Proactively address logistics bottlenecks

Visual Highlights

📌 Delivery Delay vs Review Score (Python)

📌 Review Score Distribution: On-time vs Late Deliveries

📌 Monthly Revenue Trend (Last 12 Months)

(See /outputs or /figures folder for charts)

What I’d Do Next

Build an executive dashboard (Power BI / Tableau)

Perform seller-level and regional analysis

Add predictive monitoring for late deliveries

Author

Vijay Kuruba
Data Analyst | SQL | Python | Analytics