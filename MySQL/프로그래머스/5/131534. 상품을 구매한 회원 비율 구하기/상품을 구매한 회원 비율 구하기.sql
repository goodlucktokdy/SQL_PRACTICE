with base as (
    select
        distinct
        user_id
    from 
        user_info
    where
        year(joined) = 2021
)
select
    year(sales_date) as year,
    month(sales_date) as month,
    count(distinct user_id) as purchased_users,
    coalesce(round(count(distinct user_id)/(select count(distinct user_id) from base),1),0) as purchased_ratio
from 
    online_sale a
where
    user_id in (select * from base)
group by 
    year, month
order by 
    year asc, month asc