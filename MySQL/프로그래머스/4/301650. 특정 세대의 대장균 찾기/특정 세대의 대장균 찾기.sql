with recursive cte as (
    select
        id,
        parent_id,
        1 as generation
    from
        ecoli_data 
    where 
        parent_id is null
    union all
    select
        a.id,
        a.parent_id,
        b.generation + 1 
    from
        ecoli_data a
    inner join 
        cte b 
    on 
        b.id = a.parent_id
)
select
    id
from 
    cte
where
    generation = 3
order by 
    id asc