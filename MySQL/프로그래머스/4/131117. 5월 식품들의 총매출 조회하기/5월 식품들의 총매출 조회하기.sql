select
    b.product_id,
    a.product_name,
    sum(a.price * b.amount) as TOTAL_SALES
from 
    food_product a 
left join 
    food_order b
on 
    a.product_id = b.product_id
where
    b.produce_date between '2022-05-01' and '2022-05-31'
group by 
    1,2
order by 
    TOTAL_SALES desc, product_id asc