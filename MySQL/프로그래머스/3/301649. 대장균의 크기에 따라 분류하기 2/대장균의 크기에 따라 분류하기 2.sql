select 
    a.id,
    case when a.ranks <= 0.25 then 'CRITICAL'
    when a.ranks <= 0.5 then 'HIGH'
    when a.ranks <= 0.75 then 'MEDIUM'
    else 'LOW' end as colony_name
from (
select 
    id, 
    percent_rank() over (order by size_of_colony desc) as ranks
from 
    ecoli_data
) a
order by
    id asc