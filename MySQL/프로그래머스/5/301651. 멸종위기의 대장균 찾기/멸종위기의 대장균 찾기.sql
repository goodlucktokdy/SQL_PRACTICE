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
), joined_tb as (
    select
        a.gen as a_gen,
        b.gen as b_gen,
        a.id as a_id,
        a.parent_id as a_parent_id,
        b.id as b_id,
        b.parent_id as b_parent_id
    from 
        cte a
    left join 
        cte b
    on 
        a.gen + 1 = b.gen
    and a.id = b.parent_id
)
select
    count(a_id) as count,
    a_gen as generation
from 
    joined_tb
where
    b_id is null
group by 
    generation