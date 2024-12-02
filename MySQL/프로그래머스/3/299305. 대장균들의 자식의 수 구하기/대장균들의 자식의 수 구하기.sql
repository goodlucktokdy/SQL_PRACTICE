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
        b.id = a.parent_id
)
, filter_no_son as (
    select
        a.id as aid,
        a.parent_id as apid,
        a.generation as ag,
        b.id as bid,
        b.parent_id as bpid,
        b.generation as bg
    from 
        cte a
    left join 
        cte b 
    on 
        a.id = b.parent_id
)
select
    aid as id,
    count(distinct bid) as child_count
from 
    filter_no_son
group by 
    id
order by 
    id asc