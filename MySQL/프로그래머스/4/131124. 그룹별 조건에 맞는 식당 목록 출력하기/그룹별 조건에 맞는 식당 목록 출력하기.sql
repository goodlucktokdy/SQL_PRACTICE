with base as (
    select
        distinct
        member_id,
        count(review_id) over (partition by member_id) as review_cnts,
       review_text,
        review_date
    from 
        rest_review
), ranking as (
    select
        a.member_id,
        a.review_text,
        a.review_date
    from (
        select
            member_id,
            review_text,
            review_date,
            dense_rank() over (order by review_cnts desc) as cnts_ranks
        from 
            base
    ) a
    where
        a.cnts_ranks = 1
)
select
    b.member_name,
    a.review_text,
    date_format(a.review_date,'%Y-%m-%d') as review_date
from 
    ranking a
inner join 
    member_profile b 
on 
    a.member_id = b.member_id
order by 
    a.review_date asc,  a.review_text asc
    