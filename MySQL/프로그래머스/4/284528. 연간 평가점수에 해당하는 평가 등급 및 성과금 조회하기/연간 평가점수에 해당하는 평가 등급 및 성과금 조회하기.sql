with base as (
select
    b.emp_no,
    a.emp_name,
    a.sal,
    avg(b.score) as score
from 
    hr_employees a
left join
    hr_grade  b
on 
    a.emp_no = b.emp_no
group by 
    1,2,3
)
select
    emp_no,
    emp_name,
    case when
        score >= 96 then 'S'
        when score >= 90 then 'A'
        when score >= 80 then 'B'
        else 'C' end as grade,
    case when
        score >= 96 then sal * 0.2
        when score >= 90 then sal * 0.15
        when score >= 80 then sal * 0.1
        else 0 end as bonus
from 
    base
order by 
    emp_no asc
        