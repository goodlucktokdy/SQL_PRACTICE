with base as (
    select 
        host_id,
        count(distinct id) as cnts
    from 
        places
    group by 
        host_id
    having 
        count(distinct id) >= 2
)
select
    a.id,
    a.name,
    a.host_id
from 
    places a
inner join 
    base b 
on 
    a.host_id = b.host_id
order by 
    a.id asc