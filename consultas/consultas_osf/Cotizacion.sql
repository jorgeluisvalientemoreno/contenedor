
--venta cotizada personalizada en estado aprobada y asociada a una venta cotizada
select /*mpa.package_id, mp.tag_name, mp.motive_status_id, mp.attention_date , */
 cc.*, dcc.*
  from open.ldc_cotizacion_comercial cc
 inner join open.DATOS_COTIZACION_COMERCIAL dcc
    on cc.id_cot_comercial = dcc.id_cot_comercial
 inner join open.mo_packages_asso mpa
    on mpa.package_id_asso = cc.sol_cotizacion
 inner join open.mo_packages mp
    on mp.package_id = mpa.package_id
 inner join open.mo_motive mm
    on mm.package_id = mp.package_id
 where cc.estado = 'A'
   and mp.motive_status_id in (14, 32)
 order by cc.fecha_registro desc;

select (select ab.geograp_location_id || ' - ' || ab.address
          from ab_address ab
         where ab.address_id = co.id_direccion) Direccion,
       gs.identification,
       gs.subscriber_name,
       co.*
  from open.ldc_cotizacion_comercial co, open.ge_subscriber gs
 where gs.subscriber_id = co.cliente
   and co.estado in ('A') --('A','E')
/*and co.sol_cotizacion =
(select mp.package_id
   from open.mo_packages mp
  where mp.package_id = co.sol_cotizacion
    and mp.motive_status_id = 13)*/
--and gs.identification = '900491486'
 order by co.fecha_registro desc;
select t.*, rowid
  from open.DATOS_COTIZACION_COMERCIAL t
 where t.id_cot_comercial in
       (select co.id_cot_comercial from open.ldc_cotizacion_comercial co)
 order by t.id_cot_comercial desc;
select mp.package_id, mp.tag_name, dcc.iva_porcentaje
  from open.ldc_cotizacion_comercial cc
 inner join open.DATOS_COTIZACION_COMERCIAL dcc
    on cc.id_cot_comercial = dcc.id_cot_comercial
 inner join open.mo_packages_asso mpa
    on mpa.package_id_asso = cc.sol_cotizacion
 inner join open.mo_packages mp
    on mp.package_id = mpa.package_id
 inner join open.mo_motive mm
    on mm.package_id = mp.package_id
--and mm.product_id = 52726524
 where cc.estado = 'A'
 order by cc.fecha_registro desc;
select *
  from OPEN.LDC_ITEMS_COTIZACION_COM cm, open.ge_items i
 where cm.id_cot_comercial  in (8308, 8316)
   and cm.id_item = i.items_id;
select (select a.cargconc || ' - ' || a1.concdesc
          from open.concepto a1
         where a1.conccodi = a.cargconc),
       a.*
  from open.cargos a
 where a.cargnuse = 52687626
   and a.cargfecr > sysdate - 5
 order by a.cargfecr;
SELECT * FROM cc_quotation a where a.package_id = 202795;
SELECT *
  FROM open.cc_quotation_item a
 where a.quotation_id -- in (25113,25128)
       (SELECT a.quotation_id
          FROM cc_quotation a
         where a.package_id = 192609020);
select *
  from open.ldc_cotizacion_comercial l
 where l.sol_cotizacion = 192609020;
SELECT /*+ index( a IDX_CC_QUOTATION01 ) */
 a.*, a.rowid
  FROM /*+ CC_BCQuotation.cuAttValidQuotByPack */ cc_quotation a
 WHERE
--a.package_id = inuPackageId
--AND     
 a.status = CC_BOQuotationUtil.fsbGetQuotationAttStat
 AND trunc(a.end_date) >= trunc(sysdate);
SELECT /*+ index( a IDX_CC_QUOTATION01 ) */
 a.quotation_id
  FROM /*+ CC_BCQuotation.cuActQuotByPack */ cc_quotation a
 WHERE
--a.package_id = inuPackageId
--AND     
 a.status <> CC_BOQuotationUtil.fsbGetQuotationAnnStat;

