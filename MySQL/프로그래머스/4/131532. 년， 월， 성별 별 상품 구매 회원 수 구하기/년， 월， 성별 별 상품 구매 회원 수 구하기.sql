select 
    year(a.sales_date) as year,
    month(a.sales_date) as month,
    b.gender,
    count(distinct a.user_id) as users
from 
    online_sale a
left join 
    user_info b 
on 
    a.user_id = b.user_id
group by 
    1,2,3
having 
    gender is not null
order by 
    year, month, gender
