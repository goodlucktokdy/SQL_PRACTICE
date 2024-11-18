select 
    a.apnt_no,
    b.pt_name,
    a.pt_no,
    a.mcdp_cd,
    c.dr_name,
    a.apnt_ymd
from 
    appointment a 
left join 
    patient b 
on 
    a.pt_no = b.pt_no
left join 
    doctor c
on 
    a.mddr_id = c.dr_id
where 
    a.apnt_cncl_yn = 'N' and a.mcdp_cd = 'CS' and date(a.apnt_ymd) = '2022-04-13'
order by 
    apnt_ymd asc
