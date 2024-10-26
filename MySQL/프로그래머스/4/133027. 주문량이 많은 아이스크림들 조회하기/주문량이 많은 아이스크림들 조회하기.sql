with base as (
    select
        a.shipment_id,
        a.flavor,
        a.total_order
    from 
        first_half a
    union all
    select
        b.shipment_id,
        b.flavor,
        b.total_order
    from 
        july b
)
select
    flavor
from 
    base 
group by 
    flavor
order by 
    sum(total_order) desc
limit 3