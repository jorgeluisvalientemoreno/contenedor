select o.task_type_id,
       t.description,
       causal_id,
       (select description from open.ge_causal c where c.causal_id=o.causal_id) desc_causal,
       procedimiento,
       descripcion,
       orden_ejec,
       activo
from open.ldc_procedimiento_obj o
inner join open.or_task_type t on t.task_type_id=o.task_type_id
where upper(procedimiento) like upper ('%LDC_PRVPMUPDATEFECHA%')
