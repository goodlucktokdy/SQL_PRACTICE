with base as(
    select
        a.sales_date,
        a.product_id,
        a.user_id,
        a.sales_amount
    from 
        online_sale a
    union all
    select
        b.sales_date,
        b.product_id,
        (select null) as user_id,
        b.sales_amount
    from
        offline_sale b
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
    sales_date, product_id, user_id