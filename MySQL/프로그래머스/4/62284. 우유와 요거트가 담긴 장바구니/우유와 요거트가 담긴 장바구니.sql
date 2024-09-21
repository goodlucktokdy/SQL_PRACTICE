with base as (
select
    distinct
    cart_id,
    max(case when name = 'Yogurt' then 1 else 0 end) as yogurt,
    max(case when name = 'Milk' then 1 else 0 end) as milk
from
    cart_products
group by
    cart_id
)
select
    cart_id
from
    base
where
    yogurt + milk = 2