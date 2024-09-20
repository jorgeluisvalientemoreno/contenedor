SELECT id_items,descripcion_items,SUM(valor_total) valor_total
 FROM(
      SELECT 
            -1 as id_items,'-1'||' - Total ordenes' as descripcion_items,nvl(SUM(da.valor_total),0)  valor_total
        FROM open.ge_detalle_acta da
            ,open.ge_items gi
            ,open.or_order ot
       WHERE da.id_acta = {?nro_acta}
         AND gi.item_classif_id <> 23
         AND da.id_items = gi.items_id
         AND da.id_orden = ot.order_id
         AND 0 = (SELECT COUNT(1)
                   FROM open.ct_item_novelty ni
                  WHERE ni.items_id = gi.items_id)
         AND nvl(da.valor_total,0) <> 0            
      UNION ALL   
        SELECT  -1 as id_items,'-1'||' - Total ordenes' as descripcion_items,nvl(SUM(dT.valor_total),0)
          FROM open.or_related_order ro
              ,open.or_order_items oi
              ,open.ct_item_novelty nx 
              ,open.ge_detalle_acta dt
              ,open.or_order yu
              ,open.ge_items hy
         WHERE ro.rela_order_type_id = 14
           AND dt.id_acta = {?nro_acta}
           AND dt.valor_total <> 0
           AND hy.item_classif_id <> 23
           AND nx.liquidation_sign > 0
           AND ro.order_id IN(
                              SELECT       
                                     distinct(da.id_orden) orden
                                FROM open.ge_detalle_acta da
                                    ,open.ge_items gi
                                    ,open.or_order ot
                               WHERE da.id_acta = {?nro_acta}
                                 AND gi.item_classif_id <> 23
                                 AND da.id_items = gi.items_id
                                 AND da.id_orden = ot.order_id
                                 AND 0 = (SELECT COUNT(1)
                                            FROM open.ct_item_novelty ni
                                           WHERE ni.items_id = gi.items_id))
           AND ro.related_order_id = oi.order_id            
           AND oi.items_id = nx.items_id
           AND ro.related_order_id = dt.id_orden
           AND ro.order_id = yu.order_id
           AND dt.id_items = hy.items_id
      UNION ALL
        SELECT -1 as id_items,'-1'||' - Total ordenes' as descripcion_items,nvl(SUM(rd.valor_total),0)
          FROM  open.or_related_order rv 
               ,open.ge_detalle_acta rd
               ,open.ge_items ri
               ,open.or_order ro
         WHERE rv.order_id IN(
                              SELECT ro.related_order_id
                               FROM open.or_related_order ro
                                   ,open.or_order_items oi
                                   ,open.ct_item_novelty nx 
                                   ,open.ge_detalle_acta dt
                                   ,open.or_order yu
                                   ,open.ge_items hy
                              WHERE ro.rela_order_type_id = 14
                                AND dt.id_acta = {?nro_acta}
                                AND dt.valor_total <> 0
                                AND hy.item_classif_id <> 23
                                AND nx.liquidation_sign > 0
                                AND ro.order_id IN(
                                                   SELECT       
                                                        distinct(da.id_orden) orden
                                                     FROM open.ge_detalle_acta da
                                                         ,open.ge_items gi
                                                         ,open.or_order ot
                                                    WHERE da.id_acta = {?nro_acta}
                                                      AND gi.item_classif_id <> 23
                                                      AND da.id_items = gi.items_id
                                                      AND da.id_orden = ot.order_id
                                                      AND 0 = (SELECT COUNT(1)
                                                                 FROM open.ct_item_novelty ni
                                                                WHERE ni.items_id = gi.items_id))
              AND ro.related_order_id = oi.order_id            
              AND oi.items_id = nx.items_id
              AND ro.related_order_id = dt.id_orden
              AND ro.order_id = yu.order_id
              AND dt.id_items = hy.items_id)  
              AND rv.rela_order_type_id = 15
              AND rd.id_acta = {?nro_acta}
              AND ri.item_classif_id <> 23
              AND rd.valor_total <> 0
              AND rv.related_order_id = rd.id_orden
              AND rd.id_items = ri.items_id
              AND rd.id_orden = ro.order_id
      UNION ALL
        SELECT t.id_items
               ,t.id_items||' - '||(SELECT i.description FROM open.ge_items i WHERE i.items_id = t.id_items) descripcion_items
               ,nvl(sum(t.valor_total),0) VALOR
          FROM open.ge_detalle_acta t,open.ge_items i
         WHERE id_acta = {?nro_acta}
           AND i.item_classif_id = 23
           AND t.id_items = i.items_id
      GROUP BY t.id_items
      HAVING nvl(sum(t.valor_total),0)<> 0) 
GROUP BY id_items,descripcion_items
ORDER By id_items
