with base as (
    select
        a.apnt_ymd,
        a.apnt_no,
        a.pt_no,
        a.mcdp_cd,
        a.mddr_id,
        c.pt_name,
        b.dr_name
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
        date(apnt_ymd) = '2022-04-13' 
    and
        a.MCDP_CD = 'CS'
    and
        apnt_cncl_yn = 'N'
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
    apnt_ymd