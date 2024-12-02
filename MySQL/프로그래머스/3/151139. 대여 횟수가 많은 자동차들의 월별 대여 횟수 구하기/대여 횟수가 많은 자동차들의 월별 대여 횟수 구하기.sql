with base as (
    select 
        count(distinct history_id) as cnts,
        car_id
    from 
        car_rental_company_rental_history
    where 
        start_date between '2022-08-01' and '2022-10-31'
    group by 
        car_id
    having 
        cnts >= 5
)
select 
    month(a.start_date) as month,
    a.car_id,
    count(distinct a.history_id) as records
from 
    car_rental_company_rental_history a 
inner join 
    base b
on 
    a.car_id = b.car_id
where 
    a.start_date between '2022-08-01' and '2022-10-31'
group by 
    month, a.car_id
order by 
    month asc, car_id desc