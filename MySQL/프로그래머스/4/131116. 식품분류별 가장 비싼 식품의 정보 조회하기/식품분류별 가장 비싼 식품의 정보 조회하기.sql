with base as (
    select 
        distinct
        category,
        product_name,
        price,
        dense_rank() over (partition by category order by price desc) as cat_price_rank
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
    cat_price_rank = 1
order by 
    price desc
    