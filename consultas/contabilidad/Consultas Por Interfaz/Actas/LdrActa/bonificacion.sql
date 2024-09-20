SELECT item AS id_items
      ,(SELECT kl.order_id||' - '||tt.description FROM open.or_related_order kl,open.or_order ou,open.or_task_type tt WHERE kl.related_order_id = orden AND kl.order_id = ou.order_id AND ou.task_type_id = tt.task_type_id) orden1
      ,item||' - '||(SELECT ti.description FROM open.ge_items ti WHERE ti.items_id = item) as descripcion_items
      ,valor FROM(
                  SELECT t.id_items item
                        ,t.id_orden orden
                        ,nvl(sum(t.valor_total),0) VALOR
                    FROM open.ge_detalle_acta t,open.ct_item_novelty n
                   WHERE id_acta = {?nro_acta}
                     AND n.liquidation_sign = 1
                     AND t.id_items = n.items_id   
                   GROUP BY t.id_items,t.id_orden   
                 MINUS
                  SELECT item,oot,SUM(valor_total) 
                    FROM(
                         SELECT       
                                da.id_items item     
                                ,da.id_orden oot 
                               ,nvl(da.valor_total,0)  valor_total
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
                         SELECT dt.id_items item   
                               ,dt.id_orden oot  
                               ,nvl(dt.valor_total,0)  valor_total
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
                         SELECT RD.id_items item  
                               ,rv.order_id oyt    
                               ,nvl(RD.valor_total,0)  valor_total
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
                            )
  GROUP BY item,oot)
ORDER BY ITEM,orden1