with base as (
    select 
        history_id,
        car_id,
        start_date,
        end_date
    from
        car_rental_company_rental_history
    where 
        '2022-10-16' between start_date and end_date
)
select 
    distinct 
    car_id,
    case when car_id not in (
        select distinct car_id from base
    ) then '대여 가능' else '대여중' end as availability
from 
    CAR_RENTAL_COMPANY_RENTAL_HISTORY 
order by 
    car_id desc