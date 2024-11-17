with base as (
    select 
        a.user_id,
        a.joined,
        b.sales_date
    from 
        user_info a
    left join 
        online_sale b
    on 
        a.user_id = b.user_id
    where
        year(a.joined) = 2021
)
,joined_2021_total as (
    select 
        count(distinct user_id) as total_users_joined_2021
    from 
        base
)
select 
    year(a.sales_date) as year,
    month(a.sales_date) as month,
    count(distinct a.user_id) as purchased_users,
    round(count(distinct a.user_id)/b.total_users_joined_2021,1) as purchased_ratio
from 
    base a
cross join
    joined_2021_total b
group by 
    year, month
having
    year is not null
order by 
    year, month