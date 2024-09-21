select
    a.product_id,
    a.product_name,
    sum(a.price * b.amount) as total_sales
from
    food_product a
left join
    food_order b
on
    a.product_id = b.product_id
where
    b.produce_date between '2022-05-01' and '2022-05-31'
group by    
    a.product_id
order by
    total_sales desc, product_id asc
