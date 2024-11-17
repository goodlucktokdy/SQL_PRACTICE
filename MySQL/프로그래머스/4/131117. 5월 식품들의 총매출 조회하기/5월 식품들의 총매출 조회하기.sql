-- 코드를 입력하세요
with base as (
    SELECT
        a.product_id,
        a.produce_date,
        a.amount,
        b.product_name,
        b.price
    from 
        food_order a
    left join
        food_product b
    on 
        a.product_id = b.product_id
    where
        a.produce_date between '2022-05-01' and '2022-05-31'
)
select
    product_id,
    product_name,
    sum(amount * price) as total_sales
from 
    base
group by 
    product_id, product_name
having 
    total_sales is not null
order by 
    total_sales desc, product_id asc