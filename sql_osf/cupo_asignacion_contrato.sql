select 'Consulta' C1, A.Valor_Total_Pagado_ordenes,
       B.Valor_Total_No_Pagado_ordenes,
       C.Valor_Total_Asignado_ordenes,
       (A.Valor_Total_Pagado_ordenes +
       B.Valor_Total_No_Pagado_ordenes +
       C.Valor_Total_Asignado_ordenes) Cupo_parcial, 0 Total_contrato
  from (SELECT SUM(Valor_orden) Valor_Total_Pagado_ordenes
          FROM (select oo.order_id,
                       (nvl(ooa.value_reference, 0) + nvl(oi.value, 0)) Valor_orden
                  from open.or_order_Activity  ooa,
                       open.or_order           oo,
                       open.ct_order_certifica oc,
                       open.or_order_items     oi
                 where ooa.order_id = oo.order_id
                   and oi.order_id = oo.order_id
                   and oc.order_id = oo.order_id
                   and oo.defined_contract_id = 9421
                   and oo.is_pending_liq is null)) A,
       (SELECT SUM(Valor_orden) Valor_Total_No_Pagado_ordenes
          FROM (select oo.order_id,
                       (nvl(ooa.value_reference, 0) + nvl(oi.value, 0)) Valor_orden
                  from open.or_order_Activity ooa,
                       open.or_order          oo,
                       open.or_order_items    oi
                 where ooa.order_id = oo.order_id
                   and oi.order_id = oo.order_id
                   and oo.order_status_id = 8
                   and oo.defined_contract_id = 9421
                   and oo.is_pending_liq is not null)) B,
       (SELECT SUM(Valor_orden) Valor_Total_Asignado_ordenes
          FROM (select oo.order_id,
                       (nvl(oo.estimated_cost, 0)) Valor_orden
                  from open.or_order_Activity ooa,
                       open.or_order          oo
                 where ooa.order_id = oo.order_id
                   and oo.order_status_id in (5, 6, 7)
                   and oo.defined_contract_id = 9421))C 
                   union all
select 'Contrato' C1, co.valor_liquidado Valor_Total_Pagado_ordenes,
       co.valor_no_liquidado Valor_Total_No_Pagado_ordenes,
       co.valor_asignado Valor_Total_Asignado_ordenes,
       co.valor_total_contrato - nvl(co.valor_asignado, 0) -
       nvl(co.valor_no_liquidado, 0) - nvl(co.valor_liquidado, 0) Cupo_parcial,
       co.VALOR_TOTAL_CONTRATO Total_contrato
  from open.ge_contrato co
 WHERE co.id_contrato = 9421;

/*select oo.*
  from open.Or_Order_Activity ooa, open.or_order oo
 where ooa.order_id = oo.order_id
   --and oo.order_status_id = 11
   and ooa.package_id in (188198596,
                          192908941,
                          195612397,
                          178044525,
                          178044709,
                          178044648,
                          188757464,
                          178044449,
                          27680746);
*/
