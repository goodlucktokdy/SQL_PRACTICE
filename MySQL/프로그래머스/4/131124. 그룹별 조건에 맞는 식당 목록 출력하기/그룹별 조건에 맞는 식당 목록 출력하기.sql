with base as (
    select
        distinct
        a.member_id,
        b.member_name,
        a.rest_id,
        a.review_id,
        a.review_text,
        a.review_date
    from 
        rest_review a
    left join 
        member_profile b
    on 
        a.member_id = b.member_id
),
cnts_tb as (
    select
        member_id,
        member_name,
        review_text,
        review_date,
        count(review_id) over (partition by member_id) as cnts
    from 
        base
    group by 
        1,2,3,4
)
select
    member_name,
    review_text,
    date_format(review_date,'%Y-%m-%d') as review_date
from 
    cnts_tb
where
    cnts = (select max(cnts) from cnts_tb)
order by 
    review_date, review_text