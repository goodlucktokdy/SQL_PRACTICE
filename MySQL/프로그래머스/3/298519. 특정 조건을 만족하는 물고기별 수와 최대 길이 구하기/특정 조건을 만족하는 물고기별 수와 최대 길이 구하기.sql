with filtered_fish_type as (
    select
        fish_type,
        avg(case when length is null then 10 else length end) as avg_length
    from 
        fish_info
    group by 
        fish_type
    having 
        avg_length >= 33
)
select
    count(distinct b.id) as fish_count,
    max(b.length) as max_length,
    a.fish_type  
from 
    filtered_fish_type a
inner join 
    fish_info b
on 
    a.fish_type = b.fish_type
group by 
    a.fish_type
order by
    a.fish_type asc