with base as (
    select 
        a.book_id,
        a.author_id,
        a.category,
        a.price,
        b.author_name,
        c.sales_date,
        c.sales
    from
        book a
    join
        author b
    on
        a.author_id = b.author_id
    join
        book_sales c
    on
        c.book_id = a.book_id
    where
        date(c.sales_date) between '2022-01-01' and '2022-01-31'
)
select
    author_id,
    author_name,
    category,
    sum(price * sales) as total_sales
from
    base
group by 
    author_id, author_name, category
order by
    author_id asc, category desc
    
