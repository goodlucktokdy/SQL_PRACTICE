select
    a.id,
    case when a.percent <= 0.25 then 'CRITICAL' 
        when a.percent <= 0.50 then 'HIGH'
        when a.percent <= 0.75 then 'MEDIUM'
        else 'LOW' end as colony_name
from (
    select
        id,
        percent_rank() over (order by size_of_colony desc) as percent
    from 
        ecoli_data
) a
order by 
    a.id asc