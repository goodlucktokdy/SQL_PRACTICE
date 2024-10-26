with recursive cte as (
    select 
        1 as gen,
        id,
        parent_id
    from
        ecoli_data
    where
        parent_id is null
    union
    select
        a.gen + 1,
        b.id,
        b.parent_id
    from 
        ecoli_data b
    join 
        cte a
    on 
        b.parent_id = a.id
)
select
    id
from 
    cte
where
    gen = 3
order by 
    id 