with base as (
    select
        a.member_id,
        a.member_name,
        count(b.review_id) over (partition by member_id) as cnts,
        b.review_text,
        b.review_date
    from
        member_profile a
    join
        rest_review b
    on
        a.member_id = b.member_id
)
select
    case when 
        (select max(cnts) from base) = cnts then member_name
        else null end as member_name,
    review_text,
    date_format(review_date,'%Y-%m-%d') as review_date    
from 
    base
where
    case when 
        (select max(cnts) from base) = cnts then member_name
        else null end is not null
order by 
    review_date asc, review_text asc