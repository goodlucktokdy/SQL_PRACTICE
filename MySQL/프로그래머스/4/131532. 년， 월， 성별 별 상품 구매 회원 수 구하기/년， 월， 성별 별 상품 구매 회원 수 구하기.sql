with base as (
    select
        year(a.sales_date) as year,
        month(a.sales_date) as month,
        b.gender,
        a.user_id
    from  
        online_sale a
    right join
        user_info b
    on 
        a.user_id = b.user_id
)
select
    year,
    month,
    gender,
    count(distinct user_id) as users
from 
    base
where 
    gender is not null and year is not null
group by 
    year, month, gender
order by 
    year asc, month asc, gender asc
    