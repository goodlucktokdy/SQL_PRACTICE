with base as (
select
    category,
    max(price) as max_price
from 
    food_product
where
    category in ('과자','국','김치','식용유')    
group by 
    category
)
select 
    a.category,
    a.max_price,
    b.product_name
from 
    base a 
join 
    food_product b
on
    a.category = b.category
where
    b.price = a.max_price
order by 
    a.max_price desc