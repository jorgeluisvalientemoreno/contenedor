--TIPO OFERTADOS GENERACION NOVEDAD DE ACTA DE LIQUIDACION
select LCUO.TIPO_OFERTADO || ' - ' || LTO.DESCRIPCION TIPO_OFERTADO,
       LCUO.FECHA FECHA_REGISTRO,
       LCUO.UNIDAD_OPERATIVA || ' - ' || oou.name UNIDAD_OPERATIVA,
       --LCUO.USUARIO,
       --LCUO.MAQUINA,
       --LCUO.DIRECCION_GEN_NOV,
       LCUO.CONTRATO,
       LTO.PROCEDIMIENTO_EJECUTAR
  from OPEN.LDC_CONST_UNOPRL LCUO
  left JOIN OPEN.LDC_TIPOS_OFERTADOS LTO
    ON LTO.CODIGO_TIPO = LCUO.TIPO_OFERTADO
  left join open.or_operating_unit oou
    on oou.operating_unit_id = LCUO.UNIDAD_OPERATIVA
 where 1 = 1
   and oou.operating_unit_id = 4688
 order by LCUO.TIPO_OFERTADO asc;
--UNIDADES OPERATIVAS QUE APLICAN PARA NUEVO ESQUEMA DE LIQUIDACION
select a.*, rowid from OPEN.LDC_CONST_UNOPRL a;

--Configuracion actividad de novedad de ofertados por tipo de trabajo
select a.*, rowid from OPEN.LDC_TIPO_TRAB_X_NOV_OFERTADOS a;
--ITEMS PERMITIDOS LEGALIZAR LAS UNIDADES OPERATIVAS QUE APLICAN PARA NUEVO ESQUEMA DE LIQUIDACION
select a.*, rowid from OPEN.LDC_ITEM_UO_LR a;
--CONFIGURACION LIQUIDACION DE CONTRATISTAS POR TARIFAS POR RANGO
SELECT * --COUNT(1) --INTO nucontaconfigura
  FROM open.ldc_const_liqtarran qw
 WHERE qw.unidad_operativa = 4688 --i.unidad_operativa
   AND qw.actividad_orden = -1 --i.actividad
   AND qw.items = 100003148
   AND qw.zona_ofertados = -1
   AND qw.valor_liquidar >= 1
   AND trunc(sysdate - 2) BETWEEN trunc(qw.fecha_ini_vigen) AND
       trunc(qw.fecha_fin_vige);

/*
PKG_LDC_UNI_ACT_OT
LDC_PROGENNOVOFERTSENSEVAESCA
LDC_PROGENERANOVELTYREDESPOS
LDC_PROGENERANOVELTYREDES
LDC_PROGENERANOVELTYRANGOXASIG
LDC_PROGENERANOVELTYOFERTADOS
LDC_PROGENERANOVELTYCARTERA
*/

SELECT ot.operating_unit_id unidad_operativa,
       ot.order_id orden,
       oa.activity_id actividad,
       oi.items_id nuitemss,
       iu.liquidacion liquidacion,
       nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada
  FROM open.or_order ot,
       open.or_order_activity oa,
       open.or_order_items oi,
       open.ldc_item_uo_lr iu,
       (SELECT fo.orden_nieta order_id
          FROM open.ct_order_certifica          oc,
               open.ldc_ordenes_ofertados_redes fo
         WHERE oc.certificate_id = &nucurtacta
           AND oc.order_id = fo.ORDEN_HIJA
           and fo.orden_nieta is not null) otn,
       open.ldc_tipo_trab_x_nov_ofertados uy,
       open.ldc_const_unoprl xu
 WHERE oi.legal_item_amount > 0 --= 1 --200-2532
   AND iu.liquidacion = 'A'
   AND xu.tipo_ofertado = 5 --200-2532
   AND ot.order_id = otn.order_id
   AND ot.order_id = oa.order_id
   AND oa.order_activity_id =
       (select ooa.activity_id
          from open.Or_Order_Activity ooa
         where ooa.order_id = ot.order_id) --open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
   AND ot.order_id = oi.order_id
   AND ot.operating_unit_id = iu.unidad_operativa
   AND oa.activity_id = iu.actividad
   AND oi.items_id = iu.item
   AND ot.task_type_id = uy.tipo_trabajo
   AND ot.operating_unit_id = xu.unidad_operativa --200-2532
   and ot.order_id = 373106160
 GROUP BY ot.operating_unit_id,
          ot.order_id,
          oa.activity_id,
          oi.items_id,
          iu.liquidacion
UNION ALL
SELECT ot.operating_unit_id,
       ot.order_id,
       iu.actividad,
       oi.items_id,
       iu.liquidacion,
       nvl(SUM(oi.legal_item_amount), 0) cantidad_legalizada
  FROM open.or_order ot,
       open.or_order_items oi,
       open.ldc_item_uo_lr iu,
       (SELECT fo.orden_nieta order_id
          FROM open.ct_order_certifica          oc,
               open.ldc_ordenes_ofertados_redes fo
         WHERE oc.certificate_id = &nucurtacta
           AND oc.order_id = fo.ORDEN_HIJA
           and fo.orden_nieta is not null) otn,
       open.ldc_tipo_trab_x_nov_ofertados uy,
       open.ldc_const_unoprl xu
 WHERE oi.legal_item_amount > 0 --= 1 --200-2532
   AND xu.tipo_ofertado = 5 --200-2532
   AND iu.liquidacion = 'I'
   AND iu.actividad = -1
   AND ot.order_id = otn.order_id
   AND ot.order_id = oi.order_id
   AND ot.operating_unit_id = iu.unidad_operativa
   AND oi.items_id = iu.item
   AND ot.task_type_id = uy.tipo_trabajo
   AND ot.operating_unit_id = xu.unidad_operativa --200-2532
   and ot.order_id = 373106160
 GROUP BY ot.operating_unit_id,
          ot.order_id,
          iu.actividad,
          oi.items_id,
          iu.liquidacion;
