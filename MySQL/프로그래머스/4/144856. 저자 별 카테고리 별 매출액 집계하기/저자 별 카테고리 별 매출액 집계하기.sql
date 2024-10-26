select
    b.author_id,
    b.author_name,
    a.category,
    sum(a.price * c.sales) as total_sales
from 
    book a
join
    author b
on
    a.author_id = b.author_id
join
    book_sales c
on
    a.book_id = c.book_id
where
    c.sales_date between '2022-01-01' and '2022-01-31'
group by
    category, b.author_id, b.author_name
order by 
    b.author_id asc, a.category desc