with base as (
    select
        a.history_id,
        a.car_id,
        b.car_type,
        a.start_date,
        a.end_date,
        b.daily_fee,
        timestampdiff(day,a.start_date, a.end_date) + 1 as diff_of_day
    from 
        car_rental_company_rental_history a
    left join 
        car_rental_company_car b
    on 
        a.car_id = b.car_id
)
, filter_discount_rate as (
    select
        a.history_id,
        a.car_id,
        a.car_type,
        a.daily_fee,
        a.diff_of_day,
        b.duration_type,
        b.discount_rate
    from 
        base a
    left join
        car_rental_company_discount_plan b
    on 
        a.car_type = b.car_type and 
        b.duration_type = case when a.diff_of_day >= 90 then '90일 이상'
                                when a.diff_of_day >= 30 then '30일 이상'
                                when a.diff_of_day >= 7 then '7일 이상'
                                else null end
)
select
    history_id,
    case when duration_type is null then diff_of_day * daily_fee
        else round(diff_of_day * daily_fee * (100 - discount_rate) * 0.01) end as fee
from 
    filter_discount_rate
where 
    car_type = '트럭'
order by 
    fee desc, history_id desc
    