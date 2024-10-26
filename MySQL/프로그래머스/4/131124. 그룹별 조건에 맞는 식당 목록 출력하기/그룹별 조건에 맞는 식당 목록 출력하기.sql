with base as (
    select
        a.member_name,
        a.member_id,
        count(b.review_id) over (partition by a.member_id) as cnts,   
        b.review_text,
        date_format(b.review_date,'%Y-%m-%d') as review_date
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
    review_date
from 
    base
where
    cnts = (select max(cnts) from base)
order by 
    review_date asc,
    review_text asc