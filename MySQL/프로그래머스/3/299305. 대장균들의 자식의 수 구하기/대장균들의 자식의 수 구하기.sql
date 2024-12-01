with base as (
    select
        parent_id,
        count(distinct id) as child_count
    from 
        ecoli_data
    where 
        parent_id is not null
    group by 
        parent_id
)
select
    a.id,
    case when b.child_count is null then 0 else b.child_count end as child_count
from 
    ecoli_data a
left join
    base b
on 
    a.id = b.parent_id
order by 
    a.id