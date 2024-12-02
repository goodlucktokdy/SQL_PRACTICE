with filter_seoul as (
    select
        a.rest_id,
        a.rest_name,
        a.food_type,
        a.favorites,
        a.address,
        b.review_score
    from 
        rest_info a
    left join 
        rest_review b
    on 
        a.rest_id = b.rest_id
    where 
        left(a.address,5) like '%서울%시%'
)
select
    rest_id,
    rest_name,
    food_type,
    favorites,
    address,
    round(avg(review_score),2) as score
from 
    filter_seoul
group by 
    1,2,3,4,5
having 
    score is not null
order by 
    score desc, favorites desc