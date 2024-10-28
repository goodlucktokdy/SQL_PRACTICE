with base as (
    select
        category,
        rank() over (partition by category order by price desc) as ranking,
        price,
        product_name
    from 
        food_product
    where
        category in ('과자','국','김치','식용유')
 )
select 
    category,
    price as max_price,
    product_name
from 
    base 
where
    ranking = 1
order by 
    max_price desc