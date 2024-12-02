with base as (
    select
        a.emp_no,
        a.emp_name,
        b.year,
        b.half_year,
        b.score,
        a.sal
    from 
        hr_employees a
    left join 
        hr_grade b
    on 
        a.emp_no = b.emp_no
)
select
    a.emp_no,
    a.emp_name,
    case when a.avg_year_score >= 96 then 'S'
        when a.avg_year_score >= 90 then 'A'
        when a.avg_year_score >= 80 then 'B'
        else 'C' end as grade,
    case when a.avg_year_score >= 96 then a.sal * 0.2
        when a.avg_year_score >= 90 then a.sal * 0.15
        when a.avg_year_score >= 80 then a.sal * 0.1
        else 0 end as bonus
from (
    select
        emp_no,
        emp_name,
        sal,
        avg(score) as avg_year_score
    from 
        base
    group by 
        emp_no, emp_name, sal
) a
order by 
    emp_no asc