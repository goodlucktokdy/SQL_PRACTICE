-- 코드를 입력하세요
with base as (
    select
        a.cart_id,
        a.name,
        sum(case when a.name in ('Milk','Yogurt') then 1 else 0 end) over (partition by cart_id) as temp_cnd
    from (
        SELECT
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
    temp_cnd = 2
order by 
    cart_id