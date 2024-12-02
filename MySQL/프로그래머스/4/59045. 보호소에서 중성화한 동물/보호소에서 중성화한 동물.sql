with base as (
    select
        a.animal_id,
        a.animal_type,
        a.name,
        a.sex_upon_outcome,
        b.sex_upon_intake
    from 
        animal_outs a
    left join 
        animal_ins b
    on 
        a.animal_id = b.animal_id
    where 
        (a.sex_upon_outcome like '%Neutered%' or a.sex_upon_outcome like '%Spayed%')
        and (b.sex_upon_intake like '%Intact%')
)
select
    animal_id,
    animal_type,
    name
from 
    base
order by 
    animal_id, animal_type, name 