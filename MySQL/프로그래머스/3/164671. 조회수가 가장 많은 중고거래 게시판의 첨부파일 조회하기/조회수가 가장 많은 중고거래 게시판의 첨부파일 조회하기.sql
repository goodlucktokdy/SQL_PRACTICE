with max_view as (
    select
        board_id
    from
        used_goods_board
    where
        views in (select max(views) from used_goods_board)
)
select
    concat('/home/grep/src/',a.board_id,'/',a.file_id,a.file_name,a.file_ext) as file_path
from 
    used_goods_file a
inner join 
    max_view b
on 
    a.board_id = b.board_id
order by 
    a.file_id desc
