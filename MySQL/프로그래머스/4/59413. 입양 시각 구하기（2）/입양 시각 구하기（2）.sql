-- 코드를 입력하세요
with recursive cte as (
    select 0 as hour
    union all
    select hour + 1
    from
        cte
    where
        hour < 23
)
select 
    a.hour,
    count(distinct b.animal_id) as COUNT
from 
    cte a 
left join
    animal_outs b 
on 
    a.hour = hour(b.datetime)
group by 
    a.hour