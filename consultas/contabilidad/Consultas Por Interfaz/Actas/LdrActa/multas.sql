SELECT t.id_items
     ,(SELECT i.items_id||' - '||i.description FROM open.ge_items i WHERE i.items_id = t.id_items) descripcion_items   
     ,(SELECT oro.order_id||' - '||tit.description FROM open.or_related_order oro,open.or_order xc,open.or_task_type tit WHERE oro.related_order_id = t.id_orden AND oro.order_id = xc.order_id AND xc.task_type_id = tit.task_type_id) orden_referencia
     ,nvl(sum(t.valor_total),0) VALOR
  FROM open.ge_detalle_acta t
      ,open.ct_item_novelty n      
 WHERE id_acta ={?nro_acta}
   AND n.liquidation_sign = -1
   AND t.id_items = n.items_id   
 GROUP BY t.id_orden,t.id_items   
 ORDER BY t.id_items