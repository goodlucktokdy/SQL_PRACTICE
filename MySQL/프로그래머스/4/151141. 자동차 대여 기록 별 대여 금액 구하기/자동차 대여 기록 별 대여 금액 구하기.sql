with base as (
    select
        a.car_id,
        a.car_type,
        a.daily_fee,
        b.history_id,
        b.start_date,
        b.end_date,
        c.duration_type,
        c.discount_rate
    from 
        car_rental_company_car a 
    left join
        car_rental_company_rental_history b 
    on
        a.car_id = b.car_id 
    left join
        car_rental_company_discount_plan c
    on
        a.car_type = c.car_type
        and c.duration_type = case when timestampdiff(day,b.start_date,b.end_date) + 1 >= 90 then '90일 이상'
        when timestampdiff(day,b.start_date,b.end_date) + 1 >= 30 then '30일 이상'
        when timestampdiff(day,b.start_date,b.end_date) + 1 >= 7 then '7일 이상'
        else null end
    where 
        a.car_type = '트럭'
)
select 
    a.history_id,
    case when a.duration_type is not null then round(a.daily_fee * a.duration * 0.01 * (100-a.discount_rate)) else a.daily_fee * a.duration end as fee
from (
        select 
            history_id,
            daily_fee,
            timestampdiff(day,start_date,end_date) + 1 as duration,
            duration_type,
            discount_rate
        from 
            base
) a
order by 
    fee desc, history_id desc