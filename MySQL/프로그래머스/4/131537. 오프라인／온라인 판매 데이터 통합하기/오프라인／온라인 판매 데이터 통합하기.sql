with base as (
    select 
        user_id,
        product_id,
        sales_amount,
        sales_date
    from 
        online_sale
    union all 
    select 
        null as user_id,
        product_id,
        sales_amount,
        sales_date
    from 
        offline_sale
)
select 
    date_format(sales_date,'%Y-%m-%d') as sales_date,
    product_id,
    user_id,
    sales_amount
from 
    base
where 
    sales_date between '2022-03-01' and '2022-03-31'
order by 
    sales_date asc, product_id asc, user_id asc
    