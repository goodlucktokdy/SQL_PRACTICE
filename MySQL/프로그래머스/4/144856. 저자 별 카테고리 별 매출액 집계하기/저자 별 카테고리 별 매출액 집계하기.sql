with base as (
select
    distinct
    a.author_id,
    a.book_id,
    b.sales_date,
    c.author_name,
    a.category,
    b.sales,
    a.price
from
    book a
left join
    book_sales b
on
    a.book_id = b.book_id
left join
    author c
on
    a.author_id = c.author_id
)
select
    author_id,
    author_name,
    category,
    sum(sales * price) as total_sales
from
    base
where
    sales_date between '2022-01-01' and '2022-01-31'
group by
    category, author_id
order by
    author_id asc, category desc

    