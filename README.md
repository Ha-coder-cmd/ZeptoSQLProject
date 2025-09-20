# ZeptoSQLProject

📊 Zepto SQL Data Analysis

This repository contains SQL queries and analysis performed on the Zepto dataset. The study involves data cleaning, transformation, and insights extraction using SQL.

🗂 Database Setup
USE zeptoproject;
SHOW TABLES;
SELECT * FROM zepto;

🔑 Schema Updates

Added a primary key column:

ALTER TABLE zepto ADD COLUMN sku_id INT PRIMARY KEY AUTO_INCREMENT;


Renamed name column to P_Name:

ALTER TABLE zepto RENAME COLUMN name TO P_Name;

🔍 Data Quality Checks

Checking for NULL values:

SELECT * FROM zepto 
WHERE P_Name IS NULL
   OR Category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;


Identify products with price = 0:

SELECT * FROM zepto 
WHERE mrp=0 OR discountedSellingPrice=0;


Remove invalid entry:

DELETE FROM zepto WHERE sku_id=3714;


Convert Paise → Rupees:

SET SQL_SAFE_UPDATES = 0;
UPDATE zepto 
SET mrp = mrp / 100,
    discountedSellingPrice = discountedSellingPrice / 100;

📊 Exploratory Queries
1️⃣ Different Product Categories
SELECT DISTINCT(Category) FROM zepto;

2️⃣ Stock Status
SELECT SUM(quantity) AS Total_Quantity, outOfStock
FROM zepto 
GROUP BY outOfStock;

3️⃣ Duplicate Product Names
SELECT COUNT(sku_id) AS Number_of_SKUS, P_Name
FROM zepto
GROUP BY P_Name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

4️⃣ Top 10 Best-Valued Products
SELECT DISTINCT(P_Name), discountPercent, mrp
FROM zepto 
ORDER BY discountPercent DESC
LIMIT 10;

5️⃣ High MRP but Out of Stock
SELECT DISTINCT(P_Name), mrp
FROM zepto
WHERE outOfStock = "TRUE" AND mrp > 300
ORDER BY mrp DESC;

6️⃣ Estimated Revenue per Category
SELECT SUM(discountedSellingPrice * availableQuantity) AS Revenue_Per_Category,
       Category
FROM zepto
GROUP BY Category
ORDER BY Revenue_Per_Category DESC;

7️⃣ Expensive but Low Discount Products
SELECT DISTINCT(P_Name), mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

8️⃣ Categories with Highest Average Discount
SELECT AVG(discountPercent) AS Average_Discount, Category
FROM zepto
GROUP BY Category
ORDER BY Average_Discount DESC
LIMIT 5;

9️⃣ Price per Gram Analysis
SELECT DISTINCT(P_Name), (discountedSellingPrice / weightInGms) AS Price_Per_Gram
FROM zepto
WHERE weightInGms > 100
ORDER BY Price_Per_Gram ASC;

🚀 Key Insights

Cleaned and standardized pricing data (from paise to rupees).

Identified duplicate products and anomalies with zero pricing.

Found top categories by revenue and discount levels.

Extracted best-valued products based on discounts.

Analyzed stock availability vs. pricing strategy.

📌 Next Steps

Build Power BI / Tableau dashboards from cleaned data.

Perform predictive analysis on pricing vs. demand.

Automate ETL process for continuous updates.

✨ This SQL study helps uncover insights into Zepto’s product pricing, discounts, stock availability, and revenue distribution.
