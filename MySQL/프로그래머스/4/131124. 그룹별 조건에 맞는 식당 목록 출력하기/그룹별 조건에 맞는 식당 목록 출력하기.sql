with base as (
select
        b.member_name,
        b.member_id,
        rest_id,
        count(b.member_id) over (partition by b.member_id) as cnts,
        review_text,
        date(review_date) as review_date
    from 
        rest_review a
    join 
        member_profile b
    on 
        a.member_id = b.member_id
)
select
    member_name,
    review_text,
    date_format(review_date,'%Y-%m-%d') as review_date
from 
    base
where
    cnts = (select max(cnts) from base)
order by 
    review_date asc, review_text asc