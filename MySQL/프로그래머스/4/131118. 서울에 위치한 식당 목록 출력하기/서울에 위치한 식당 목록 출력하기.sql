with base as (
    select
        a.rest_id,
        b.rest_name,
        b.food_type,
        b.favorites,
        b.address,
        a.review_score
    from 
        rest_review a
    left join 
        rest_info b
    on 
        a.rest_id = b.rest_id
    where
        substring(address,1,5) like '%서울%'
)
select
    rest_id,
    rest_name,
    food_type,
    favorites,
    address,
    round(avg(review_score),2) as score
from 
    base 
group by 
    1,2,3,4,5
order by 
    score desc, favorites desc