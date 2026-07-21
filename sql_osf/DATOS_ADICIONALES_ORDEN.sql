select d.order_id Orden,
       d.attribute_set_id || ' - ' || gas.description Grupo_Datos,
       d.task_type_id || ' - ' || ott.description Tipo_Trabajo,
       d.action_id || ' - ' || gem.description Accion,
       d.read_date Fecha_Registro,
       d.name_1,
       d.value_1,
       d.name_2,
       d.value_2,
       d.name_3,
       d.value_3,
       d.name_4,
       d.value_4,
       d.name_5,
       d.value_5,
       d.name_6,
       d.value_6,
       d.name_7,
       d.value_7,
       d.name_8,
       d.value_8,
       d.name_9,
       d.value_9,
       d.name_10,
       d.value_10,
       d.name_11,
       d.value_11,
       d.name_12,
       d.value_12,
       d.name_13,
       d.value_13,
       d.name_14,
       d.value_14,
       d.name_15,
       d.value_15,
       d.name_16,
       d.value_16,
       d.name_17,
       d.value_17,
       d.name_18,
       d.value_18,
       d.name_19,
       d.value_19,
       d.name_20,
       d.value_20
  from open.or_requ_data_value d
 inner join open.or_task_type ott
    on ott.task_type_id = d.task_type_id
 inner join open.ge_action_module gem
    on gem.action_id = d.action_id
 inner join open.ge_attributes_set gas
    on gas.attribute_set_id = d.attribute_set_id
 where 1 = 1
   and d.order_id = &orden
 order by d.read_date desc;
/*select da.*
  from open.or_order oo, open.or_requ_data_value da
 where oo.task_type_id in
       (select oo.task_type_id
          from open.or_order oo
         where oo.order_id = 284790476)
      --and oo.order_status_id = 8
   and da.order_id = oo.order_id
--and read_date >= sysdate - 100
;
select da.*, rowid
  from open.or_requ_data_value da
 where da.order_id in (284790476)*/
