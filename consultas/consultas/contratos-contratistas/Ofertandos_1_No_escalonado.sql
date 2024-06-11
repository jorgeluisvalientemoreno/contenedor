 select t.unidad_operativa
        ,t.actividad
        ,t.nuitemss
        ,nvl(SUM(t.cantidad_legalizada),0) cantidad
        from (
        SELECT ot.operating_unit_id             unidad_operativa
        ,ot.order_id                      orden
        ,oa.activity_id                   actividad
        ,-1                               nuitemss
        ,iu.liquidacion                   liquidacion
        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ct_order_certifica oc
        ,open.ldc_tipo_trab_x_nov_ofertados cx
        ,open.ldc_const_unoprl xu
   WHERE oc.certificate_id    = &nucurtacta
     AND oi.value            > 0
     AND iu.liquidacion       = 'A'
     AND xu.tipo_ofertado     = 1
     AND ot.order_id          = oc.order_id
     AND ot.order_id          = oa.order_id
     AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id          = oi.order_id
     AND ot.operating_unit_id = iu.unidad_operativa
     AND oa.activity_id       = iu.actividad
     AND oi.items_id          = decode(iu.item,-1,oi.items_id,iu.item)
     AND ot.task_type_id      = cx.tipo_trabajo
     AND ot.operating_unit_id = xu.unidad_operativa
   GROUP BY ot.operating_unit_id
           ,ot.order_id
           ,oa.activity_id
           ,oi.items_id
           ,iu.liquidacion
  UNION ALL
  SELECT ot.operating_unit_id
        ,ot.order_id
        ,iu.actividad
        ,oi.items_id
        ,iu.liquidacion
        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ct_order_certifica oc
        ,open.ldc_tipo_trab_x_nov_ofertados cx
        ,open.ldc_const_unoprl xu
   WHERE oc.certificate_id    = &nucurtacta
     AND oi.value             > 0
     AND iu.liquidacion       = 'I'
     AND xu.tipo_ofertado     = 1
     AND iu.actividad         = -1
     AND ot.order_id          = oc.order_id
     AND ot.order_id          = oa.order_id
     AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id          = oi.order_id
     AND ot.operating_unit_id = iu.unidad_operativa
     AND oa.activity_id       = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
     AND oi.items_id          = iu.item
     AND ot.task_type_id      = cx.tipo_trabajo
     AND ot.operating_unit_id = xu.unidad_operativa
   GROUP BY ot.operating_unit_id
           ,ot.order_id
           ,iu.actividad
           ,oi.items_id
           ,iu.liquidacion
   UNION ALL
  /*SELECT ot.operating_unit_id             unidad_operativa
        ,ot.order_id                      orden
        ,ah.actividad_padre               actividad
        ,-1                               nuitemss
        ,iu.liquidacion                   liquidacion
        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ldc_act_father_act_hija ah
        ,open.ct_order_certifica oc
        ,open.ldc_tipo_trab_x_nov_ofertados cx
        ,open.ldc_const_unoprl xu
   WHERE oc.certificate_id    = &nucurtacta
     AND oi.value             > 0
     AND iu.liquidacion       = 'A'
     AND xu.tipo_ofertado     = 1
     AND ot.order_id          = oc.order_id
     AND ot.order_id          = oa.order_id
     AND oa.order_activity_id = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id          = oi.order_id
     AND oa.activity_id       = ah.actividad_hija
     AND iu.actividad         = ah.actividad_padre
     AND oi.items_id          = decode(iu.item,-1,oi.items_id,iu.item)
     AND ot.task_type_id      = cx.tipo_trabajo
     AND ot.operating_unit_id = xu.unidad_operativa
   GROUP BY ot.operating_unit_id
           ,ot.order_id
           ,ah.actividad_padre
           ,oi.items_id
           ,iu.liquidacion
   UNION ALL*/
  SELECT uh.unidad_operativa_padre
        ,ot.order_id
        ,iu.actividad
        ,oi.items_id
        ,iu.liquidacion
        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ldc_unid_oper_hija_mod_tar uh
        ,open.ct_order_certifica oc
        ,open.ldc_tipo_trab_x_nov_ofertados cx
        ,open.ldc_const_unoprl xu
   WHERE oc.certificate_id         = &nucurtacta
     AND oi.value                  > 0
     AND iu.liquidacion            = 'I'
     AND xu.tipo_ofertado          = 1
     AND iu.actividad              = -1
     AND ot.order_id               = oc.order_id
     AND ot.order_id               = oa.order_id
     AND oa.order_activity_id      = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id               = oi.order_id
     AND oa.activity_id            = decode(iu.actividad,-1,oa.activity_id,iu.actividad)
     AND oi.items_id               = iu.item
     AND ot.operating_unit_id      = uh.unidad_operativa_hija
     AND iu.unidad_operativa       = uh.unidad_operativa_padre
     AND ot.task_type_id           = cx.tipo_trabajo
     AND uh.unidad_operativa_padre = xu.unidad_operativa
   GROUP BY uh.unidad_operativa_padre
           ,ot.order_id
           ,iu.actividad
           ,oi.items_id
           ,iu.liquidacion

  -----SE AGREGA SUBQUERY POR CAMBIO 231
  UNION ALL
   SELECT uh.unidad_operativa_padre
        ,ot.order_id
        ,oa.activity_id actividad
        ,/*oi.items_id*/ -1 items_id
        ,iu.liquidacion
        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ldc_unid_oper_hija_mod_tar uh
        ,open.ct_order_certifica oc
        ,open.ldc_tipo_trab_x_nov_ofertados cx
        ,open.ldc_const_unoprl xu
   WHERE oc.certificate_id         = &nucurtacta
     AND oi.value                  > 0
     AND iu.liquidacion            = 'A'
     AND xu.tipo_ofertado          = 1
     AND ot.order_id               = oc.order_id
     AND ot.order_id               = oa.order_id
     AND oa.order_activity_id      = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id               = oi.order_id
     AND oa.activity_id            = iu.actividad
     AND oi.items_id               = decode(iu.item,-1,oi.items_id,iu.item)
     AND ot.operating_unit_id      = uh.unidad_operativa_hija
     AND iu.unidad_operativa       = uh.unidad_operativa_padre
     AND ot.task_type_id           = cx.tipo_trabajo
     AND uh.unidad_operativa_padre = xu.unidad_operativa
   GROUP BY uh.unidad_operativa_padre
           ,ot.order_id
           ,oa.activity_id
           ,oi.items_id
           ,iu.liquidacion
  -- FIN CAMBIO 231
  UNION ALL
   -- 200-2438
SELECT ot.operating_unit_id        unidad_operativa
        ,ot.order_id                      orden
        ,ah.actividad_padre              actividad
        ,-1                               nuitemss
        ,iu.liquidacion                   liquidacion
        ,nvl(SUM(oi.legal_item_amount),0) cantidad_legalizada
    FROM open.or_order ot
        ,open.or_order_activity oa
        ,open.or_order_items oi
        ,open.ldc_item_uo_lr iu
        ,open.ldc_act_father_act_hija ah
        ,open.ct_order_certifica oc
        ,open.ldc_tipo_trab_x_nov_ofertados cx
        ,open.ldc_const_unoprl xu
   WHERE oc.certificate_id         = &nucurtacta
     AND oi.value                  > 0
     AND iu.liquidacion            = 'A'
     AND xu.tipo_ofertado          = 1
     AND ot.order_id               = oc.order_id
     AND ot.order_id               = oa.order_id
     AND oa.order_activity_id      = open.ldc_bcfinanceot.fnugetactivityid(ot.order_id)
     AND ot.order_id               = oi.order_id
     AND ot.operating_unit_id      = iu.unidad_operativa -- 200-2438
     AND oa.activity_id            = ah.actividad_hija -- 200-2438
     AND iu.actividad              = ah.actividad_padre -- 200-2438
     AND oi.items_id               = decode(iu.item,-1,oi.items_id,iu.item)
     AND ot.task_type_id           = cx.tipo_trabajo
     AND ot.operating_unit_id      = xu.unidad_operativa
   GROUP BY ot.operating_unit_id
           ,ot.order_id
           ,ah.actividad_padre
           ,oi.items_id
           ,iu.liquidacion) t
 GROUP BY t.unidad_operativa
           ,t.actividad
           ,t.nuitemss;           
