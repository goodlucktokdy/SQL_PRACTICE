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
        b.generation + 1 as generation
    from 
        ecoli_data a 
    inner join 
        cte b 
    on
        a.parent_id = b.id)
, no_leaf as (
    select
        a.id as aid,
        a.parent_id as apid,
        a.generation as ag,
        b.id as bid,
        b.parent_id as bpid
    from 
        cte a
    left join
        cte b
    on 
        a.id = b.parent_id
)
select
    count(distinct aid) as count,
    ag as generation
from 
    no_leaf
where 
    bid is null
group by 
    ag
order by 
    ag
    