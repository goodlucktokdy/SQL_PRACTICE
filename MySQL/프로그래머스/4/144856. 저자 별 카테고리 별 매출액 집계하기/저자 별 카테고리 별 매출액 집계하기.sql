with base as (
    select
        c.author_id,
        c.author_name,
        b.category,
        b.price,
        a.sales
    from 
        book_sales a
    left join 
        book b
    on
        a.book_id = b.book_id
    left join 
        author c
    on
        c.author_id = b.author_id
    where
        a.sales_date between '2022-01-01' and '2022-01-31'
)
select
    author_id,
    author_name,
    category,
    sum(price * sales) as total_sales
from 
    base 
group by 
    1,2,3
order by 
    author_id asc, category desc