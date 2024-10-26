with base as (
    select
        a.emp_no,
        b.emp_name,
        a.year,
        b.sal,
        case when
            avg(a.score) >= 96 then 'S'
            when avg(a.score) >= 90 then 'A'
            when avg(a.score) >= 80 then 'B'
            else 'C' end as grade
    from 
        hr_grade a
    left join
        hr_employees b
    on
        a.emp_no = b.emp_no
    group by 
        1,2,3
)
select
    emp_no,
    emp_name,
    grade,
    case when
        grade = 'S' then sal * 0.2
        when grade = 'A' then sal * 0.15
        when grade = 'B' then sal * 0.1
        else 0 end as bonus 
from
    base
order by 
    emp_no