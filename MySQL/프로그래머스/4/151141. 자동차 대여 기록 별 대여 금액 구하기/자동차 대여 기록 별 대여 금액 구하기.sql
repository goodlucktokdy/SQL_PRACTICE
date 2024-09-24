# with base as (
#     select
#         a.car_id,
#         a.car_type,
#         a.daily_fee,
#         b.history_id,
#         b.start_date,
#         b.end_date,
#         date(b.end_date) - date(b.start_date) + 1 as duration
#     from
#         car_rental_company_car a
#     join
#         car_rental_company_rental_history b
#     on 
#         a.car_id = b.car_id
#     where a.car_type = '트럭'
# ), duration_table as (  
#     select
#         a.car_type,
#         a.history_id,
#         a.daily_fee,
#         a.duration,
#         case when 
#             b.discount_rate is null then 0 else b.discount_rate end as discount_rate
#     from
#         base a
#     left join
#          CAR_RENTAL_COMPANY_DISCOUNT_PLAN b
#     on
#         a.car_type = b.car_type and
#         (b.duration_type = case when 
#             a.duration >= 90 then '90일 이상'
#             when a.duration >= 30 then '30일 이상'
#             when a.duration >= 7 then '7일 이상'
#             else 0 end)
# )
# select
#     history_id,
#     round(daily_fee * duration * (1-0.01*discount_rate)) as fee
# from 
#     duration_table
# order by
#     fee desc, history_id desc
with base as (
select 
    b.history_id,
    a.car_id,
    a.car_type,
    a.daily_fee,
    b.start_date,
    b.end_date,
    timestampdiff(day,b.start_date,b.end_date) + 1 as duration,
    c.duration_type,
    c.discount_rate
from
    CAR_RENTAL_COMPANY_CAR a
join
    CAR_RENTAL_COMPANY_RENTAL_HISTORY b
on
    a.car_id = b.car_id
left join
    CAR_RENTAL_COMPANY_DISCOUNT_PLAN c
on
    c.car_type = a.car_type
),
discount_table as (
select
    distinct
    a.history_id,
    a.car_id,
    a.car_type,
    a.daily_fee,
    a.start_date,
    a.end_date,
    a.duration,
    b.discount_rate
from
    base a
left join
    CAR_RENTAL_COMPANY_DISCOUNT_PLAN b
on
    a.car_type = b.car_type and(
        b.duration_type =  case when
        a.duration >= 90 then '90일 이상'
        when
        a.duration >= 30 then '30일 이상'
        when
        a.duration >= 7 then '7일 이상'
        else null end))
select
    history_id,
    case 
        when
        discount_rate is null then daily_fee * duration
        else round(duration * (100-discount_rate) * 0.01 * daily_fee) end as fee
from
    discount_table
where
    car_type = '트럭'
order by 
    fee desc, history_id desc