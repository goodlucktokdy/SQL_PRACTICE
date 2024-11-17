-- 코드를 입력하세요
with base as (
    SELECT
        distinct
        b.member_id,
        b.member_name,
        a.review_id,
        a.review_text,
        date(a.review_date) as review_date
    from 
        rest_review a
    join 
        member_profile b
    on 
        a.member_id = b.member_id
)
,review_cnt_ranks_per_user as (
    select
        a.member_name,
        a.review_text,
        a.review_date,
        dense_rank() over (order by a.review_cnt_per_user desc) as ranks
    from (
        select
            member_name,
            review_text,
            review_date,
            count(review_id) over (partition by member_id) as review_cnt_per_user
        from 
            base
    ) a
)
select 
    distinct
    member_name,
    review_text,
    date_format(review_date,'%Y-%m-%d') as review_date
from 
    review_cnt_ranks_per_user
where
    ranks = 1
order by 
    review_date, review_text