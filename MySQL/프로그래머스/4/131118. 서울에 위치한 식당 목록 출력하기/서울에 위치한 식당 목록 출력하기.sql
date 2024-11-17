-- 코드를 입력하세요
with base as (
    SELECT
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
        substring(a.address,1,5) like '%서울%'
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
having
    score is not null
order by 
    score desc, favorites desc
    