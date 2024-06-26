--Tipo de trabajo PL contra QH
select ott.*
  from open.or_task_type@osfpl ott
 where ott.task_type_id in (10444)
minus
select ott.* from or_task_type ott where ott.task_type_id in (10444);
--tipo trabajo x causal PL contra QH
select *
  from open.or_task_type_causal@osfpl ottc1
 where ottc1.task_type_id in (10444)
minus
select *
  from or_task_type_causal ottc1
 where ottc1.task_type_id in (10444);

--Tipo trabajo x Items PL contra QH
select pltt0.*
  from open.or_task_types_items@osfpl pltt0
 where pltt0.task_type_id in (10444)
minus
select pltt0.*
  from or_task_types_items pltt0
 where pltt0.task_type_id in (10444);

--Tipos de trbajo x Datos Adicionales PL contra QH
select b.*
  from open.or_tasktype_add_data@osfpl a, open.ge_attrib_set_attrib@osfpl b
 where a.task_type_id = 10444
   and a.attribute_set_id = b.attribute_set_id
minus
select b.*
  from or_tasktype_add_data a, ge_attrib_set_attrib b
 where a.task_type_id = 10444
   and a.attribute_set_id = b.attribute_set_id
