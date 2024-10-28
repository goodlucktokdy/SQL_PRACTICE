with recursive cte as (
    select
        1 as gen,
        id,
        parent_id
    from
        ecoli_data
    where
        parent_id is null
    union all
    select
        cte.gen + 1,
        a.id,
        a.parent_id
    from 
        ecoli_data a
    join
        cte
    on
        a.parent_id = cte.id
        
    )
select
    distinct id
from 
    cte
where
    gen = 3
order by 
    id