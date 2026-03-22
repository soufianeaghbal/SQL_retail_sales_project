# Retail Sales Analysis SQL Project

## Project Overview
**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `project_1`

This project represents my first hands-on experience with SQL. I worked with a retail sales dataset to clean the data, explore it, and answer key business questions to better understand sales performance and customer behavior.

## Objectives
1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.  
2. **Data Cleaning**: Identify and remove any records with missing or null values.  
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.  
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure
### 1. Database Setup
- **Database Creation**: The project starts by creating a database named `project_1`.  
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE project_1;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transactions_id INT PRIMARY KEY,	
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

```
### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
    gender IS NULL OR age IS NULL OR category IS NULL OR
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR
    gender IS NULL OR age IS NULL OR category IS NULL OR
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

###

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'**:
```sql

select count(*) from retail_sales 
where sale_date = "2022-11-05";

```
2. **Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**:

```sql
SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND quantity >= 4
  AND MONTH(sale_date) = 11;

```
3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

```sql
select sum(total_sale) as net_sale, category,
count(*) as total_orders
from retail_sales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
select avg(age) as average_age, category 
from retail_sales 
group by category;

select avg(age) as average_age
from retail_sales 
where category = "beauty";
```
5. **Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
select count(transaction_id) as total_transactions from retail_sales where total_sale > 1000;
```


6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
select count(transactiont_id), gender, category from retail_sales 
group by gender, category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
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
```
8. **Write a SQL query to find the top 5 customers based on the highest total sales**:

```sql
select 
		customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;
```
9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
select 
count(distinct customer_id), category
from retail_sales
group by category;
```
10. **Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**:

```sql

select 
	case
    when hour(sale_time) <= 12 then "morning"
    when hour(sale_time) between 13 and 17 then "afternoon"
    when hour (sale_time) > 17 then "evening"
    end as shift,

count(*) as total_orders
from retail_sales
group by shift;
```
## Findings

- **Sales Distribution**: Sales are distributed across multiple product categories, showing differences in performance between categories.
- **High-Value Transactions**: The dataset includes transactions with total sales greater than 1000, indicating the presence of higher-value purchases.
- **Time-Based Patterns**: Sales activity varies across different times of the day (morning, afternoon, evening), highlighting shifts in customer purchasing behavior.
- **Customer Behavior**: The analysis identifies top customers based on total spending and shows how customers are distributed across categories.
- **Monthly Trends**: Average sales vary by month, helping highlight the best-performing periods within each year.

## Reports

- **Sales Overview**: Summary of total orders and overall sales performance across categories.
- **Category Performance**: Breakdown of sales and customer activity by product category.
- **Time Analysis**: Distribution of orders based on time of day (shift analysis).
- **Customer Analysis**: Identification of top customers and unique customer counts per category.

## Conclusion

This project represents my first SQL-based data analysis project, where I worked with a retail sales dataset to practice data cleaning, exploration, and answering business questions. It demonstrates my ability to use SQL to extract insights from data and understand key patterns such as sales trends, customer behavior, and category performance.
