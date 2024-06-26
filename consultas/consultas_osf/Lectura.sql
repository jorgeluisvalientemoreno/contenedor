select *
  from open.lectelme l --where l.leemelme = 2651624
 inner join open.elemmedi l1
    on l.leemelme = l1.elmeidem
   and l1.elmecodi = 'K-5049317-24'
 order by l.leemfele desc;
select *
  from open.lectelme l --where l.leemelme = 2651624
 inner join open.elemmedi l1
    on l.leemelme = l1.elmeidem
   and l1.elmecodi = 'F-2374821-Z'
 order by l.leemfele desc;
