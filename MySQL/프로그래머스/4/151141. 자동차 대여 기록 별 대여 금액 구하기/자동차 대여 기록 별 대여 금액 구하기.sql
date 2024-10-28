with base as (
    select
        a.history_id,
        a.car_id,
        a.start_date,
        a.end_date,
        b.daily_fee,
        b.car_type
    from 
        car_rental_company_rental_history a
    left join
        car_rental_company_car b
    on
        a.car_id = b.car_id
)
, discount_tb as (
    select
        a.*,
        timestampdiff(day,a.start_date,a.end_date) + 1 as period,
        b.duration_type,
        b.discount_rate
    from 
        base a
    left join 
        car_rental_company_discount_plan b
    on 
        a.car_type = b.car_type and 
        b.duration_type = 
        case when timestampdiff(day,a.start_date,a.end_date) + 1 >= 90 then '90일 이상'
        when timestampdiff(day,a.start_date,a.end_date) + 1 >= 30 then '30일 이상'
        when timestampdiff(day,a.start_date,a.end_date) + 1 >= 7 then '7일 이상'
        else null end
    where
        a.car_type = '트럭'
)
select
    history_id,
    case when
        duration_type is not null 
        then round(period * daily_fee * (1-0.01*discount_rate))
        else round(period * daily_fee) end as fee
from 
    discount_tb
order by 
    fee desc, history_id desc