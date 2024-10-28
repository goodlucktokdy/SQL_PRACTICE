with base as (
    select
        sales_date,
        product_id,
        user_id,
        sales_amount
    from 
        online_sale
    union all
    select
        sales_date,
        product_id,
        null as user_id,
        sales_amount
    from 
        offline_sale
)
select
    date_format(sales_date,'%Y-%m-%d') as sales_date,
    product_id,
    user_id,
    sum(sales_amount) as sales_amount
from 
    base
where
    sales_date between '2022-03-01' and '2022-03-31'
group by 
    sales_date, product_id, user_id
order by 
    sales_date, product_id, user_id
