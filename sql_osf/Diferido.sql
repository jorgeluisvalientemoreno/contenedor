select a.*, rowid from open.servsusc a where a.sesususc in (67504378);
select d.*, rowid from open.diferido d where d.difesusc in (67504378);
select m.*, rowid from open.movidife m where m.modisusc in (67504378);
select m.*, rowid
  from open.movidife m
 where m.modisusc in (67504378)
      --and m.modivacu = 167000
   and m.modifech >= '30/01/2024';
