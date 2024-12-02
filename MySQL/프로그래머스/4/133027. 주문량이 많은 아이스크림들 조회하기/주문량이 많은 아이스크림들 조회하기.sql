with base as (
    select
        flavor,
        total_order
    from 
        first_half
    union all
    select
        flavor,
        total_order
    from 
        july
)
select
    a.flavor
from (
    select
        flavor,
        sum(total_order) as total_order
    from 
        base
    group by 
        flavor
) a
order by 
    a.total_order desc
limit 3