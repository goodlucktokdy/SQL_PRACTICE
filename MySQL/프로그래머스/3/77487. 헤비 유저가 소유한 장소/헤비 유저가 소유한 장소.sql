with base as (
    select
        host_id,
        count(distinct id) as place_cnts
    from 
        places
    group by 
        host_id
    having
        count(distinct id) >= 2
)
select
    b.id,
    b.name,
    a.host_id
from 
    base a
join 
    places b
on 
    a.host_id = b.host_id
order by 
    b.id asc
