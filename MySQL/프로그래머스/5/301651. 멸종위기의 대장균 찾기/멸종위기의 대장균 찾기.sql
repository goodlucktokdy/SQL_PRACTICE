with recursive cte as (
select 
    id,
    parent_id,
    1 as gen
from
    ECOLI_DATA a
WHERE
    parent_id is null
    
union all
    
select
    b.id,
    b.parent_id,
    cte.gen + 1 
from
    cte
join
    ECOLI_DATA b on cte.id = b.parent_id
    )
select 
    count(distinct id) as count,
    gen as generation
from cte
where
    id not in (select parent_id from cte where parent_id is not null)
group by
    generation
