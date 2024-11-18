with base as (
    select
        a.history_id,
        a.car_id,
        a.start_date,
        a.end_date,
        timestampdiff(day,a.start_date,a.end_date) + 1 as duration,
        b.car_type,
        b.daily_fee
    from 
        CAR_RENTAL_COMPANY_RENTAL_HISTORY a 
    left join 
        CAR_RENTAL_COMPANY_CAR b 
    on 
        a.car_id = b.car_id
)
,joined_duration_cte as (
    select 
        a.history_id,
        a.duration,
        a.car_type,
        a.daily_fee,
        b.duration_type,
        b.discount_rate
    from 
        base a 
    left join 
        car_rental_company_discount_plan b 
    on 
        a.car_type = b.car_type and 
        b.duration_type = (case when duration >= 90 then '90일 이상'
                          when duration >= 30 then '30일 이상'
                          when duration >= 7 then '7일 이상'
                          else null end)
)
, total_fee_cte as (
    select 
        history_id,
        car_type,
        duration,
        duration_type,
        daily_fee,   
        case when duration_type is not null then duration * daily_fee * (1 - 0.01*discount_rate) else duration * daily_fee end as fee
    from 
        joined_duration_cte
    where 
        car_type = '트럭'
)
select 
    history_id,
    round(fee) as fee 
from 
    total_fee_cte
order by 
    fee desc, history_id desc