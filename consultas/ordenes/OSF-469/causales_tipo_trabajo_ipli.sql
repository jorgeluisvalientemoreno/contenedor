select t.task_type_id,
       t.description,
       t.short_name,
       t.task_type_classif,
       ctt.description clasificacion_tipo_trab,
       c.causal_id,
       dc.description desc_causal,
       dc.class_causal_id,
       cc.description  desc_clase_causal,
       (select da.attribute_set_id || '-' || dda.description
          from open.or_tasktype_add_data da, open.ge_attributes_set dda
         where t.task_type_id = da.task_type_id
           and da.attribute_set_id = dda.attribute_set_id) "atributo"
  from open.or_task_type t
 inner join open.or_task_type_causal c on t.task_type_id = c.task_type_id
 inner join open.ge_causal dc on c.causal_id = dc.causal_id
 inner join open.ge_task_class ctt on t.task_type_classif = ctt.task_class_id
 inner join open.ge_class_causal cc on cc.class_causal_id = dc.class_causal_id
 where t.task_type_id in (12244)
