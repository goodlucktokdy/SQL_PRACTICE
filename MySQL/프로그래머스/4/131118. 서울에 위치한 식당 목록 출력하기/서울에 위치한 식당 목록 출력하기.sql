with base as (
    select 
        a.review_id,
        a.rest_id,
        a.review_score as score, 
        b.rest_name,
        b.food_type,
        b.favorites,
        b.address
    from 
        rest_review a
    left join 
        rest_info b
    on 
        a.rest_id = b.rest_id
    where
        substring(b.address,1,5) like '%서울%'
)
select 
    a.rest_id,
    a.rest_name,
    a.food_type,
    a.favorites,
    a.address,
    round(avg(a.score),2) as score
from (
    select 
        rest_id,
        rest_name,
        food_type,
        favorites,
        address,
        score
    from 
        base
) a
group by 
    1,2,3,4
order by 
    score desc, favorites desc