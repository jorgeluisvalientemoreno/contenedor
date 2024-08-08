select *
from open.ge_items_seriado
where serie in ('K-2870331-14','K-2870371-14','K-2736559-14','K-2736744-14');
select *
from open.servsusc
where sesususc in (17222862,17222773,48241400, 48241380)
  and not exists(select *
from open.elmesesu
where  emsssesu=sesunuse);
select *
from open.elmesesu
where  emsselme in (857920,863211,851955,2010051);

select *
from open.elemmedi
where elmecodi in ('K-2870331-14','K-2870371-14','K-2736559-14','K-2736744-14');
select *
from open.lectelme
where leemelme in (857920,863211,851955,2010051);


select *
from open.elmesesu
where  emsssesu in (
17250850
/*17250850,
17251310,
50713036,
50713056,
------
17254240,
50713056,
50713036,
50894202*/
)

/*contrato 17222862 medidor K-2870331-14
contrato 17222773  medidor  K-2870371-14
contrato 48241400  medidor K-2736559-14
contrato 48241380  medidor K-2736744-14
*/
