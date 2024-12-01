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
    a.user_id as USER_ID,
    replace(a.nickname,',','') as NICKNAME,
    concat(a.city,' ',replace(a.street_address1,'경기도 성남시 분당구 성남대로171','분당구 성남대로 171'),' ',a.street_address2) as "전체주소",
    concat(left(a.tlno,3),'-',substring(a.tlno,4,4),'-',right(a.tlno,4)) as "전화번호"
from 
    used_goods_user a 
inner join 
    base b
on 
    b.writer_id = a.user_id
order by 
    a.user_id desc