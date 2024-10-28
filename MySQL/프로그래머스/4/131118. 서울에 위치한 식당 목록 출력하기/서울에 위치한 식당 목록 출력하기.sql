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
    substring(a.address,1,5) like '%서울%'
group by 
    1,2,3,4,5
having 
    score is not null
order by 
    score desc