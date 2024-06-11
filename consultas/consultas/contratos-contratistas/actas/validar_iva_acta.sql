WITH BASE AS(select 'COSTO' TIPO,o.task_type_id, d1.descripcion_items, sum(d1.valor_total) valor,  nvl((select 'Y' from open.ct_item_novelty n where n.items_id=i.items_id),'N') es_novedad
from open.ge_detalle_acta d1, open.or_order o, open.ge_items i
where d1.id_acta= 135173    
  and d1.id_items =i.items_id
  and i.item_classif_id!=23
  and o.order_id=d1.id_orden

             
group by 'COSTO',o.task_type_id, d1.descripcion_items, i.items_id
union 
select 'IVA' TIPO,o.task_type_id, d1.descripcion_items, sum(d1.valor_total) valor, nvl((select 'Y' from open.ct_item_novelty n where n.items_id=a.activity_id),'N') es_novedad
from open.ge_detalle_acta d1, open.or_order o,  open.ge_items i, open.or_order_activity a
where d1.id_acta= 135430     
  and d1.id_items =i.items_id
  and i.item_classif_id=23
  and d1.id_items =4001293
  and o.order_id=d1.id_orden
           
  and a.order_id=o.order_id
group by 'IVA',o.task_type_id, d1.descripcion_items,  a.activity_id
order by  task_type_id, 4
)
SELECT TASK_TYPE_ID,ES_NOVEDAD, SUM(DECODE(TIPO,'COSTO',valor,0)) COSTO, SUM(DECODE(TIPO,'IVA',VALOR,0)) IVA
FROM BASE
GROUP BY ES_NOVEDAD,TASK_TYPE_ID
ORDER BY 1,2;

WITH COSTO AS
(SELECT D.ID_ACTA,OPEN.DAOR_TASK_TYPE.FSBGETDESCRIPTION(O.TASK_TYPE_ID, NULL) TITR, ORDER_ID, SUM(D.VALOR_TOTAL)
FROM OPEN.GE_DETALLE_ACTA D,OPEN.OR_ORDER O, OPEN.GE_ITEMS I
WHERE ID_aCTA=135430
 AND D.ID_ORDEN=O.ORDER_ID
 AND I.ITEMS_ID=D.ID_ITEMS
 AND I.ITEM_CLASSIF_ID!=23
GROUP  BY D.ID_ACTA, ORDER_ID, O.TASK_TYPE_ID)
SELECT COSTO.*,(SELECT SUM(D2.VALOR_TOTAL) FROM OPEN.GE_DETALLE_ACTA D2 WHERE D2.ID_ACTA=COSTO.ID_ACTA AND D2.ID_ORDEN=COSTO.ORDER_ID AND ID_ITEMS=4001293) IVA
FROM COSTO;

select o.order_id, o.task_type_id, d.id_items, d.descripcion_items, d.valor_total, 
                                   d2.id_items, d2.descripcion_items, d2.valor_total,
                                   (select r.order_id from open.or_related_order r where r.related_order_id=o.order_id)
from open.ge_detalle_Acta d
inner join open.ge_items i on i.items_id=d.id_items and i.item_classif_id!=23 
left join open.ge_detalle_acta d2 on d2.id_acta=d.id_acta and d2.id_orden=d.id_orden and d2.id_items=4001293
inner join open.or_order o on o.order_id=d.id_orden 
where d.id_acta=135430
 and d.id_items=4295393
;

select *
from open.or_order_items
where order_id=182212901;
