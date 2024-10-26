select 
    year(b.sales_date) as year,
    month(b.sales_date) as month,
    count(distinct b.user_id) as purchased_customers,
    round(count(distinct b.user_id)/(select count(distinct user_id) from user_info where
     year(joined) = 2021),1) as purchased_ratio
from
    user_info a
left join 
    online_sale b
on 
    a.user_id = b.user_id
where
    year(a.joined) = 2021 and year(b.sales_date) is not null and month(b.sales_date) is not null
group by 
    1,2
order by 
    year asc,
    month asc 
    