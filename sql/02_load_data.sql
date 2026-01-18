\copy orders FROM 'C:\Projects\olist-analytics\data\raw\olist_orders_dataset.csv' CSV HEADER;
\copy order_items FROM 'C:\Projects\olist-analytics\data\raw\olist_order_items_dataset.csv' CSV HEADER;
\copy payments FROM 'C:\Projects\olist-analytics\data\raw\olist_order_payments_dataset.csv' CSV HEADER;
\copy customers FROM 'C:\Projects\olist-analytics\data\raw\olist_customers_dataset.csv' CSV HEADER;
\copy products FROM 'C:\Projects\olist-analytics\data\raw\olist_products_dataset.csv' CSV HEADER;
\copy sellers FROM 'C:\Projects\olist-analytics\data\raw\olist_sellers_dataset.csv' CSV HEADER;

-- reviews needs encoding fix on Windows
TRUNCATE TABLE reviews;
\copy reviews FROM 'C:\Projects\olist-analytics\data\raw\olist_order_reviews_dataset.csv' CSV HEADER ENCODING 'LATIN1';
