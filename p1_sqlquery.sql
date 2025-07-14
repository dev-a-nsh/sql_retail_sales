CREATE DATABASE sql_project_1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
-- Data cleaning And Data Exploration

select * from retail_sales WHERE transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR gender IS NULL OR category IS NULL OR 
quantity IS NULL OR cogs IS NULL OR  total_sale IS NULL ;

DELETE FROM retail_sales WHERE transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR gender IS NULL OR category IS NULL OR 
quantity IS NULL OR cogs IS NULL OR  total_sale IS NULL ;

SELECT COUNT(*) FROM retail_sales;

select * from retail_sales WHERE transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR gender IS NULL OR category IS NULL OR 
quantity IS NULL OR cogs IS NULL OR  total_sale IS NULL ;

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;


-- DATA ANALYSIS

--1) How many sales we have?
SELECT COUNT(*) as total_Sales FROM retail_sales;

--2) How many customers we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- 3) How many categories we have?
SELECT COUNT(DISTINCT category) FROM retail_sales;

-- 4) What are various categories we have?
SELECT DISTINCT category FROM retail_sales;

-- DATA ANALYSIS 

--1) Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales WHERE sale_date = '2022-11-05';

--2)Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022:
SELECT * FROM retail_sales WHERE category = 'Clothing' AND  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity > 2 ;

--3) Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT DISTINCT category , SUM(total_sale) , COUNT(*) AS Total_Orders FROM retail_sales GROUP BY category;

--4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age)) FROM retail_sales WHERE category = 'Beauty';

--5) Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales WHERE total_sale > 1000;

--6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category , gender , COUNT(transactions_id) AS total_transaction FROM retail_sales GROUP BY gender , category;

--7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,month,avg_sale FROM 
	  ( SELECT 
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT (MONTH FROM sale_date) AS month,
		AVG(total_sale) as avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC) as rank
	    FROM retail_sales  GROUP BY 1 , 2 ) as t1
WHERE rank = 1 ;

--8) Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id , SUM(total_sale) FROM retail_sales GROUP BY customer_id ORDER BY 2 LIMIT 5;

--9) Write a SQL query to find the number of unique customers who purchased items from each category
SELECT category , COUNT(DISTINCT customer_id) FROM retail_sales GROUP BY category;

--10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT 
CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift , COUNT(transactions_id) 
	FROM retail_sales GROUP BY shift;

