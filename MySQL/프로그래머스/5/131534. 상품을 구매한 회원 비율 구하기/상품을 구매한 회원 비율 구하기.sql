-- 코드를 입력하세요
with base as (
SELECT
   extract(year from date(sales_date)) as year,
   extract(month from date(sales_date)) as month,
   date_format(joined,'%Y-%m-%d') as joined,
   b.user_id,
    b.product_id,
    b.sales_amount
from
    user_info a
join
    online_sale b
on
    a.user_id = b.user_id
where
    extract(year from joined) = '2021'
)
select
    year,
    month,
    count(distinct user_id) as purchased_users,
    round(count(distinct user_id)/(select count(distinct user_id) from user_info
                                where joined between '2021-01-01' and '2021-12-31'),1) as purchased_ratio
from
    base
group by
    year,month
order by
    year, month
