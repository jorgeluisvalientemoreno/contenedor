with base as(select y.*,
       nvl(Y.CANTIDAD_LEGALIZADA *
           (SELECT lq.valor_liquidar
              FROM open.ldc_const_liqtarran lq
             WHERE lq.unidad_operativa = y.unidad_operativa
               AND lq.actividad_orden = -1
               AND lq.items = y.nuitemss
               AND lq.zona_ofertados = -1
               AND trunc((select fecha_fin
                           from open.ge_acta
                          where id_acta = 115398)) BETWEEN
                   trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
               and lq.cantidad_inicial <= y.metros
               and (lq.cantidad_final >= y.metros OR
                   (Y.METROS >
                   (SELECT MAX(LQ2.cantidad_final)
                        FROM open.ldc_const_liqtarran lq2
                       WHERE lq2.unidad_operativa = y.unidad_operativa
                         AND lq2.actividad_orden = -1
                         AND lq2.items = y.nuitemss
                         AND lq2.zona_ofertados = -1
                         AND trunc((select fecha_fin
                                     from open.ge_acta
                                    where id_acta = 115398)) BETWEEN
                             trunc(lq.fecha_ini_vigen) AND
                             trunc(lq.fecha_fin_vige)) AND
                   lq.cantidad_final =
                   (SELECT MAX(LQ2.cantidad_final)
                        FROM open.ldc_const_liqtarran lq2
                       WHERE lq2.unidad_operativa = y.unidad_operativa
                         AND lq2.actividad_orden = -1
                         AND lq2.items = y.nuitemss
                         AND lq2.zona_ofertados = -1
                         AND trunc((select fecha_fin
                                     from open.ge_acta
                                    where id_acta = 115398)) BETWEEN
                             trunc(lq.fecha_ini_vigen) AND
                             trunc(lq.fecha_fin_vige))))),
           0) valor_novedad_calculado
  from (select r.orden_padre,
         r.orden_hija,
         c.certificate_id,
         o.order_id,
         o.operating_unit_id unidad_operativa,
         oi.items_id nuitemss,
         iu.actividad,
         sum(oi.legal_item_amount) CANTIDAD_LEGALIZADA,
         (SELECT xt.metro_lineal
            FROM open.ldc_ordenes_ofertados_redes xt
           WHERE xt.orden_hija = r.orden_hija
             and xt.orden_nieta is null) metros,
      (select uy.actividad_positiva from  open.ldc_tipo_trab_x_nov_ofertados uy where o.task_type_id=uy.tipo_trabajo) novedad
    from open.ldc_ordenes_ofertados_redes r,
         open.ct_order_certifica          c,
         open.or_order                    o,
         open.ldc_const_unoprl            uto,
         open.or_order_items              oi,
         open.ldc_item_uo_lr iu
   where c.certificate_id = 115398
     and r.orden_hija = c.order_id
     and o.order_id = r.orden_nieta
     and uto.unidad_operativa = o.operating_unit_id
     and uto.tipo_ofertado = 5
     and oi.order_id = o.order_id
     and oi.legal_item_amount>0
     and iu.actividad=-1
     and oi.items_id=iu.item
     and iu.unidad_operativa=o.operating_unit_id
   group by r.orden_padre,
            r.orden_hija,
            c.certificate_id,
            o.order_id,
            o.operating_unit_id,
            oi.items_id,
            iu.actividad,
            o.task_type_id) y
)
select base.*,
       (select sum(d.valor_total) from open.ge_detalle_acta d, open.or_related_order r, open.or_order_activity a where d.id_acta=115398 and d.id_items= novedad and r.related_order_id=d.id_orden and r.order_id=base.order_id and a.order_id=r.related_order_id and a.comment_ like '%'||base.nuitemss) valor_novedad_acta
from base

