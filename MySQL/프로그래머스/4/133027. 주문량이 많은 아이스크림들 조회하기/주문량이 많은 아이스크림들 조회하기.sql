with union_tb as (
    select 
        a.flavor,
        a.total_order
    from 
        first_half a
    union all
    select
        b.flavor,
        b.total_order
    from 
        july b
)
, sum_tb as (
    select 
        flavor,
        sum(total_order) as total_order
    from 
        union_tb
    group by 
        flavor
)
select
    flavor
from 
    sum_tb
order by 
    total_order desc
limit 3