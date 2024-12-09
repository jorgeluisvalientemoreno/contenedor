select t.tipotrablego_id,
       tr.description,
       t.causallego_id,
       c.description,
       ta.tipotrabadiclego_id,
       tr2.description,
       ta.causaladiclego_id,
       c2.description
  from open.ldc_tipotrablego t
 inner join open.or_task_type tr on tr.task_type_id = t.tipotrablego_id
 left join  open.ge_causal  c on c.causal_id = t.causallego_id
 left join  open.ldc_tipotrabadiclego ta  on ta.tipotrablego_id = t.tipotrablego_id
 left join open.or_task_type tr2 on tr2.task_type_id = ta.tipotrabadiclego_id
 left join  open.ge_causal  c2 on c2.causal_id = ta.causaladiclego_id
 where t.tipotrablego_id in (12155);
