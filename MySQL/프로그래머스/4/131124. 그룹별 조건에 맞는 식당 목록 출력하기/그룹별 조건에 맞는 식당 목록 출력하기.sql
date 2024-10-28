with base as (
    select
        distinct
        b.member_name,
        a.member_id,
        a.rest_id,
        a.review_text,
        date_format(a.review_date,'%Y-%m-%d') as review_date
    from 
        rest_review a
    left join 
        member_profile b
    on 
        a.member_id = b.member_id
)
, review_cnt_tb as (
    select
        member_name,
        review_text,
        review_date,
        count(member_id) over (partition by member_id) as cnt
    from 
        base
    group by 
        1,2,3
)
select
    member_name,
    review_text,
    review_date
from 
    review_cnt_tb
where
    cnt = (select max(cnt) from review_cnt_tb)
order by 
    review_date, review_text 