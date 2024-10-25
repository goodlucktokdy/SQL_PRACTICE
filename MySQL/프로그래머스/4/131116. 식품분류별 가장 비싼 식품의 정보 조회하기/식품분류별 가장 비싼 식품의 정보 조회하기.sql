with base as (
    select
        category,
        dense_rank() over (partition by category order by price desc) as price_rank,
        price,
        product_name
    from 
        food_product
    where
        category in ('과자','국','김치','식용유')
)
select
    category,
    price as MAX_PRICE,
    product_name
from 
    base 
where
    price_rank = 1
order by 
    max_price desc