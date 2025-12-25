
select * from customer limit 20
--revenue difference based on gender
select gender, Sum(purchase_amount) as revenue
from customer
group by gender

--customer used a discount but still spent more than average purchase amount
select customer_id,purchase_amount
from customer
where discount_applied ='Yes' and purchase_amount>=(select AVG(purchase_amount)from customer)

--which are the top 5 products b