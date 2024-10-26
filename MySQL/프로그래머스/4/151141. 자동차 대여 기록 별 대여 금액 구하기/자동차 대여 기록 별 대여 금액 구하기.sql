with base as (
    select
        a.car_id,
        a.car_type,
        a.daily_fee,
        b.history_id,
        timestampdiff(day,b.start_date,b.end_date) + 1 as time_diff,
        c.discount_rate,
        c.duration_type
    from
        CAR_RENTAL_COMPANY_CAR a
    join
        CAR_RENTAL_COMPANY_RENTAL_HISTORY b
    on 
        a.car_id = b.car_id
    left join
        CAR_RENTAL_COMPANY_DISCOUNT_PLAN c
    on
       c.duration_type = 
        case when a.car_type = c.car_type and timestampdiff(day,b.start_date,b.end_date) + 1 >= 90 then '90일 이상'
        when  a.car_type = c.car_type and timestampdiff(day,b.start_date,b.end_date) + 1 >= 30 then '30일 이상'
        when  a.car_type = c.car_type and timestampdiff(day,b.start_date,b.end_date) + 1 >= 7 then '7일 이상'
        else '7일 미만' end
)
select
    history_id,
    case when 
        discount_rate is not null then
            round((1 - 0.01 * discount_rate) * daily_fee * time_diff)
        else
            round(daily_fee * time_diff) end as fee
from 
    base
where
    car_type = '트럭'
order by 
    fee desc, history_id desc
