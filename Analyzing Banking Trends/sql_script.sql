use hicouncelor;

-- 1. List all regions along with the number of users assigned to each region.
select w.region_name, count(distinct u.consumer_id) as num_users
from world_regions as w
left join user_nodes as u
on w.region_id = u.region_id
group by 1;


-- 2) Find the user who made the largest deposit amount and the transaction type for that deposit.

select consumer_id , 
	transaction_type,
    transaction_amount 
from user_transaction 
where transaction_type = 'deposit' 
	and transaction_amount = (select max(transaction_amount) from user_transaction where transaction_type = 'deposit');
    
    
-- 3) Calculate the total amount deposited for each user in the "Europe" region.

select ut.consumer_id, sum(ut.transaction_amount)
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id and w.region_name = 'Europe'
join user_transaction as ut
on un.consumer_id = ut.consumer_id and ut.transaction_type = 'deposit'
group by 1;

-- 4) Calculate the total number of transactions made by each user in the "United States" region.

select ut.consumer_id, count(*)
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id and w.region_name = 'United States'
join user_transaction as ut
on un.consumer_id = ut.consumer_id
group by 1;


-- 5) Calculate the total number of users who made more than 5 transactions.
select consumer_id, count(*) as number_transaction
from user_transaction
group by 1
having count(*) > 5;

-- 6) Find the regions with the highest number of nodes assigned to them.

select w.region_name, count(un.node_id)
from user_nodes as un 
join world_regions as w
on un.region_id = w.region_id
group by 1
order by 2 desc;

-- 7) Find the user who made the largest deposit amount in the "Australia" region.

select distinct consumer_id, transaction_amount
from user_transaction 
where transaction_amount = (select max(ut.transaction_amount)
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id and w.region_name = 'Australia'
join user_transaction as ut
on un.consumer_id = ut.consumer_id and ut.transaction_type = 'deposit') and transaction_type = 'deposit';

-- 8) Calculate the total amount deposited by each user in each region.

select ut.consumer_id, w.region_name, sum(ut.transaction_amount)
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id 
join user_transaction as ut
on un.consumer_id = ut.consumer_id and ut.transaction_type = 'deposit'
group by 1,2 ;

-- 9) Retrieve the total number of transactions for each region
select w.region_name, count(*) as total_transaction
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id 
join user_transaction as ut
on un.consumer_id = ut.consumer_id
group by 1 ;

/* 10) Write a query to find the total deposit amount for each region (region_name) in the user_transaction table.
 Consider only those transactions where the consumer_id is associated with a valid region in the user_nodes table. 
*/
select w.region_name, sum(ut.transaction_amount) as total_transaction
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id 
join user_transaction as ut
on un.consumer_id = ut.consumer_id and ut.transaction_type = 'deposit'
group by 1 ;

/* 11) Write a query to find the top 5 consumers who have made the highest total transaction amount 
(sum of all their deposit transactions) in the user_transaction table. */

select consumer_id, sum(transaction_amount) as total_amount
from user_transaction
where transaction_type = 'deposit'
group by 1
order by 2 desc
limit 5;

-- 12) How many consumers are allocated to each region?

select w.region_id, w.region_name, count(distinct ut.consumer_id) as total_user
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id 
join user_transaction as ut
on un.consumer_id = ut.consumer_id
group by 1,2 ;

--  13) What is the unique count and total amount for each transaction type?
select transaction_type, 
	count(distinct consumer_id) as unique_count, 
    sum(transaction_amount) as total_sum
from user_transaction
group by 1;

-- 14) What are the average deposit counts and amounts for each transaction type ('deposit') across all customers, grouped by transaction type?
 
 with t1 as (
 select consumer_id,transaction_type,
 count(*) as total_count,
 sum(transaction_amount) as total_amount
 from user_transaction
 where transaction_type = 'deposit'
 group by 1)

select transaction_type, round(avg(total_count)) as unique_count,
	round(avg(total_amount)) as total_amount
from t1
group by 1;

-- 15) How many transactions were made by consumers from each region?
select w.region_name, count(*) as total_transaction
from user_nodes as un
join world_regions as w
on un.region_id = w.region_id 
join user_transaction as ut
on un.consumer_id = ut.consumer_id
group by 1 ;


-- THE END -----
 
 
 
 












