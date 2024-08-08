select oo.task_type_id,
       oo.order_id,
       oo.created_date,
       oo.legalization_date,
       oo.execution_final_date,
       ooa.product_id,
       oou.contractor_id,
       ooa.address_id,
       oo.operating_unit_id,
       oo.defined_contract_id,
       c.id_tipo_contrato,
       c.status,
       oo.is_pending_liq,
       oo.order_value
  from open.or_operating_unit oou
  inner join open.or_order oo on oo.operating_unit_id = oou.operating_unit_id
  inner join open.or_order_activity ooa on ooa.order_id = oo.order_id
  inner join ge_contrato  c on c.id_contrato  = oo.defined_contract_id
 where oo.order_status_id = 8
   and oo.legalization_date <= '30/08/2022'
   and oo.is_pending_liq = 'Y'
   and ca.class_causal_id = 1 
   and c.id_tipo_contrato = 910
   and c.status = 'AB'
