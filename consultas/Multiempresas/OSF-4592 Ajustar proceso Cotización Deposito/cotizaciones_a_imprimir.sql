select *
from cc_quotation c , mo_motive m , contrato 
where c.package_ID  = m.package_ID 
and subscription_id  = contrato 
and initial_payment is not null
and status='C' and c.package_ID = 229396726 
order by c.register_date desc