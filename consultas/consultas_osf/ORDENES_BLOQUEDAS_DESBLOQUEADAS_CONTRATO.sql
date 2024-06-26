select oo.*
  from open.or_order oo, open.Or_Order_Activity ooa
 where oo.order_id = ooa.order_id
   and ooa.package_id = 200271871
   and oo.order_status_id = 5;
select oo.*
  from open.or_order oo, open.Or_Order_Activity ooa
 where oo.order_id = ooa.order_id
   and ooa.package_id = 200271871
   and oo.order_status_id = 11;
select gc.valor_asignado Valor_asignado_contrato
  from open. ge_contrato gc
 where gc.id_contrato in
       nvl((select oo.defined_contract_id
             from open.or_order oo, open.Or_Order_Activity ooa
            where oo.order_id = ooa.order_id
              and ooa.package_id = 200271871
              and oo.order_status_id = 5
            group by oo.defined_contract_id),
           6801);
select sum(oo.estimated_cost) Costo_Estimado, oo.defined_contract_id
  from open.or_order oo, open.Or_Order_Activity ooa
 where oo.order_id = ooa.order_id
   and ooa.package_id = 200271871
   and oo.order_status_id in (5, 11)
   and oo.defined_contract_id is not null
 group by oo.defined_contract_id;
