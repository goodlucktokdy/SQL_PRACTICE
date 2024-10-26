with base as (
    select
        a.cart_id,
        sum(case when a.name in ('Yogurt','Milk') then 1 else 0 end) over (partition by a.cart_id) as cnts,
        a.name
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
    cnts = 2
order by 
    cart_id