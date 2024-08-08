select t.task_type_id,
       t.description,
       t.task_type_classif,
       ctt.description clasificacion_tipo_trab,
       c.causal_id,
       dc.description desc_causal,
       dc.class_causal_id,
       cc.description  desc_clase_causal
 from open.or_task_type t
 inner join open.or_task_type_causal c on t.task_type_id = c.task_type_id
 inner join open.ge_causal dc on c.causal_id = dc.causal_id
 inner join open.ge_task_class ctt on t.task_type_classif = ctt.task_class_id
 inner join open.ge_class_causal cc on cc.class_causal_id = dc.class_causal_id
 where t.task_type_id in (10061, 10064, 10169, 10546, 10547, 10881, 10882, 10884, 10917, 10918, 12521, 12523, 12524, 12526, 12528))
 and  cc.description = 'Exito'