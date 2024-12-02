with recursive cte as (
    select 
        0 as hour
    union all
    select 
        cte.hour + 1
    from 
        cte
    where 
        cte.hour < 23)
,base as (
    select 
        a.hour,
        b.animal_id,
        b.datetime
    from 
        cte a
    left join
        animal_outs b 
    on 
        a.hour = date_format(b.datetime,'%H') 
)
select
    hour,
    count(distinct animal_id) as count
from 
    base 
group by 
    hour 
order by 
    hour asc