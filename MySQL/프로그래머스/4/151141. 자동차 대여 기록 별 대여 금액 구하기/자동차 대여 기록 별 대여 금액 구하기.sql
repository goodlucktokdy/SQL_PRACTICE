with base as (
    select 
        a.history_id,
        a.car_id,
        b.car_type,
        b.daily_fee,
        a.start_date,
        a.end_date,
        timestampdiff(day,a.start_date,a.end_date) + 1 as diff,
        c.duration_type,
        c.discount_rate
    from 
        CAR_RENTAL_COMPANY_RENTAL_HISTORY a
    left join 
        CAR_RENTAL_COMPANY_CAR b
    on 
        a.car_id = b.car_id
    left join 
        CAR_RENTAL_COMPANY_DISCOUNT_PLAN c
    on 
        c.duration_type = 
        case when b.car_type = c.car_type and 
        timestampdiff(day,a.start_date,a.end_date) >= 90 then '90일 이상'
        when b.car_type = c.car_type and 
        timestampdiff(day,a.start_date,a.end_date) >= 30 then '30일 이상'
        when b.car_type = c.car_type and 
        timestampdiff(day,a.start_date,a.end_date) >= 7 then '7일 이상'
        else timestampdiff(day,a.start_date,a.end_date) end 
)
select 
    history_id,
    case when discount_rate is not null then round(daily_fee * diff * (1 - 0.01 * discount_rate))
    else round(daily_fee * diff) end as fee
from 
    base
where
    car_type = '트럭'
order by 
    fee desc, 
    history_id desc