with base as (
select
    a.pt_no,
    a.pt_name,
    b.apnt_ymd,
    b.apnt_no,
    b.mcdp_cd,
    b.apnt_cncl_yn,
    c.dr_name,
    c.dr_id,
    b.mddr_id
from
    appointment b
left join
    patient a
on
    b.pt_no = a.pt_no
left join
    doctor c
on
    c.dr_id = b.mddr_id
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
where
    date(apnt_ymd) = '2022-04-13'
and
    mcdp_cd = 'CS'
and
    apnt_cncl_yn = 'N'
order by
    apnt_ymd
 
