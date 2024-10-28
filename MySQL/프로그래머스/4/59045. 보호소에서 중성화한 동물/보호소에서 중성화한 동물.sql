select 
    b.animal_id,
    b.animal_type,
    b.name
from 
    animal_ins a 
join 
    animal_outs b
on 
    a.animal_id = b.animal_id
where
    (a.sex_upon_intake like '%Intact%')
    and (b.sex_upon_outcome like '%Spayed%'
        or b.sex_upon_outcome like '%Neutered%')
order by 
    b.animal_id