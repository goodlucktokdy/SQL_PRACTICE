with base as (
    select 
        a.board_id,
        b.views
    from 
        used_goods_board a
    inner join(
        select 
            max(views) as views
        from 
            used_goods_board
        ) b
    on
        a.views = b.views
)
select 
    concat('/home/grep/src/',b.board_id,'/',b.file_id,b.file_name,b.file_ext) as file_path
from 
    base a
join
    used_goods_file b
on 
    a.board_id = b.board_id
order by 
    b.file_id desc