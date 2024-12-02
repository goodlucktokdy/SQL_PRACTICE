with base as (
    select
        a.category,
        a.author_id,
        sum(a.price * b.sales) as revenue
    from 
        book a 
    left join 
        book_sales b
    on
        a.book_id = b.book_id
    where 
        date_format(b.sales_date,'%Y-%m') = '2022-01'
    group by 
        a.category, a.author_id
)
select 
    a.author_id,
    b.author_name,
    a.category,
    a.revenue
from 
    base a 
inner join 
    author b
on 
    a.author_id = b.author_id
order by 
    a.author_id asc, a.category desc