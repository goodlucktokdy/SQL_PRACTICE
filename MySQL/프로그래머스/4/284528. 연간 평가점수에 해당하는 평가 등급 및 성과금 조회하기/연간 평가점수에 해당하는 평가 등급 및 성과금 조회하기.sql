with base as (
    select 
        a.emp_no,
        a.emp_name,
        a.sal,
        avg(a.score) as avg_score
    from (
        select 
            a.emp_no,
            a.year,
            a.half_year,
            a.score,
            b.emp_name,
            b.sal
        from 
            hr_grade a
        left join 
            hr_employees b
        on 
            a.emp_no = b.emp_no
    ) a
    group by 
        a.emp_no, a.emp_name, a.sal
)
select
    emp_no,
    emp_name,
    case when avg_score >= 96 then 'S'
        when avg_score >= 90 then 'A'
        when avg_score >= 80 then 'B'
        else 'C' end as grade,
    case when avg_score >= 96 then sal * 0.2
        when avg_score >= 90 then sal * 0.15
        when avg_score >= 80 then sal * 0.1
        else 0 end as bonus
from 
    base
order by 
    emp_no asc