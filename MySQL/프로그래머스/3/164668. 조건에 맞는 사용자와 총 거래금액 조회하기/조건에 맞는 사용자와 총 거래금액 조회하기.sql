with base as (
    select
        distinct
        a.writer_id,
        b.nickname,
        a.status,
        a.price
    from 
        used_goods_board a
    inner join
        used_goods_user b
    on 
        a.writer_id = b.user_id 
    where
        a.status = 'DONE'
)
select 
    writer_id,
    nickname,
    sum(price) as total_sales
from 
    base
group by 
    writer_id, nickname
having
    sum(price) >= 700000
order by 
    sum(price) asc