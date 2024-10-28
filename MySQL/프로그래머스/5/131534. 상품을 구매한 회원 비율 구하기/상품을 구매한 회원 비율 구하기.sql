with base as (
    select
        year(b.sales_date) as year,
        month(b.sales_date) as month,
        count(distinct case when year(a.joined) = 2021 then b.user_id end) as purchased_users     from 
        user_info a
    left join
        online_sale b
    on 
        a.user_id = b.user_id
    group by 
        1,2
)
, mid_tb as (
    select
        year,
        month,
        purchased_users,
        (select count(distinct user_id) from user_info where year(joined) = 2021) as joined_cnt
    from 
        base
)
select
    year,
    month,
    purchased_users,
    round(purchased_users/joined_cnt,1) as purchased_ratio
from 
    mid_tb
where
    year is not null and month is not null
order by 
    year asc, month asc