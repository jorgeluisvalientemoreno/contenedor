select 'Estado 5',
       sum(oo.estimated_cost) Costo_Estimado,
       oo.defined_contract_id,
       count(1) Cantidad
  from open.or_order oo, open.Or_Order_Activity ooa
 where oo.order_id = ooa.order_id
   and ooa.package_id = 200271871
   and oo.order_status_id in (5)
 group by oo.defined_contract_id;
select 'Estado 11',
       sum(oo.estimated_cost) Costo_Estimado,
       oo.defined_contract_id,
       count(1) Cantidad
  from open.or_order oo, open.Or_Order_Activity ooa
 where oo.order_id = ooa.order_id
   and ooa.package_id = 200271871
   and oo.order_status_id in (11)
 group by oo.defined_contract_id;
select gc.id_contrato,
       gc.descripcion,
       gc.fecha_inicial,
       gc.fecha_final,
       gc.valor_total_contrato,
       gc.valor_total_pagado,
       gc.id_tipo_contrato,
       gc.id_contratista,
       gc.fecha_cierre,
       gc.status,
       gc.valor_liquidado,
       gc.valor_asignado,
       gc.valor_no_liquidado
  from open.ge_contrato gc
 where gc.id_contrato in
       nvl((select oo.defined_contract_id
             from open.or_order oo, open.Or_Order_Activity ooa
            where oo.order_id = ooa.order_id
              and ooa.package_id = 200271871
              and oo.order_status_id = 5
              and oo.defined_contract_id is not null
            group by oo.defined_contract_id),
           6801);
