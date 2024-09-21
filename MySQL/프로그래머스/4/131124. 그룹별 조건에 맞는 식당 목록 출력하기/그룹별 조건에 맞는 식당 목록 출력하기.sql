with base as (
select
    a.member_id,
    a.member_name,
    b.review_id,
    b.review_text,
    b.review_date,
    count(review_id) over (partition by member_id) as review_cnts
from
    member_profile a
join
    rest_review b
on
    a.member_id = b.member_id
)
select
    member_name,
    review_text,
    date_format(review_date,'%Y-%m-%d') as review_date
from
    (
select
    member_name,
    review_text,
    review_cnts,
    review_date,
    rank() over (order by review_cnts desc) as ranks
from
    base
) a
where
    ranks = 1
order by
    review_date, review_text

    
    