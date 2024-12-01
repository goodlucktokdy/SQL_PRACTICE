with base as (
    select
        car_id,
        count(distinct history_id) 
    from 
        car_rental_company_rental_history
    where
        date_format(start_date,'%Y-%m') between '2022-08' and '2022-10'
    group by 
        car_id
    having 
        count(distinct history_id) >= 5
)
select 
    month(b.start_date) as month,
    a.car_id,
    count(distinct b.history_id) as record
from 
    base a 
inner join 
    car_rental_company_rental_history b
on 
    a.car_id = b.car_id
where 
    date_format(b.start_date,'%Y-%m') between '2022-08' and '2022-10'
group by 
    month(b.start_date), a.car_id
order by 
    month asc, a.car_id desc
