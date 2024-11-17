with base as (
    select
        a.online_sale_id,
        a.user_id,
        b.gender,
        a.sales_date
    from 
        online_sale a
    left join 
        user_info b
    on 
        a.user_id = b.user_id
    where
        b.gender is not null
)
select 
    year(sales_date) as year,
    month(sales_date) as month,
    gender,
    count(distinct user_id) as users
from 
    base
group by 
    year, month, gender
order by 
    year, month, gender