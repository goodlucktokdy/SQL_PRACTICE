with base as (
    select
        a.book_id,
        a.author_id,
        a.category,
        a.price,
        b.sales
    from 
        book a
    left join 
        book_sales b
    on 
        a.book_id = b.book_id
    where
        date_format(b.sales_date,'%Y-%m') = '2022-01' 
), revenue_cte as (
    select
        a.book_id,
        a.author_id,
        b.author_name,
        a.category,
        a.price * a.sales as revenue
    from 
        base a 
    inner join 
        author b
    on 
        a.author_id = b.author_id
)
select
    author_id,
    author_name,
    category,
    sum(revenue) as total_sales
from 
    revenue_cte
group by 
    author_id, author_name, category
order by 
    author_id asc, category desc