with recursive cte as (
    select
        1 as gen,
        parent_id,
        id
    from 
        ecoli_data
    where
        parent_id is null
    union all
    select
        b.gen + 1,
        a.parent_id,
        a.id
    from 
        ecoli_data a

    join
        cte b
    on
        a.parent_id = b.id)
select
    count(distinct a.id) as count,
    a.gen as generation
from
    cte a
left join
    cte b
on
    a.gen + 1 = b.gen and a.id = b.parent_id
where
    b.parent_id is null
group by 
    generation