with base as (
    select
        id, cart_id,
        name,
        max(case when
                name = 'Milk' then 1 else 0 end) as Milk,
        max(case when
                name = 'Yogurt' then 1 else 0 end) as yogurt
    from
        cart_products
    group by
        cart_id
    having
        milk + yogurt = 2
)
select
    cart_id
from
    base
order by cart_id asc