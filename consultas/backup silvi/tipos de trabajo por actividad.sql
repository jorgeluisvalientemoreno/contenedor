select or_task_types_items.task_type_id tipo_trabajo,or_task_type.description , or_task_types_items.items_id actividad
from open.or_task_types_items
left join or_task_type on or_task_types_items.task_type_id = or_task_type.task_type_id
where or_task_types_items.task_type_id in (11056)
  or_task_types_items.items_id in (4000079);

select *
from or_task_types_items i
inner join ge_items  it on it.items_id = i.items_id
where i.task_type_id in (11056)
AND it.item_classif_id = 2
and   it.description not like '%NOVEDAD%'
and i.items_id in (4000044,4001237,4001238,4295392,4295470,100002357,
             100002508,100007648,100008476,100009421,100009422,100009447,100006618,
             100006989,100006990,100006330,100006982,100006983,100004199,100003638) 


 Select o.id_actividad_rol,
    o.id_rol,
    r.description as  rol,
    o.id_actividad,
    i.description as Actividad
    from open.or_actividades_rol o,
    open.sa_role  r,
    open.ge_items  i
     where o.id_rol = r.role_id
     and o.id_actividad = i.items_id
     and o.id_actividad in (4000980)
     
     select *
     from open.or_actividades_rol
     where id_actividad = 4000980 
     for update 
    
    
select *
from open.ldc_ttp_tts 
where tts_id = 10534 

select *
from open.ldc_tt_causal_warr
where task_type_id = 10534

select *
from open.ldc_garantlog
where 
LDCGTA


select *
from open.ldc_logtiptraadi
where orden_orginal = 
LDCLOGTA
