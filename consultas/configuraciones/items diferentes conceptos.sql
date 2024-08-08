with titrvsi as(select ti.task_type_id
from open.ps_engineering_activ a, open.or_task_types_items ti
where a.items_id=ti.items_id)
, adicionaleslego as (select l.tipotrabadiclego_id
from titrvsi t, open.ldc_tipotrabadiclego l
where t.task_type_id=l.tipotrablego_id)
, regenera as(select ti2.task_type_id
from titrvsi t, open.or_regenera_activida r, open.or_task_types_items ti, open.or_task_types_items ti2
where t.task_type_id=ti.task_type_id
 and ti.items_id=r.actividad
 and r.actividad_regenerar=ti2.items_id)
,planeadas as(select ti2.task_type_id
from titrvsi t, open.or_planned_activit p, open.or_task_types_items ti, open.or_task_types_items ti2
where t.task_type_id=ti.task_type_id
  and p.activity_id=ti.items_id
  and ti2.items_id=p.planned_activity_id)
, todos as(
select *
from titrvsi
union all
select *
from adicionaleslego
union all
select *
from regenera
union all
select *
from planeadas)
select ti.items_id, count(distinct t.concept)--t.task_type_id, t.description, t.concept, ti.items_id
from todos 
inner join open.or_task_type t on t.task_type_id=todos.task_type_id
inner join open.or_task_types_items ti on ti.task_type_id=t.task_type_id
HAVING COUNT(DISTINCT T.CONCEPT)>1
group by ti.items_id
