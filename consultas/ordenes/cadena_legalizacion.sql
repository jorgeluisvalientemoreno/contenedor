with causal as(
select c.causal_id,
       c.class_causal_id,
       decode(c.class_causal_id,1,1,0) cantidad,
       decode(c.class_causal_id,1,'C','I') uso
from open.ge_causal c
where c.causal_id=1)
, datos_ad as(
select LISTAGG( a.name_attribute||'='||decode(mandatory,'Y','REQUERIDO','NO_REQUERIDO'),';')  within group(order by tda.order_, gd.capture_order asc) as datos_adicionales
from open.or_tasktype_add_data tda
inner join open.ge_attrib_set_attrib gd on gd.attribute_set_id = tda.attribute_set_id
inner join open.ge_attributes a on a.attribute_id = gd.attribute_id
inner join causal c on tda.use_ = 'B' or tda.use_ =c.uso 
where tda.task_type_id=10444
  and tda.active='Y'
  )
 , atributos_actividad as 
 (  select ti.items_id, (select atr.name_attribute||'>VALOR_ATRIBUTO1>'||a.component_1_id||'>' from open.ge_attributes atr where atr.attribute_id=a.attribute_1_id)||';'||(select atr.name_attribute||'>VALOR_ATRIBUTO2>'||a.component_2_id||'>' from open.ge_attributes atr where atr.attribute_id=a.attribute_2_id)||';'||(select atr.name_attribute||'>VALOR_ATRIBUTO3>'||a.component_3_id||'>' from open.ge_attributes atr where atr.attribute_id=a.attribute_3_id)||';'||(select atr.name_attribute||'>VALOR_ATRIBUTO4>'||a.component_4_id||'>' from open.ge_attributes atr where atr.attribute_id=a.attribute_4_id)||';' atributos
 --- nombre_atributo>valor>id_componente> 
  from open.or_task_types_items ti
  inner join open.ge_items i on i.items_id=ti.items_id and i.item_classif_id=2
  inner join open.ge_items_attributes a on a.items_id=i.items_id
  where not exists(select null from open.ct_item_novelty n where n.items_id=i.items_id)
    and task_type_id=10444) 
  select o.order_id orden,
         1 causal,
         9999 persona,
         (select * from datos_ad) datos_adicionales,
         a.order_activity_id||'>'||c.cantidad||';'||ac.atributos actividades,
         'ITEM1>CANTIDAD1>Y;ITEM2>CANTIDAD2>Y' items,
         'LECTURA1<LECTURA2' lectura,
         '1271;Comentario' comentario,
         'fecha_inicial;fecha_final' fechas
  from open.or_order o
  inner join open.or_order_activity a on a.order_id=o.order_id and a.status='R' and o.task_type_id=a.task_type_id
  inner join causal c on c.causal_id is not null
  inner join atributos_actividad ac on ac.items_id = a.activity_id
  where o.task_type_id=10444 
    and o.order_status_id=5
    and o.order_id=337033881
  ;