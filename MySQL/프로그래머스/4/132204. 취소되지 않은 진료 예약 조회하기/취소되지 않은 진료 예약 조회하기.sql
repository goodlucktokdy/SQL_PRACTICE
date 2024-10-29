with base as (
    select
        a.apnt_no,
        b.pt_name,
        a.pt_no,
        a.mcdp_cd,
        a.mddr_id,
        c.dr_name,
        a.apnt_ymd,
        a.apnt_cncl_yn
    from 
        appointment a 
    left join 
        patient b 
    on
        a.pt_no = b.pt_no
    left join 
        doctor c
    on
        a.mddr_id = c.dr_id and a.mcdp_cd = c.mcdp_cd
    where
        date(a.apnt_ymd) = '2022-04-13' and a.mcdp_cd = 'CS'
        and a.apnt_cncl_yn = 'N'
    order by 
        a.apnt_ymd asc
)
select
    apnt_no,
    pt_name,
    pt_no,
    mcdp_cd,
    dr_name,
    apnt_ymd
from 
    base 