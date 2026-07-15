select t.tipotrablego_id,
       tr.description,
       tr.concept,
       t.causallego_id,
       c.description,
       ta.tipotrabadiclego_id,
       tr2.description,
       ta.causaladiclego_id,
       c2.description,
       tr2.concept
  from open.ldc_tipotrablego t
 inner join open.or_task_type tr on tr.task_type_id = t.tipotrablego_id
 left join  open.ge_causal  c on c.causal_id = t.causallego_id
 left join  open.ldc_tipotrabadiclego ta  on ta.tipotrablego_id = t.tipotrablego_id
 left join open.or_task_type tr2 on tr2.task_type_id = ta.tipotrabadiclego_id
 left join  open.ge_causal  c2 on c2.causal_id = ta.causaladiclego_id
 where 1= 1
 --and ta.tipotrabadiclego_id in (10714, 10716, 10720, 10721, 10722)
and  t.tipotrablego_id in (10723, 10833, 10444)
 --and tr2.concept is not null;

-- trabajos padre: 10723, 10833

-- trabajos hijos: 10714, 10716, 10720, 10721, 10722

-- Conceptos: 739, 1086, 203, 

select *
from or_task_type tr
where tr.task_type_id in (10444, 10714, 10716, 10720, 10721, 10722)

select *
from or_task_types_items tr1
join ge_items  i  on i.items_id = tr1.items_id
where tr1.task_type_id in (10444, 10714, 10716, 10720, 10721, 10722)
and   i.item_classif_id = 2
and i.description not like '%NOVEDAD%'

--actividades: 100003630,100003631,100003629,100003632,100003634,100003638,100003639,100003640,
