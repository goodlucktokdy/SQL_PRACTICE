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
    sales_amount
from 
    base 
where 
    date_format(sales_date,'%Y-%m') = '2022-03'
order by 
    sales_date asc, product_id asc, user_id asc
