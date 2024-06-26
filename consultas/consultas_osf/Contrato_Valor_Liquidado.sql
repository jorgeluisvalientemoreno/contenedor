--Contrato
select * from open.ge_contrato where id_contrato = 8401;

--Valor liquidado -- Acta cerradas con valores que afectan el contrato
select sum(d.valor_total) Valor_Liquidado
  from open.ge_detalle_acta d, open.ge_ACTA a
 WHERE D.ID_ACTA = a.id_acta
   and a.id_contrato = 8401
   and d.affect_contract_val = 'Y'
   and a.estado = 'C';

--Valor Pagado -- Acta cerradas con valores que afectan el contrato y esten pagadas
select sum(d.valor_total) Valor_Pagado
  from open.ge_detalle_acta d, open.ge_ACTA a
 WHERE D.ID_ACTA = a.id_acta
   and a.id_contrato = 8401
   and a.extern_invoice_num is not null
   and d.affect_contract_val = 'Y'
   and a.estado = 'C';

--Valor No liquidado 1-- Acta Abiertas con valores que afectan el contrato 
select sum(d.valor_total) Valor_No_liquidado_1
  from open.ge_detalle_acta d, open.ge_ACTA a
 WHERE D.ID_ACTA = a.id_acta
   and a.id_contrato = 8401
   and a.extern_invoice_num is null
   and d.affect_contract_val = 'Y';

--Valor No liquidado 2-- Acta Abiertas con valores que afectan el contrato 
select decode(sum(nvl(oo.estimated_cost, 0)),
              0,
              nvl(sum(nvl(ooa.value_reference, 0)), 0),
              sum(nvl(oo.estimated_cost, 0))) Valor_No_liquidado_2
  from open.or_order oo
 inner join open.or_order_activity ooa
    on oo.order_id = ooa.order_id
 where oo.defined_contract_id = 8401
   and oo.is_pending_liq is not null;
