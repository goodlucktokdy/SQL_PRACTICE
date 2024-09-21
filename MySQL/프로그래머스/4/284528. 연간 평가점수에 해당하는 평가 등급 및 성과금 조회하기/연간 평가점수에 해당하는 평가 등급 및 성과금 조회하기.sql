with base as (
    select 
        a.emp_no,
        a.emp_name,
        a.dept_id,
        b.score,
        b.year,
        a.sal
    from
        hr_employees a
    join
        (select emp_no,
                year,
                avg(score) as score 
         from 
                hr_grade
         group by
            emp_no,year) b
    on  
        a.emp_no = b.emp_no
    join
        hr_department c
    on
        a.dept_id = c.dept_id
)
select
    distinct
    emp_no, 
    emp_name,
    case when
      score >= 96 then 'S'
      when score >= 90 then 'A'
      when score >= 80 then 'B'
      else 'C' end as grade,
    case when
        score >= 96 then 0.2 * sal 
        when score >= 90 then 0.15 * sal
        when score >= 80 then 0.1 * sal 
        else sal * 0 end as bonus
from
    base