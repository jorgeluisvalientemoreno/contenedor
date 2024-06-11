select l.cocltiso,
       l.cocltitr,
       t.description,
       l.coclacpa,
       l.coclcaus,
       c.description,
       l.coclcate,
       l.coclsuca,
       l.coclmere,
       l.coclacti,
       i.description,
       l.coclasau,
       l.cocldias,
       l.coclcame
  from open.ldc_cottclac l
 inner join open.or_task_type  t  on t.task_type_id = l.cocltitr
 inner join open.ge_causal  c  on c.causal_id = l.coclcaus
 inner join open.ge_items  i  on i.items_id = l.coclacti
 where l.cocltitr = 12667
   and l.coclcaus = 3799
