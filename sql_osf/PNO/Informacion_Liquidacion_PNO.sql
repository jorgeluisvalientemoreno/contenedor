--Proyecto PNO
select t.possible_ntl_id PNO,
       pp.subscription_id Contrato,
       t.product_id Producto,
       pp.product_type_id || ' - ' || S.SERVDESC Servicio,
       t.informer_subs_id || ' - ' || gs.subscriber_name || ' ' ||
       gs.subs_last_name Cliente,
       t.fraud_start_date Fecha_Inicio,
       t.fraud_end_date Fecha_Fin,
       t.last_cons_avg Promedio,
       t.*
  from open.FM_POSSIBLE_NTL t
 inner join open.ge_subscriber gs
    on gs.subscriber_id = t.informer_subs_id
 inner join open.pr_product pp
    on pp.product_id = t.product_id
 inner join OPEN.SERVICIO S
    on S.SERVCODI = pp.product_type_id
 where 1 = 1
      --and t.product_id in (17000299)
   and t.possible_ntl_id = 515283;

--Cargos de consumo
select * from open.FM_PREINVOICE_PNO fpp where fpp.package_id = 231282944;

--Cargos de consumo
select fpp.pecscons || ' [' || pc.pecsfeci || ' - ' || pc.pecsfecf || ']' Periodo_Consumo,
       fpp.units_avg_negot Consumo_Promedio,
       fpp.units_meas_oper Facturadas,
       fpp.units_unbilled Sin_Facturar,
       (select sum(a.cargvalo)
          from OPEN.FM_PREINVOICE_PNO a
         where a.preinvoice_parent_id = fpp.preinvoice_pno_id) Valor
  from open.FM_PREINVOICE_PNO fpp
 inner join open.pericose pc
    on pc.pecscons = fpp.pecscons
 where fpp.package_id = 231282944
   and fpp.cargvalotype = 'C';

--Cargos dependientes
select fpp.conccodi || ' - ' || C.CONCDESC Concepto,
       fpp.description Tipo_Consumo,
       fpp.units_meas_oper Unidades,
       fpp.cargvalo Valor
  from open.FM_PREINVOICE_PNO fpp
 INNER JOIN OPEN.CONCEPTO C
    ON C.CONCCODI = FPP.CONCCODI
 where fpp.preinvoice_parent_id = 1296590
   and fpp.cargvalotype != 'C';

--Cargos adicionales
select fpp.conccodi || ' - ' || C.CONCDESC Concepto,
       fpp.cacacodi || ' - ' || CC.CACADESC Causa,
       fpp.cargvalo Valor
  from open.FM_PREINVOICE_PNO fpp
 INNER JOIN OPEN.CONCEPTO C
    ON C.CONCCODI = FPP.CONCCODI
 INNER JOIN OPEN.CAUSCARG CC
    ON CC.CACACODI = fpp.cacacodi
 where fpp.package_id = 231282944
   and fpp.cargvalotype = 'O';
