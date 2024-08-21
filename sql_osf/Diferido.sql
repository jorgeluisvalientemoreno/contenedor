select a.*, rowid from open.servsusc a where a.sesususc in (67556960);
select d.*, rowid from open.diferido d where d.difesusc in (67556960);
select m.*, rowid from open.movidife m where m.modisusc in (67556960);
select m.*, rowid
  from open.movidife m
 where m.modisusc in (67556960)
      --and m.modivacu = 167000
   and m.modifech >= '10/08/2024';
