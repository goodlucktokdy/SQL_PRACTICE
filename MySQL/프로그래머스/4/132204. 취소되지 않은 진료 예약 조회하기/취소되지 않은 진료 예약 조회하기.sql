with base as (
    select
        apnt_no,
        apnt_ymd,
        pt_no,
        mcdp_cd,
        mddr_id,
        apnt_cncl_yn,
        apnt_cncl_ymd
    from 
        appointment
    where
        apnt_cncl_yn = 'N' and date(apnt_ymd) = '2022-04-13' and mcdp_cd = 'CS'
)
select
    a.apnt_no,
    b.pt_name,
    a.pt_no,
    a.mcdp_cd,
    c.dr_name,
    a.apnt_ymd
from 
    base a
left join
    patient b
on 
    a.pt_no = b.pt_no
left join
    doctor c
on 
    a.mddr_id = c.dr_id
order by 
    a.apnt_ymd asc