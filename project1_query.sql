-- My first project "Retail Sales Analysis"
CREATE DATABASE sql_project_p2;


-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantiy	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

Alter table retail_sales
rename column quantiy to quantity; 
SELECT * FROM retail_sales;

alter table retail_sales
rename column transactions_id to transaction_id;
select* from retail_sales;


-- importing dataset from detail_sales.csv and moving to data cleaning


SELECT 
    COUNT(*) 
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    

DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have "total_orders"?
SELECT COUNT(*) as total_orders FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;



SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select count(*) from retail_sales 
where sale_date = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold 
-- is more than 10 in the month of Nov-2022

SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND quantity >= 4
  AND MONTH(sale_date) = 11;
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(total_sale) as net_sale, category,
count(*) as total_orders
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) as average_age, category 
from retail_sales 
group by category;

select avg(age) as average_age
from retail_sales 
where category = "beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select count(transaction_id) as total_transactions from retail_sales where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transactiont_id), gender, category from retail_sales 
group by gender, category;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
      year,
      month,
      average_sale
from 
(
	SELECT 
		AVG(total_sale) AS average_sale, 
		MONTH(sale_date) AS month, 
		YEAR(sale_date) AS year, 
		RANK() OVER (
			PARTITION BY YEAR(sale_date)
			ORDER BY AVG(total_sale) DESC
		) AS ranking
	FROM retail_sales
	GROUP BY MONTH(sale_date), YEAR(sale_date)
) as t1
where ranking =1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
		customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
count(distinct customer_id), category
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


select 
	case
    when hour(sale_time) <= 12 then "morning"
    when hour(sale_time) between 13 and 17 then "afternoon"
    when hour (sale_time) > 17 then "evening"
    end as shift,

count(*) as total_orders
from retail_sales
group by shift;
