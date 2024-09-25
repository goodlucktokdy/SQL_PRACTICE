select
    a.product_id,
    b.product_name,
    sum(a.amount*b.price) as total_sales
from
    food_order a
left join
    food_product b
on
    a.product_id = b.product_id
where
    date(a.produce_date) between '2022-05-01' and '2022-05-31'
    and b.price is not null
group by
    b.product_id,b.product_name
order by
    total_sales desc, product_id asc