with base as (
select
    a.user_id,
    a.sales_date,
    b.gender
from 
    online_sale a
left join 
    user_info b
on 
    a.user_id = b.user_id
)
select
    year(sales_date) as year,
    month(sales_date) as month,
    gender,
    count(distinct user_id) as users
from 
    base 
group by 
    1,2,3
having
    gender is not null
order by 
    1,2,3