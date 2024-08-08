--valor asignado= ordenes en estado 5,6,7
select (select sum(oo.estimated_cost) valor_asignado_OT
          from open.or_order oo
         where oo.defined_contract_id = 9441
           and oo.order_status_id in (5, 6, 7)),
       (select gc.valor_asignado
          from open. ge_contrato gc
         where gc.id_contrato = 9441) valor_asignado_Contrato
  from dual;

--valor no liquidado = ordenes legalizadas sin acta
select (select sum(oo.estimated_cost) valor_no_liquidado_OT
          from open.or_order oo
         where oo.defined_contract_id = 9441
           and oo.order_status_id in (8)
           and (select count(1)
                  from open.ct_order_certifica coc
                 where coc.order_id = oo.order_id) = 0),
       (select gc.valor_no_liquidado
          from open. ge_contrato gc
         where gc.id_contrato = 9441) valor_no_liquidado_Contrato
  from dual;

--valor liquidado =  ordenes legalizadas en acta sin importar estado del acta
select (select sum(oo.estimated_cost) valor_liquidado_OT
          from open.or_order oo
         where oo.defined_contract_id = 9441
           and oo.order_status_id in (8)
           and (select count(1)
                  from open.ct_order_certifica coc
                 where coc.order_id = oo.order_id) = 1),
       (select gc.valor_liquidado
          from open. ge_contrato gc
         where gc.id_contrato = 9441) valor_liquidado_Contrato
  from dual;
select gc.*, rowid from open. ge_contrato gc where gc.id_contrato = 9441
