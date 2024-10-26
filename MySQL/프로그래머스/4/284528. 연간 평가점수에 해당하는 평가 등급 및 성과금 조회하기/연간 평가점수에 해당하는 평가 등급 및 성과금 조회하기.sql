select
    a.emp_no,
    b.emp_name,
    case when 
        avg(a.score) >= 96 then 'S' 
        when avg(a.score) >= 90 then 'A'
        when avg(a.score) >= 80 then 'B'
        else 'C' end as grade,
    case when 
        avg(a.score) >= 96 then b.sal * 0.2
        when avg(a.score) >= 90 then b.sal * 0.15
        when avg(a.score) >= 80 then b.sal * 0.1
        else 0 end as bonus
from 
    hr_grade a
left join
    hr_employees b
on 
    a.emp_no = b.emp_no
group by 
    a.emp_no,b.emp_name
order by 
    a.emp_no