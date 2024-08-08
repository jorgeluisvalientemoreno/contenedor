select oo.*, rowid
  from 
  --update 
  open.or_order oo 
  --set 
  --oo.estimated_cost = 398254, 
  --oo.operating_unit_id = 4485,
  --oo.defined_contract_id  = 9441
 where oo.order_id in (select ooa.order_id
                         from open.Or_Order_Activity ooa
                        where oo.order_id = ooa.order_id
                          and ooa.package_id = 200271871)
   and oo.order_status_id <> 12
   and oo.operating_unit_id in (4485);
--398254.00
--6801
