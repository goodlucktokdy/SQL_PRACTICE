with base as (
    select
        a.emp_no,
        a.emp_name,
        a.sal,
        b.score
    from
        hr_employees a
    join   
        hr_grade b
    on
        a.emp_no = b.emp_no
)
select
    distinct
    emp_no,
    emp_name,
    case when
            avg(score) over (partition by emp_no) >= 96 then 'S' 
        when
            avg(score) over (partition by emp_no) >= 90 then 'A'
        when
            avg(score) over (partition by emp_no) >= 80 then 'B'
        else
            'C' end as grade,
    case when
            avg(score) over (partition by emp_no) >= 96 then sal * 0.2 
        when
            avg(score) over (partition by emp_no) >= 90 then sal * 0.15
        when
            avg(score) over (partition by emp_no) >= 80 then sal * 0.1
        else
            sal * 0 end as bonus
from
    base
order by 
    emp_no
    
    
    
    