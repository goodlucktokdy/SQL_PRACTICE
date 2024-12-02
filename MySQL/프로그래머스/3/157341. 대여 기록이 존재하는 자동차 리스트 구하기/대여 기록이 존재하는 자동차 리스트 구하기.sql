with filtering_month as (
    select
        history_id,
        car_id,
        start_date
    from 
        car_rental_company_rental_history
    where 
        month(start_date) = 10
)
select
    distinct
    a.car_id
from 
    filtering_month a
inner join 
    car_rental_company_car b
on 
    a.car_id = b.car_id 
where
    b.car_type = '세단'
order by 
    a.car_id desc