with avg_sal_cte as (
    select
        dept_id,
        avg(sal) as avg_sal
    from 
        hr_employees
    group by 
        dept_id
)
select
    a.dept_id,
    b.dept_name_en,
    round(a.avg_sal) as avg_sal
from 
    avg_sal_cte a 
inner join 
    hr_department b 
on 
    a.dept_id = b.dept_id
order by 
    a.avg_sal desc