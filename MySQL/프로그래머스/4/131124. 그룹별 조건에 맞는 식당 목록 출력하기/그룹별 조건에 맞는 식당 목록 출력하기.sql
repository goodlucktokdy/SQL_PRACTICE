with base as (
    select 
        distinct
        a.review_id,
        a.member_id,
        a.review_date,
        a.review_text,
        b.member_name
    from 
        rest_review a 
    left join 
        member_profile b
    on 
        a.member_id = b.member_id
)
, review_cnts_ranks as (
    select
        a.member_name,
        a.review_text,
        a.review_date,
        dense_rank() over (order by a.review_cnt desc) as ranks
    from (
        select 
            member_id,
            member_name,
            review_text,
            review_date,
            count(review_id) over (partition by member_id) as review_cnt
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
    review_cnts_ranks
where
    ranks = 1
order by 
    review_date asc, review_text asc