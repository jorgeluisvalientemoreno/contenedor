select oo.defined_contract_id Contrato,
       sum(oo.estimated_cost) Costo_Estimado,
       count(1) Cantidad_Ordenes
  from open.or_order_activity ooa, open.or_order oo, open.mo_packages mp
 where ooa.order_id = oo.order_id
   and oo.task_type_id = 12149
   and mp.package_id(+) = ooa.package_id
   and mp.package_id in (195263154)
   --and oo.order_status_id = 5
 group by oo.defined_contract_id
