with base as (
select *
    from
        first_half
union all

select *
    from
        july
)
select
    flavor
from 
    base
group by 
    flavor
order by
    sum(total_order) desc
limit 3