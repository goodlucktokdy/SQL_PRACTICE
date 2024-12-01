with base as (
    select
        a.history_id,
        a.car_id,
        a.start_date,
        b.car_type
    from 
        car_rental_company_rental_history a
    left join 
        car_rental_company_car b
    on
        a.car_id = b.car_id
    where 
        month(a.start_date) = 10 and b.car_type = '세단'
)
select
    distinct
    car_id
from 
    base
order by 
    car_id desc