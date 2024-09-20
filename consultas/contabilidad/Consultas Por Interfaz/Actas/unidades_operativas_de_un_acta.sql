select distinct/* o.order_id,*/ u.operating_unit_id, u.name, u.contractor_id, o.defined_contract_id
from open.ct_order_certifica c, open.or_order o, open.or_operating_unit u
where c.order_id=o.order_id
and o.operating_unit_id=u.operating_unit_id
and c.certificate_id = 27426
