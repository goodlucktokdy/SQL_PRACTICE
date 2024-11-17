with base as (
    select
        a.book_id,
        a.sales_date,
        a.sales,
        b.category,
        b.author_id,
        b.price,
        c.author_name
    from 
        book_sales a
    left join 
        book b
    on 
        a.book_id = b.book_id
    left join
        author c
    on 
        b.author_id = c.author_id
    where
        a.sales_date between '2022-01-01' and '2022-01-31'
)
select
    author_id,
    author_name,
    category,
    sum(sales*price) as total_sales
from 
    base
group by 
    author_id, author_name, category
order by 
    author_id asc, category desc