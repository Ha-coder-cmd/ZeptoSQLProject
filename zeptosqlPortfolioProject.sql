
use zeptoproject;
show tables;
select * from zepto;
-- add Primary_Key Column
alter table zepto add column sku_id int primary key auto_increment;
select count(*) from zepto;
-- alter name column in zepto
alter table zepto rename column name to P_Name;
-- sample data
select * from zepto limit 10;

-- checking for null values
select * from zepto where 
P_Name is null
OR Category is null
 OR mrp is null
 OR discountPercent is null
 OR availableQuantity is null
 OR discountedSellingPrice is null
 OR weightInGms is null
 OR outOfStock is null
 OR quantity is null;
 
 
 -- different product categories
 select distinct(Category) from zepto;
 
 
 -- products in stock vs out of stock
 select sum(quantity) as Total_Quantity, outOfStock
 from zepto 
 group by outOfStock;
 
 -- product_name present multiple times
 select count(sku_id) as Number_of_SKUS, P_Name
 from zepto
 group by P_Name
 having count(sku_id)>1
 order by count(sku_id) desc;
 
 -- data cleaning
 -- check where products price = 0
 select * from zepto 
 where mrp=0 OR discountedSellingPrice=0;
 
 -- cleaning the product where mrp =0 and discountedSellingPrice=0 as it is impossible
 delete from zepto where sku_id=3714;
 
 SET SQL_SAFE_UPDATES = 0;
 -- convert paise into rupees 
 update zepto 
 set mrp=mrp/100,
 discountedSellingPrice=discountedSellingPrice/100; 
 select mrp,discountedSellingPrice from zepto;


-- find the top 10 best valued products based on discountPercent
select 
distinct(P_Name),discountPercent,mrp
from zepto order by
discountPercent desc
limit 10 ;

-- what are products with high MRP But out of stock
select distinct(p_name),mrp
from zepto
where outOFStock="TRUE" and mrp>300
order by mrp desc;

-- calculated estimated revenue for each category=



select 
sum(discountedSellingPrice*availableQuantity)as Revenue_Per_Category
,Category 
from zepto
 group by Category
 order by Revenue_Per_Category 
 desc;
 
 -- find products where mrp >500 and discount <10
 
 select distinct(p_name),mrp,discountPercent 
 from zepto
 where mrp>500 and discountPercent<10
 order by mrp desc,discountpercent desc;
 
 -- Identify top 5 categories offering highest average discount_percentage
 select avg(discountPercent) as Average_Discount,Category
 from zepto
 group by Category
 order by Average_Discount desc limit 5;
 
 -- find the price per gram for products above 100 gm and sort by best_value
 select * from zepto;
 select distinct(P_Name),(DiscountedSellingPrice/weightInGms) as Price_Per_Gram
 from zepto
 where (DiscountedSellingPrice/weightInGms)>=100