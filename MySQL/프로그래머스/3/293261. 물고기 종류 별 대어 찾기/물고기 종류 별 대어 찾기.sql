with max_fish_info as (
    select
        fish_type,
        max(length) as max_length
    from 
        fish_info
    group by 
        fish_type
)
, integrated_info as (
    select
        b.id,
        a.fish_type,
        b.length,
        a.max_length
    from 
        max_fish_info a
    inner join 
        fish_info b 
    on 
        a.max_length = b.length and a.fish_type = b.fish_type
)
select
    a.id,
    b.fish_name,
    a.max_length as length
from 
    integrated_info a
inner join 
    fish_name_info b
on 
    a.fish_type = b.fish_type
order by 
    id asc