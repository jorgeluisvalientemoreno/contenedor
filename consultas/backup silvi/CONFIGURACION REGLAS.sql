select   o.oblecodi,
       o.actividad,
       i.description,
       o.medio_recepcion,
       o.period_conse,
       o.dias_gen_ot,
       o.gen_noti,
       o.causal_exito,
       o.actividad_critica,
       a.description,
       o.regloble
from ldc_obleacti o
inner join ge_items  i on i.items_id = o.actividad
left join ge_items  a on a.items_id = o.actividad_critica
left join LDC_RECROBLE a on reobcodi = o.oblecodi
where oblecodi = 80
