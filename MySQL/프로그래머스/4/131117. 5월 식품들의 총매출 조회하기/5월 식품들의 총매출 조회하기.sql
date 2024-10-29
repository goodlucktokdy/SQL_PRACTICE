select
    a.product_id,
    b.product_name,
    sum(a.amount * b.price) as total_sales
from 
    food_order a 
left join 
    food_product b
on 
    a.product_id = b.product_id
where
    a.produce_date between '2022-05-01' and '2022-05-31'
group by 
    1,2
having 
    product_name is not null
order by 
    total_sales desc, a.product_id asc