select (select ab.address
          from ab_address ab
         where ab.address_id = co.id_direccion) Direccion,
       gs.identification,
       gs.subscriber_name,
       co.*
  from open.ldc_cotizacion_comercial co, open.ge_subscriber gs
 where gs.subscriber_id = co.cliente
      --and co.estado in ('A', 'E')
      --co.id_cot_comercial=7461
   and gs.identification = '1143127330'
 order by co.fecha_registro desc;
select *
  from OPEN.LDC_ITEMS_COTIZACION_COM cm, open.ge_items i
 where cm.id_cot_comercial = &cotizacion
   and cm.id_item = i.items_id;
select (select a.cargconc || ' - ' || a1.concdesc
          from open.concepto a1
         where a1.conccodi = a.cargconc),
       a.*
  from open.cargos a
 where a.cargnuse = 52687626
   and a.cargfecr > sysdate - 5
 order by a.cargfecr;
select CO.*, ROWID
  from open.ldc_cotizacion_comercial co
 where id_cot_comercial = &cotizacion;
/*update OPEN.LDC_ITEMS_COTIZACION_COM cm set cm.iva = 27295
 where cm.id_cot_comercial = &cotizacion and cm.actividad = 4295751;
-- commit;*/
select cm.*, ROWID
  from OPEN.LDC_ITEMS_COTIZACION_COM cm
 where cm.id_cot_comercial = &cotizacion;
select CM.*, ROWID
  from ldc_tipotrab_coti_com cm
 where cm.id_cot_comercial = &cotizacion;
select QW.*, ROWID
  from open.cc_quoted_work qw
 where qw.quotation_id =
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where id_cot_comercial = &cotizacion));
select Q.*, ROWID
  from open.cc_quotation q
 where q.quotation_id in (25113); q.package_id =
       (select co.sol_cotizacion
          from open.ldc_cotizacion_comercial co
         where id_cot_comercial = &cotizacion);
select QI.*, ROWID
  from open.cc_quotation_item qi
 where qi.quotation_id  in (25113)
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where id_cot_comercial = &cotizacion));
select CC.*, ROWID
  from open.cc_quot_financ_cond cc
 where cc.quotation_id  in (25113,25128)
       (select q.quotation_id
          from open.cc_quotation q
         where q.package_id =
               (select co.sol_cotizacion
                  from open.ldc_cotizacion_comercial co
                 where id_cot_comercial = &cotizacion));

-------------
select (select ab.address_id || ' - ' || ab.address
          from ab_address ab
         where ab.address_id = co.id_direccion) Direccion,
       gs.subscriber_id,
       gs.identification,
       gs.subscriber_name,
       co.*
  from open.ldc_cotizacion_comercial co, open.ge_subscriber gs
 where co.estado in ('A', 'E')
   and gs.subscriber_id = co.cliente
--co.id_cot_comercial=7636
 order by co.fecha_registro desc;
select *
  from OPEN.LDC_ITEMS_COTIZACION_COM cm, open.ge_items i
 where cm.id_cot_comercial = 7636
   and cm.id_item = i.items_id;
select *
  from open.cc_quotation q
 where q.package_id in (select co.sol_cotizacion
                          from open.ldc_cotizacion_comercial co
                         where co.estado in ('A', 'E'))
 order by q.register_date desc;
select * from open.cc_quotation_item qi where qi.quotation_id = 23374;
select * from open.cc_quot_financ_cond cc where cc.quotation_id = 23374;
select * from open.cc_quoted_work qw where qw.quotation_id = 23374;
--Cargos
select (select a.cargconc || ' - ' || a1.concdesc
          from open.concepto a1
         where a1.conccodi = a.cargconc),
       a.*
  from open.cargos a
 where a.cargnuse = 52687626
   and a.cargfecr > sysdate - 5
 order by a.cargfecr;
select mp.*, rowid
  from open.mo_packages mp
 where mp.package_id = 204790705;
