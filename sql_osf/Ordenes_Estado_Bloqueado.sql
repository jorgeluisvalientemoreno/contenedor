select 'Estado 11',
       sum(oo.estimated_cost) Costo_Estimado,
       oo.defined_contract_id,
       count(1) Cantidad
  from open.or_order oo, open.Or_Order_Activity ooa
 where oo.order_id = ooa.order_id
      --and ooa.package_id = 200271871
   and oo.order_status_id in (11)
   and oo.defined_contract_id is null
 group by oo.defined_contract_id;
