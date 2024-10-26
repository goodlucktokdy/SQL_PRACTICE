with recursive cte as (
    select 
        0 as hour
    union all
    select
        cte.hour + 1
    from 
        cte
    where cte.hour < 23)
select
    a.hour,
    count(distinct b.animal_id) as count
from 
    cte a
left join
    animal_outs b
on 
    a.hour = hour(b.datetime)
group by 
    a.hour