select a.product_id, count(a.order_id)  ordenes
from mo_packages s
inner join or_order_activity  a  on a.package_id = s.package_id
where s.package_type_id = 100295
and   s.request_date >= '11/04/2023'
and   s.comment_ like '%OTREV%'
group by a.product_id
order by  count(a.order_id) desc

