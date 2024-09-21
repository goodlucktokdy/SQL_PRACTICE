with base as (
select
    distinct
    cart_id,
    case when
        name = 'Yogurt' then name else 0 end as Yogurt,
    case when
        name = 'Milk' then name else 0 end as Milk
from
    cart_products
)
select
    cart_id
from
    base
group by
    cart_id
having
    count(*) = 3

