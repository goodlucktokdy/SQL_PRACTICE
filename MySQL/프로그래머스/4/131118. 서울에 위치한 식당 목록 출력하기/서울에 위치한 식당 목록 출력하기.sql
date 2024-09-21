with base as (
select
    b.rest_id,
    b.rest_name,
    b.food_type,
    b.favorites,
    b.address,
    a.review_id,
    a.review_score
from
    rest_review a
left join
    rest_info b
on
    a.rest_id = b.rest_id
where
    address like '%서울%시%'
)
select
    distinct
    rest_id,
    rest_name,
    food_type,
    favorites,
    address,
    round(avg(review_score) over (partition by rest_id),2) as score
from
    base
order by
    score desc,favorites desc