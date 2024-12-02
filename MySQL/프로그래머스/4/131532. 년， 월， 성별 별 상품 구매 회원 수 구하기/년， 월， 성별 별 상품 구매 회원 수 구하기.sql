with base as (
    select
        a.user_id,
        a.gender,
        b.online_sale_id,
        b.sales_date
    from 
        user_info a 
    left join 
        online_sale b
    on 
        a.user_id = b.user_id
    where 
        b.online_sale_id is not null
)
select 
    year(sales_date) as year,
    month(sales_date) as month,
    gender,
    count(distinct user_id) as users
from 
    base 
where 
    gender is not null
group by 
    year, month, gender
order by 
    year, month, gender
