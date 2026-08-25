-- CREATE DATABASE supply_chain_db;
-- USE supply_chain_db;
-- alter table supply_chain_risk_analysis_dataset rename to supply_chain;


-- 1. What is the total number of orders?
select count(*) as total_orders
from supply_chain;

-- 2. How many orders were delayed?
select count(*) as delayed_orders
from supply_chain
where 'delayed' = 1;

-- 3. What is the overall delay rate?
select
		round(avg('delayed') * 100, 2) as delay_rate
from supply_chain;
        
-- 4. Which shipping method has the highest delay rate? 
select 
		shipping_method,
        count(*) as total_orders,
        sum('delayed') as dealyed_orders,
        round(avg('delayed') * 100 ,2) as delay_rate
from supply_chain
group by shipping_method
order by delay_rate desc;
        
-- Q5. Which weather condition causes the most delays?   
select 
		weather_condition,
        count(*) as total_orders,
        sum('delayed') as delayed_orders, 
        round(avg('delayed') * 100,2) as delay_rate
from supply_chain
group by weather_condition
order by delay_rate desc;

-- Q6. Which order priority has the highest delay rate?
select 
		order_priority,
		count(*) as total_orders,
        sum('delayed') as delayed_orders,
        round(avg('delayed') *100,2) as delay_rate
from supply_chain 
group by order_priority
order by delay_rate desc;

-- Q7. Does supplier reliability affect delays?
select
	case
		when supplier_reliability_score < 0.70 then 'low reliability'
        when supplier_reliability_score < 0.85 then 'medium reliability'
        else 'high reliability'
	end as supplier_group,
    count(*) as total_orders,
    round(avg('delayed') * 100,2) as delay_rate
    from supply_chain 
    group by supplier_group
    order by delay_rate desc;
    
-- Q8. Which risk category has the most orders?
SELECT
    `Risk Category`,
    COUNT(*) AS total_orders
FROM SUPPLY_CHAIN
GROUP BY `Risk Category`
ORDER BY total_orders DESC;

-- Q9. What is the average processing time for delayed vs on-time orders?
SELECT
    `Delay Status`,
    COUNT(*) AS total_orders,
    ROUND(AVG(processing_time_hours), 2) AS avg_processing_hours
FROM SUPPLY_CHAIN
GROUP BY `Delay Status`;

-- Q10. Which month has the highest delay rate?
select
	'month',
    count(*) as total_orders,
    round(avg('delayed') * 100, 2) as delay_rate
    from supply_chain 
    group by 'month'
    order by delay_rate desc;
select * from supply_chain;