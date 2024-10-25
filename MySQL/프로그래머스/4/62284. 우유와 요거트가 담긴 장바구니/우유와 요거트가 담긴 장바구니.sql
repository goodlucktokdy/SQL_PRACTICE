-- 코드를 입력하세요
with base as (
    SELECT
        distinct
        cart_id,
        name,
        case when 
            name in ('Milk','Yogurt') then 1 else 0 end as temp
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
    sum(temp) = 2
order by 
    cart_id

