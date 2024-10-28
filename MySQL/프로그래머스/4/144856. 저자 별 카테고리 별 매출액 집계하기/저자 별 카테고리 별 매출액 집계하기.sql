with base as (
    select
        a.book_id,
        a.sales_date,
        a.sales,
        b.price,
        c.author_id,
        c.author_name,
        b.category
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
        sales_date between '2022-01-01' and '2022-01-31'
)
select 
    author_id,
    author_name,
    category,
    sum(sales*price) as sales
from 
    base
group by
    1,2,3
order by 
    author_id, category desc