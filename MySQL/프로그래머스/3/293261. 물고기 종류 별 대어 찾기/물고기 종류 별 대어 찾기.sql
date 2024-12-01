with base as (
    select 
        b.fish_type,
        b.fish_name,
        max(a.length) as max_length
    from 
        fish_info a
    left join
        fish_name_info b
    on 
        a.fish_type = b.fish_type
    group by 
        b.fish_type, b.fish_name
)
select 
    b.id,
    a.fish_name,
    a.max_length as length
from 
    base a
left join
    fish_info b
on
    a.max_length = b.length and a.fish_type = b.fish_type
order by 
    b.id asc