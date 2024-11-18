with base as (
    select 
        a.cart_id,
        a.name,
        sum(case when a.name in ('Milk','Yogurt') then 1 else 0 end) over (partition by a.cart_id) as temp
    from (
        select 
            distinct
            cart_id,
            name
        from 
            cart_products
    ) a
)
select 
    distinct
    cart_id
from 
    base
where
    temp = 2
order by 
    cart_id