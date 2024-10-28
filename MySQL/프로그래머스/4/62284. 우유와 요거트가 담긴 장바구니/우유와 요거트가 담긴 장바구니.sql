with base as (
    select
        distinct
        cart_id,
        name
    from 
        cart_products
)
select
    a.cart_id
from (
    select 
        cart_id,
        sum(case when 
            name in ('Yogurt','Milk') then 1 else 0 end) as tmp
    from 
        base
    group by 
        1
    having
        tmp = 2
) a
order by 
    cart_id