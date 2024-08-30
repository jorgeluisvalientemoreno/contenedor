SELECT nvl(SUM(nvl(oo.estimated_cost, 0)),0) valor_asignado       
  from open.or_order oo
 where oo.order_status_id in (5, 6, 7)
   and oo.defined_contract_id = 6341;
