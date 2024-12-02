with base as (
    select
        writer_id,
        count(distinct board_id) as cnts
    from 
        used_goods_board
    group by 
        writer_id
    having
        cnts >= 3
)
select
    distinct
    a.user_id,
    a.nickname,
    concat(a.city,' ',a.street_address1,' ',a.street_address2) as '전체주소',
    concat(left(a.tlno,3),'-',substring(a.tlno,4,4),'-',right(a.tlno,4)) as '전화번호'
from 
    used_goods_user a
inner join 
    base b
on
    a.user_id = b.writer_id
order by 
    a.user_id desc