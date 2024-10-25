select
    year(b.sales_date) as year,
    month(b.sales_date) as month,
    a.gender,
    count(distinct b.user_id) as users
from 
    user_info a
left join
    online_sale b
on 
    a.user_id = b.user_id
where
    year(b.sales_date) is not null and month(b.sales_date) is not null and gender is not null 
group by 
    1,2,3
having
    count(distinct b.user_id) > 0
