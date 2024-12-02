with filtered_users as (
    select
        writer_id,
        sum(price) as total_sales
    from 
        used_goods_board
    where 
        status = 'DONE'
    group by 
        writer_id
    having 
        total_sales >= 700000
)
select
    distinct
    b.user_id,
    b.nickname,
    a.total_sales
from 
    filtered_users a
inner join 
    used_goods_user b
on 
    a.writer_id = b.user_id
order by 
    a.total_sales asc