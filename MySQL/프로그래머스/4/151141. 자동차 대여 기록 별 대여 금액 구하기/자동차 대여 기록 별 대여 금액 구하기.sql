with base as (
    select 
        a.history_id,
        a.start_date,
        a.end_date,
        b.car_id,
        b.car_type,
        b.daily_fee
    from 
        car_rental_company_rental_history a 
    left join
        car_rental_company_car b
    on 
        a.car_id = b.car_id
)
, duration_discount_rate as (
    select
        a.history_id,
        timestampdiff(day,a.start_date,a.end_date) + 1 as duration,
        a.car_id,
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
        b.duration_type = (case when timestampdiff(day,a.start_date,a.end_date) + 1 >= 90 then '90일 이상'
                         when timestampdiff(day,a.start_date,a.end_date) + 1 >= 30 then '30일 이상'
                         when timestampdiff(day,a.start_date,a.end_date) + 1 >= 7 then '7일 이상'
                            else timestampdiff(day,a.start_date,a.end_date) + 1 end)
)
select 
    history_id,
    case when discount_rate is not null then 
    round(daily_fee * duration * (1 - 0.01 * discount_rate)) 
    else round(duration * daily_fee) end as fee
from 
    duration_discount_rate
where
    car_type = '트럭'
order by 
    fee desc, history_id desc