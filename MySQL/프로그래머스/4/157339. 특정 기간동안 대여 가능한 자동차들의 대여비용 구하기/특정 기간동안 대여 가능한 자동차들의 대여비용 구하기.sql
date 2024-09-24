with base as ( 
    select 
        a.car_id,
        a.car_type,
        a.daily_fee,
        b.history_id,
        b.start_date,
        b.end_date
    from
        car_rental_company_car a
    join
        car_rental_company_rental_history b
    on
        a.car_id = b.car_id 
    where not exists
    (select end_date from car_rental_company_rental_history b
        where a.car_id = b.car_id and
     (b.end_date >= '2022-11-01' and b.start_date <= '2022-11-30'))
),duration_table as ( 
    select
        distinct
        a.car_id,
        a.car_type,
        a.daily_fee,
        a.start_date,
        a.end_date,
        b.discount_rate,
        b.duration_type
    from
        base a
    join
        (select car_type, duration_type, discount_rate
         from car_rental_company_discount_plan
        where duration_type = '30일 이상') b
    on
        a.car_type = b.car_type  )      
select
    distinct
    car_id,
    car_type,
    round(30 * daily_fee * (1 - discount_rate*0.01)) as fee
from
    duration_table
where
    30 * daily_fee * (1-discount_rate*0.01) >= 500000 and
    30 * daily_fee * (1-discount_rate*0.01) < 2000000
order by
    fee desc, car_type asc, car_id desc
