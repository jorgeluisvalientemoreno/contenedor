--plugin
select a.task_type_id || ' - ' || tt.description  tipo_trabajo,
       a.causal_id || ' - ' || c.description  causal,
       a.procedimiento,
       a.descripcion,
       a.orden_ejec,
       a.activo
    from ldc_procedimiento_obj a
    inner join or_task_type  tt  on tt.task_type_id = a.task_type_id
    left join ge_causal c  on c.causal_id = a.causal_id
   where a.procedimiento = 'PRCREALIZARCAMBIODECICLO';

/*
select *
from ldc_procedimiento_obj
where procedimiento = 'PRCREALIZARCAMBIODECICLO'
for update*/
