with base as (
    select 
        a.emp_no,
        a.emp_name,
        b.year,
        a.sal,
        avg(b.score) as avg_score
    from 
        hr_employees a 
    left join
        hr_grade b 
    on 
        a.emp_no = b.emp_no
    group by 
        a.emp_no, a.emp_name, b.year, a.sal
)
select
    emp_no,
    emp_name,
    case when avg_score >= 96 then 'S'
        when avg_score >=90 then 'A'
        when avg_score >= 80 then 'B'
        else 'C' end as grade,
    case when avg_score >= 96 then sal * 0.2
        when avg_score >=90 then sal * 0.15
        when avg_score >= 80 then sal * 0.1
        else sal * 0 end as bonus
from 
    base 
order by 
    emp_no asc
