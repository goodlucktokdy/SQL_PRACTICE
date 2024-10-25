select
    a.rest_id,
    a.rest_name,
    a.food_type,
    a.favorites,
    a.address,
    round(avg(b.review_score),2) as score
from 
    rest_info a
left join
    rest_review b
on 
    a.rest_id = b.rest_id
where
    substring(address,1,5) like '%서울%'
and 
    b.review_score is not null
group by 
    1,2,3,4,5
order by 
    score desc, favorites desc

