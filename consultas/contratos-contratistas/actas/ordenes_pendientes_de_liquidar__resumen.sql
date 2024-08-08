select c.id_tipo_contrato,
       tc.descripcion,
       oou.contractor_id,
       ct.descripcion,
       oo.defined_contract_id,
       c.status,
       up.admin_base_id,
       count (oo.order_id)
  from open.or_operating_unit oou
  inner join open.or_order oo on oo.operating_unit_id = oou.operating_unit_id
  inner join open.or_order_activity ooa on ooa.order_id = oo.order_id
  inner join open.ge_causal ca on ca.causal_id = oo.causal_id
  inner join ge_contrato  c on c.id_contrato  = oo.defined_contract_id
  inner join ge_contratista  ct on ct.id_contratista  = oou.contractor_id
  inner join or_operating_unit  up on up.operating_unit_id  = oou.operating_unit_id
  left join ge_tipo_contrato  tc on tc.id_tipo_contrato  = c.id_tipo_contrato
 where oo.order_status_id = 8
   and ca.class_causal_id = 1    
   and oo.is_pending_liq = 'Y'
   and c.status = 'AB'
 group by c.id_tipo_contrato,
         tc.descripcion,
         oou.contractor_id,
         ct.descripcion,
         oo.defined_contract_id,
         c.status,
         up.admin_base_id
