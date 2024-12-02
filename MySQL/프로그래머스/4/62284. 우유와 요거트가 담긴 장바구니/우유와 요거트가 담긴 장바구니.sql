with base as (
    select 
        a.cart_id,
        sum(case when a.name in ('Milk','Yogurt') then 1 else 0 end) as session
    from (
        select
            cart_id,
            name
        from 
            cart_products
        group by 
            1,2
    ) a
    group by 
        a.cart_id
    having 
        session = 2
)
select 
    distinct
    cart_id
from 
    base 
order by 
    cart_id