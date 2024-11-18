with base as (
    select 
        a.animal_id,
        a.animal_type,
        a.sex_upon_intake,
        a.name,
        b.sex_upon_outcome
    from 
        animal_ins a
    join 
        animal_outs b
    on 
        a.animal_id = b.animal_id
    where
        a.sex_upon_intake like '%Intact%' and (b.sex_upon_outcome like '%Neutered%' or 
        b.sex_upon_outcome like '%Spayed%')
)
select 
    animal_id,
    animal_type,
    name
from 
    base
order by 
    animal_id asc