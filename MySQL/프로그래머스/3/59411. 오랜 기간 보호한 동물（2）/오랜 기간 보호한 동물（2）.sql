with base as (
    select
        a.animal_id,
        a.animal_type,
        a.name,
        b.datetime as start_date,
        a.datetime as end_date,
        timestampdiff(day,b.datetime,a.datetime) as diff_of_day
    from 
        animal_outs a
    left join
        animal_ins b
    on
        a.animal_id = b.animal_id
    where 
        b.datetime is not null
)
select 
    a.animal_id,
    a.name
from (
    select 
        animal_id,
        name,
        dense_rank() over (order by diff_of_day desc) as ranks
    from 
        base
) a
where
    ranks <= 2
order by 
    ranks asc