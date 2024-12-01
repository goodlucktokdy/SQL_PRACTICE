with base as (
    select 
        writer_id,
        count(distinct board_id) as cnts
    from 
        used_goods_board
    group by
        writer_id
    having
        count(distinct board_id) >=3
)
select 
    distinct
    b.user_id as USER_ID,
    b.nickname as NICKNAME,
    concat(b.city,' ',b.street_address1,' ',b.street_address2) as "전체주소",
    concat(left(b.tlno,3),'-',substring(b.tlno,4,4),'-',right(b.tlno,4)) as "전화번호"
from 
    base a 
left join 
    used_goods_user b
on 
    a.writer_id = b.user_id
order by 
    b.user_id desc