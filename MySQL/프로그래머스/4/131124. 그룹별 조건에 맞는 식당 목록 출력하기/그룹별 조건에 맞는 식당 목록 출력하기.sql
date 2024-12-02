with base as (
    select 
        a.member_id,
        dense_rank() over (order by a.review_cnts desc) as ranks
    from (
        select
            member_id,
            count(distinct review_id) as review_cnts
        from 
            rest_review
        group by 
            member_id
    ) a
)
, review_ranks as (
    select 
        a.member_id,
        a.review_text,
        a.review_date
    from 
        rest_review a 
    inner join 
        base b 
    on 
        a.member_id = b.member_id
    where 
        b.ranks = 1
)
select 
    a.member_name,
    b.review_text,
    date_format(b.review_date,'%Y-%m-%d') as review_date
from 
    member_profile a 
inner join 
    review_ranks b
on 
    a.member_id = b.member_id
order by 
    b.review_date asc, b.review_text asc