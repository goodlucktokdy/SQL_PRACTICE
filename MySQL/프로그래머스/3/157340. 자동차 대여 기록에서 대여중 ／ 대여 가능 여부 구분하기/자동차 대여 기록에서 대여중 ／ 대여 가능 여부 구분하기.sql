with filtered_car_id as (
    select 
        distinct 
        car_id
    from 
        car_rental_company_rental_history
    where 
        '2022-10-16' between start_date and end_date
)
select
    distinct
    car_id,
    case when car_id not in (select * from filtered_car_id) then '대여 가능'
        else '대여중' end as availability
from 
    car_rental_company_rental_history
order by    
    car_id desc