with base as (
    select 
        a.sales_date,
        a.user_id,
        b.joined
    from 
        online_sale a 
    left join 
        user_info b 
    on 
        a.user_id = b.user_id 
    where 
        year(b.joined) = 2021
)
,total_users_joined_2021 as (
    select
        count(distinct user_id) as total_users
    from 
        user_info
    where 
        year(joined) = 2021)
select 
    a.year,
    a.month,
    a.purchased_users,
    round(nullif(a.purchased_users/a.total_users,0),1) as purchased_ratio
from (
    select 
        year(a.sales_date) as year,
        month(a.sales_date) as month,
        count(distinct a.user_id) as purchased_users,
        b.total_users
    from 
        base a
    cross join 
        total_users_joined_2021 b
    group by 
        year, month
) a
order by 
    a.year asc, a.month asc