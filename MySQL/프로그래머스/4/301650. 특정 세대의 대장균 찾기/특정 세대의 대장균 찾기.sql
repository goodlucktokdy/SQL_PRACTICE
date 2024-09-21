with recursive cte as (
    select
        id,
        parent_id,
        1 as generation
    from
        ECOLI_DATA
    where 
        parent_id is null
    
    union all
    
    select
        a.id,
        a.parent_id,
        cte.generation + 1
    from
        ECOLI_DATA a
    join
        cte 
    on
        a.parent_id = cte.id)
        
select id from cte
where
    cte.generation = 3
order by
    id

    