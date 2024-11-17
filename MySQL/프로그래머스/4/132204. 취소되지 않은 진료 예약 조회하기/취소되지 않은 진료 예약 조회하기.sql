with base as (
    select
        a.apnt_no,
        a.apnt_ymd,
        a.apnt_cncl_yn,
        a.pt_no,
        a.mcdp_cd,
        a.mddr_id,
        b.dr_name,
        c.pt_name
    from 
        appointment a
    left join
        doctor b
    on 
        a.mddr_id = b.dr_id and a.mcdp_cd = b.mcdp_cd
    left join
        patient c
    on 
        a.pt_no = c.pt_no
    where
        date(a.apnt_ymd) = '2022-04-13' and a.mcdp_cd = 'CS'
    and a.apnt_cncl_yn = 'N'
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
order by 
    apnt_ymd asc