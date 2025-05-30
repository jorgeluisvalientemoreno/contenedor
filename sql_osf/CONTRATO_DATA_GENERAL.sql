select sc.suscclie Cliente,
       trim(gs.subscriber_name) || ' ' || trim(gs.subs_last_name) Nombre,
       gs.ident_type_id || ' - ' || git.description Tipo_Identificacion,
       gs.identification Identificacion,
       sc.susccodi Contrato,
       ss.sesucicl Ciclo_Servicio,
       pf.pefacodi || ' - ' || pf.pefadesc Perido_Facturacion_Activo,
       pf.pefafimo Fecha_incial,
       pf.pefaffmo Fecha_Final,
       sc.susciddi || ' - ' || direccioncontrato.address Direccion_Cobro,
       pp.address_id || ' - ' || direccionservicio.address Direccion_Servicio,
       pp.product_id Servicio,
       pp.product_type_id || ' - ' || s.servdesc Servicio,
       s.servdimi DIAS_MINIMOS_PARA_FACTURAR, --Dias mininos para generar factura despues de crear el producto
       pp.product_status_id || ' - ' || pps.description Estado_Producto,
       ss.sesuesco || ' - ' || ec.escodesc Estado_servicio,
       DECODE(ss.sesuesfn,
              'A',
              'A - Al dia',
              'D',
              'D - Con Deuda',
              'C',
              'C - Castigado',
              'M',
              'M - Mora',
              ss.sesuesfn) Estado_financiero,
       pp.creation_date Fecha_instalacion,
       emss.emsscoem Medidor,
       (select max(lem.leemfele)
          from open.lectelme lem
         where lem.leemsesu = pp.product_id) Fecha_ultima_lectura,
       (select lem1.leemleto
          from open.lectelme lem1
         where lem1.leemsesu = pp.product_id
           and lem1.leemfele =
               (select max(lem.leemfele)
                  from open.lectelme lem
                 where lem.leemsesu = pp.product_id)) Ultima_Lectura,
       pp.suspen_ord_act_id Actividad_Suspension,
       ordensuspension.order_id Orden_Suspension,
       ordensuspension.task_type_id || ' - ' || ttsuspension.description Tipo_Trabajo_suspension,
       ppsus.register_date Fecha_suspension,
       ppsus.suspension_type_id || ' - ' || gst.description Tipo_suspension,
       actividadsuspension.package_id Solicitud_suspension,
       pp.commercial_plan_id || ' - ' || ccp.description Plan_comercial,
       decode(sc.suscnupr,
              0,
              '0 - No tiene Cargos',
              2,
              '2 - Cargos Generados Pednidentes por Factura',
              sc.suscnupr || ' - Otros') Cargos_Generados
  from OPEN.SUSCRIPC sc
  left join open.pr_product pp
    on pp.subscription_id = sc.susccodi
  left join open.servicio s
    on s.servcodi = pp.product_type_id
  left join open.ps_product_status pps
    on pps.product_status_id = pp.product_status_id
  left join OPEN.GE_SUBSCRIBER gs
    on gs.subscriber_id = sc.suscclie
  left join OPEN.ge_identifica_type git
    on git.ident_type_id = gs.ident_type_id
  left join OPEN.elmesesu emss
    on emss.emsssesu = pp.product_id
   and sysdate between emss.emssfein and emss.emssfere
  left join OPEN.servsusc ss
    on ss.sesunuse = pp.product_id
  left join open.estacort ec
    on ec.escocodi = ss.sesuesco
  left join open.perifact pf
    on pf.pefacicl = ss.sesucicl
   and pf.pefaactu = 'S'
  left join pr_prod_suspension ppsus
    on ppsus.product_id = pp.product_id
   and ppsus.active = 'Y'
  left join open.ge_suspension_type gst
    on gst.suspension_type_id = ppsus.suspension_type_id
  left join open.or_order_activity actividadsuspension
    on actividadsuspension.order_activity_id = pp.suspen_ord_act_id
  left join open.or_order ordensuspension
    on ordensuspension.order_id = actividadsuspension.order_id
  left join open.or_task_type ttsuspension
    on ttsuspension.task_type_id = ordensuspension.task_type_id
  left join open.ab_address direccioncontrato
    on direccioncontrato.address_id = sc.susciddi
  left join open.ab_address direccionservicio
    on direccionservicio.address_id = pp.address_id
  left join open.cc_commercial_plan ccp
    on ccp.commercial_plan_id = pp.commercial_plan_id
-- 
 where sc.susccodi = 1142563 -- 48095849 --17121552 --
--and pp.product_status_id = 1
--and 
-- pp.product_type_id = 7014
-- and rownum <= 20

;
