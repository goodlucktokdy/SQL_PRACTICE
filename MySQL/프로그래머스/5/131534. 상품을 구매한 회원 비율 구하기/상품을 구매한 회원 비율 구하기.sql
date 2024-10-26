select
    year(b.sales_date) as year,
    month(b.sales_date) as month,
    count(distinct b.user_id) as purchased_users,
    round(count(distinct b.user_id)/(select count(distinct user_id) from user_info
                                    where year(joined) = 2021),1) as purchased_ratio
from
    user_info a
join
    online_sale b
on
    a.user_id = b.user_id
where
    year(a.joined) = 2021
group by
    year, month
order by 
    year, month