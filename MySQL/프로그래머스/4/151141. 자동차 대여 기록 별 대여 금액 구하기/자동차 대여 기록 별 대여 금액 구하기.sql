with base as (
    select
        a.history_id,
        a.car_id,
        a.start_date,
        a.end_date,
        timestampdiff(day,a.start_date,a.end_date) + 1 as diff_of_day,
        b.car_type,
        b.daily_fee,
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
        b.car_type = c.car_type
    where
        b.car_type = '트럭'
)
,diff_of_day_tb as (
    select
        history_id,
        car_id,
        start_date,
        end_date,
        diff_of_day,
        car_type,
        daily_fee,
        case when 
            diff_of_day >= 90 then '90일 이상' 
            when diff_of_day >= 30 then '30일 이상'
            when diff_of_day >= 7 then '7일 이상'
            else diff_of_day end as duration_type,
        discount_rate
    from 
        base
)
, discount_joined_tb as (
    select
        a.history_id,
        a.car_id,
        a.start_date,
        a.end_date,
        a.diff_of_day,
        a.car_type,
        a.daily_fee,
        a.duration_type,
        b.discount_rate
    from 
        diff_of_day_tb a 
    left join
        car_rental_company_discount_plan b
    on 
        a.duration_type = b.duration_type and a.car_type = b.car_type
)
select
    distinct
    history_id,
    case when
        discount_rate is not null then round(diff_of_day * (1-0.01*discount_rate) * daily_fee)
        else round(diff_of_day * daily_fee) end as fee
from 
    discount_joined_tb
order by 
    fee desc, history_id desc