with users as (
    select 
        user_id,
        gender,
        age,
        joined
    from 
        user_info
    where 
        year(joined) = 2021 
)
, sales_info as (
    select 
        a.user_id,
        b.online_sale_id,
        b.sales_date
    from 
        users a 
    left join 
        online_sale b
    on 
        a.user_id = b.user_id
)
select 
    year(sales_date) as year,
    month(sales_date) as month,
    count(distinct user_id) as purchased_users,
    round(coalesce(count(distinct user_id)/(select count(distinct user_id) from users),0),1) as purchased_ratio 
from 
    sales_info
where 
    sales_date is not null 
group by 
    year, month
order by
    year asc, month asc