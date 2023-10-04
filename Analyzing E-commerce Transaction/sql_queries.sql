use hicouncelor;

-- Task 2: What are the unique brands available in the dataset?

SELECT DISTINCT brand FROM `cleaned_dataset_cohort`;

-- Task 3: How many unique customers made transactions in the dataset?

SELECT COUNT(DISTINCT customer_id) FROM cleaned_dataset_cohort;

-- Task 4: How many transactions were approved and how many were not approved?

select (select count(order_status) from cleaned_dataset_cohort where order_status = 'Approved')as approved_transaction ,(select count(order_status) from cleaned_dataset_cohort where order_status = 'Cancelled') as unapproved_transactions ;

-- Task 5: List the top product lines with the highest average list price
select product_line, avg(list_price) as average_list_price
from cleaned_dataset_cohort
group by 1
order by 2 desc;

-- Task 6: List the product_id, list_price, and standard_cost of the products where the list_price is greater than twice the standard_cost.¶
select product_id, list_price, standard_cost
from cleaned_dataset_cohort
where list_price >= 2 * standard_cost;

-- Task 7: Calculate the average list_price for each product_line.

select product_line, avg(list_price) as average_list_price
from cleaned_dataset_cohort
group by 1;

-- Task 8: Which brand has the maximum difference between the list_price and standard_cost for their products?

select brand, max(list_price - standard_cost) as price_margin
from cleaned_dataset_cohort
group by brand
order by 2 desc
limit 1;

-- Task 9: List the customer_id and the count of their transactions, ordered by the number of transactions in descending order.
select customer_id, count(transaction_id) as transaction_count
from cleaned_dataset_cohort
group by 1
order by 2 desc;

-- Task 10: Find the total sales amount for each brand, sorted in descending order of total sales.
select brand, sum(list_price) as total_sales
from cleaned_dataset_cohort
group by 1
order by 2 desc;

-- Task 11: What are the top 5 products with the highest profit margin.
select distinct product_id, brand, product_line, list_price - standard_cost as profit_margin
from cleaned_dataset_cohort
order by 4 desc
limit 5;

-- Task 12: For each customer, find the total number of transactions, the total amount they spent, and their average profit per transaction

select customer_id, count(distinct transaction_id) as total_transactions
    , sum(list_price) as total_amount_spend
    , avg(list_price) - avg(standard_cost) as average_profit_per_transaction
from cleaned_dataset_cohort
group by 1
order by 1;

-- Task 13: Find the top 5 product lines with the highest total revenue and their percentage contribution to the overall revenue.
select product_line, sum(list_price) as total_revenue,
    sum(list_price) / (select sum(list_price) from cleaned_dataset_cohort) * 100 as revenue_contibution_percent
from cleaned_dataset_cohort
group by 1
order by 2 desc
limit 5;

-- Task 14: Identify the customers who have made at least one transaction for each product line available

select customer_id
from cleaned_dataset_cohort
group by customer_id
having count(distinct product_line) = (select count(distinct product_line) from cleaned_dataset_cohort);
