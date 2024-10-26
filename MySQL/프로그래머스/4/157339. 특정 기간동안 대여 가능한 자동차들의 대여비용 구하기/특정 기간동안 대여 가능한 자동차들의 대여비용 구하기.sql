with base as (
    select
        a.history_id,
        a.car_id,
        a.start_date,
        a.end_date,
        timestampdiff(day,a.start_date,a.end_date) + 1 as days_diff,
        b.daily_fee,
        b.car_type,
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
)
select
    car_id,
    car_type,
    round(daily_fee* 30*(1-0.01*discount_rate)) as fee
from 
    base
where
    car_id not in (select distinct car_id from base
    where end_date > '2022-11-01')
    and car_type in ('SUV','세단')
    and duration_type = '30일 이상'
group by 
    car_id
having 
    fee >= 500000 and fee < 2000000
order by 
    fee desc, car_type asc, car_id desc