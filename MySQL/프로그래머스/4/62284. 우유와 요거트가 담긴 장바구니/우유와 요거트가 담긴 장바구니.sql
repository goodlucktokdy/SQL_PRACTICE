with base as (
    select
        distinct
        cart_id,
        name
    from 
        cart_products
    where
        name in ('Milk','Yogurt')
)
select
    a.cart_id
from (
    select
        cart_id,
        count(name) as cnts
    from 
        base
    group by 
        cart_id
    having
        count(name) = 2
) a
order by 
    a.cart_id