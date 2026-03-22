-- ============================================
-- Retail Sales Analysis SQL Project
-- ============================================

-- Project Overview
-- Project Title: Retail Sales Analysis
-- Level: Beginner
-- Database: p1_retail_db

-- This project is designed to demonstrate SQL skills and techniques typically used by data analysts 
-- to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, 
-- performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 
-- This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

-- ============================================
-- Objectives
-- ============================================

-- Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
-- Data Cleaning: Identify and remove any records with missing or null values.
-- Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
-- Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

-- ============================================
-- 1. Database Setup
-- ============================================

-- Database Creation
CREATE DATABASE p1_retail_db;

-- Table Creation
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

ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

SELECT * FROM retail_sales;

ALTER TABLE retail_sales
RENAME COLUMN transactions_id TO transaction_id;

SELECT * FROM retail_sales;

-- ============================================
-- 2. Data Exploration & Cleaning
-- ============================================

-- Record Count
SELECT COUNT(*) FROM retail_sales;

-- Customer Count
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

-- Category Count
SELECT DISTINCT category FROM retail_sales;

-- Null Value Check
SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- Delete Null Records
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- ============================================
-- 3. Data Analysis & Findings
-- ============================================

-- Q1: Sales on '2022-11-05
SELECT COUNT(*) 
FROM retail_sales 
WHERE sale_date = "2022-11-05";

-- Q2: Clothing transactions, quantity >= 4, Nov-2022
SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND quantity >= 4
  AND MONTH(sale_date) = 11;

-- Q3: Total sales by category
SELECT 
    SUM(total_sale) as net_sale, 
    category,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q4: Average age (Beauty category)
SELECT AVG(age) as average_age, category 
FROM retail_sales 
GROUP BY category;

SELECT AVG(age) as average_age
FROM retail_sales 
WHERE category = "beauty";

-- Q5: Transactions with total_sale > 1000
SELECT COUNT(transaction_id) as total_transactions 
FROM retail_sales 
WHERE total_sale > 1000;

-- Q6: Transactions by gender and category
SELECT COUNT(transaction_id), gender, category 
FROM retail_sales 
GROUP BY gender, category;

-- Q7: Best selling month each year
SELECT 
      year,
      month,
      average_sale
FROM 
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
WHERE ranking =1;

-- Q8: Top 5 customers
SELECT 
	customer_id, 
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9: Unique customers per category
SELECT 
COUNT(DISTINCT customer_id), 
category
FROM retail_sales
GROUP BY category;

-- Q10: Sales by shift
SELECT 
	case
    when hour(sale_time) <= 12 then "morning"
    when hour(sale_time) between 13 and 17 then "afternoon"
    when hour (sale_time) > 17 then "evening"
    end as shift,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY shift;

-- ============================================
-- Findings
-- ============================================

-- Customer Demographics: The dataset includes customers from various age groups, 
-- with sales distributed across different categories such as Clothing and Beauty.

-- High-Value Transactions: Several transactions had a total sale amount greater than 1000, 
-- indicating premium purchases.

-- Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.

-- Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

-- ============================================
-- Reports
-- ============================================

-- Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.

-- Trend Analysis: Insights into sales trends across different months and shifts.

-- Customer Insights: Reports on top customers and unique customer counts per category.

-- ============================================
-- Conclusion
-- ============================================

-- This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, 
-- data cleaning, exploratory data analysis, and business-driven SQL queries.

-- ============================================
-- How to Use
-- ============================================

-- Clone the Repository
-- Set Up the Database
-- Run the Queries
-- Explore and Modify

-- ============================================
-- Author
-- ============================================

-- Zero Analyst
