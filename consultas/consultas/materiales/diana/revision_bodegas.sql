select m.*, open.dage_items_Seriado.fsbgetserie(m.id_items_seriado)
from open.or_uni_item_bala_mov m
where operating_unit_id=3040
  and items_id=10004070
  and movement_type='D'
  and not exists(select null from open.or_uni_item_bala_mov m2 where m2.operating_unit_id=m.operating_unit_id and m2.items_id=m.items_id and m2.movement_type='I' and m2.id_items_seriado=m.id_items_seriado);
  
  select *
  from open.ge_items_seriado m
  where operating_unit_id=1870
   and items_id=10004070
   and id_items_estado_inv in (1,12,3)
   and not exists(select null from open.or_uni_item_bala_mov m2 where m2.operating_unit_id=m.operating_unit_id and m2.items_id=m.items_id and m2.movement_type='I' and m2.id_items_seriado=m.id_items_seriado);

select m.*, open.dage_items_Seriado.fsbgetserie(m.id_items_seriado)
from open.or_uni_item_bala_mov m
where operating_unit_id=1870
  and items_id=10004070
  and movement_type='I'
  and not exists(select null from open.or_uni_item_bala_mov m2 where m2.operating_unit_id=m.operating_unit_id and m2.items_id=m.items_id and m2.movement_type='D' and m2.id_items_seriado=m.id_items_seriado)
  and not exists(select null from open.ge_items_seriado m2 where m2.operating_unit_id=m.operating_unit_id and m2.items_id=m.items_id and m2.id_items_seriado=m.id_items_seriado);

select m.*, open.dage_items_Seriado.fsbgetserie(m.id_items_seriado)
from open.or_uni_item_bala_mov m
where operating_unit_id=1870
  and items_id=10004070   ;
  
select *
from open.ge_items_Seriado s, open.or_uni_item_bala_mov m
where serie in ('K-2910192-14','K-2909849-14','K-2909934-14','K-2909965-14','K-2910018-14','K-2910021-14','K-2910107-14','K-2909825-14','K-2909941-14','K-2840263-14','K-2840277-14','K-2839861-14','K-2839844-14','K-2839544-14','K-2909806-14','K-2909432-14','K-2909444-14','K-2909446-14','K-2909436-14','K-2909420-14','K-2910290-14','K-2910284-14','K-2910319-14','K-2910321-14','K-2910327-14','K-2910318-14','K-2910301-14','K-2910069-14','K-2910325-14','K-2910323-14','K-2910322-14','K-2910068-14','F-5863621-14','F-5863821-14','K-2569194-13','K-2421342-13','F-6004721-14','F-6004821-14','F-6004621-14','F-6132121-14','F-6132321-14','F-6132221-14','F-6132421-14','F-6132621-14','F-5914021-14','F-5913921-14','F-5829121-14','F-5829221-14','F-5829421-14','F-5829321-14','F-5829521-14','F-5829621-14','F-5829821-14','F-5829721-14','F-5829921-14','F-5830021-14','F-5900721-14','F-5900221-14','F-5900421-14','F-5900121-14','F-5900321-14','F-5900521-14','K-2779487-14','K-2779399-14','K-2779409-14','K-2779541-14','K-2779537-14','K-2779484-14','K-2779566-14','K-2779572-14','K-2779556-14','K-2839871-14','K-2839873-14','K-2839713-14','K-2839835-14','K-2839795-14','K-2839907-14','K-2839686-14','K-2839657-14','K-2839579-14','K-2839635-14','K-2839537-14','K-2839519-14','K-2839566-14','K-2839638-14','K-2839714-14','K-2839709-14','K-2840375-14','K-2840293-14','K-2840292-14','K-2840284-14','K-2840281-14','K-2840356-14','K-2840302-14','K-2840471-14','K-2840283-14','K-2840296-14','K-2840301-14','K-2840244-14','K-2840484-14','K-2840487-14','K-2840401-14','K-2840322-14','K-2840358-14','K-2840266-14','K-2840335-14','K-2840330-14','F-4394321-14','F-4394221-14','K-2779760-14','K-2840859-14','K-2707177-14','K-2707186-14','K-2707319-14','K-2707669-14','K-2707449-14','K-2707585-14','K-2707583-14','K-2707551-14','K-2707582-14','K-2707540-14','K-2779349-14','K-2779587-14','K-2779673-14','K-2779685-14','K-2779668-14','K-2779594-14','K-2779615-14','K-2779780-14')  
  and s.id_items_seriado=m.id_items_Seriado
  and m.id_items_estado_inv=5
  and m.operating_unit_id!=1870
  and not exists(select null from open.or_uni_item_bala_mov m2 where m2.id_items_seriado=s.id_items_Seriado and m2.operating_unit_id=1870 and m2.movement_type='D');
select *
from open.ge_items_Seriado s
where serie in ('K-2910192-14','K-2909849-14','K-2909934-14','K-2909965-14','K-2910018-14','K-2910021-14','K-2910107-14','K-2909825-14','K-2909941-14','K-2840263-14','K-2840277-14','K-2839861-14','K-2839844-14','K-2839544-14','K-2909806-14','K-2909432-14','K-2909444-14','K-2909446-14','K-2909436-14','K-2909420-14','K-2910290-14','K-2910284-14','K-2910319-14','K-2910321-14','K-2910327-14','K-2910318-14','K-2910301-14','K-2910069-14','K-2910325-14','K-2910323-14','K-2910322-14','K-2910068-14','F-5863621-14','F-5863821-14','K-2569194-13','K-2421342-13','F-6004721-14','F-6004821-14','F-6004621-14','F-6132121-14','F-6132321-14','F-6132221-14','F-6132421-14','F-6132621-14','F-5914021-14','F-5913921-14','F-5829121-14','F-5829221-14','F-5829421-14','F-5829321-14','F-5829521-14','F-5829621-14','F-5829821-14','F-5829721-14','F-5829921-14','F-5830021-14','F-5900721-14','F-5900221-14','F-5900421-14','F-5900121-14','F-5900321-14','F-5900521-14','K-2779487-14','K-2779399-14','K-2779409-14','K-2779541-14','K-2779537-14','K-2779484-14','K-2779566-14','K-2779572-14','K-2779556-14','K-2839871-14','K-2839873-14','K-2839713-14','K-2839835-14','K-2839795-14','K-2839907-14','K-2839686-14','K-2839657-14','K-2839579-14','K-2839635-14','K-2839537-14','K-2839519-14','K-2839566-14','K-2839638-14','K-2839714-14','K-2839709-14','K-2840375-14','K-2840293-14','K-2840292-14','K-2840284-14','K-2840281-14','K-2840356-14','K-2840302-14','K-2840471-14','K-2840283-14','K-2840296-14','K-2840301-14','K-2840244-14','K-2840484-14','K-2840487-14','K-2840401-14','K-2840322-14','K-2840358-14','K-2840266-14','K-2840335-14','K-2840330-14','F-4394321-14','F-4394221-14','K-2779760-14','K-2840859-14','K-2707177-14','K-2707186-14','K-2707319-14','K-2707669-14','K-2707449-14','K-2707585-14','K-2707583-14','K-2707551-14','K-2707582-14','K-2707540-14','K-2779349-14','K-2779587-14','K-2779673-14','K-2779685-14','K-2779668-14','K-2779594-14','K-2779615-14','K-2779780-14')  
  and s.id_items_seriado not in (
   select m.id_items_seriado
from open.or_uni_item_bala_mov m
where operating_unit_id=1870
  and items_id=10004070
  and movement_type='D'
  and not exists(select null from open.or_uni_item_bala_mov m2 where m2.operating_unit_id=m.operating_unit_id and m2.items_id=m.items_id and m2.movement_type='I' and m2.id_items_seriado=m.id_items_seriado) );

select *
from open.or_uni_item_bala_mov
where id_items_seriado=1962844;

select *
from open.ge_items_seriado
where serie='BQ-15c';
SELECT *
FROM OPEN.GE_ERROR_LOG
WHERE ERROR_LOG_ID=663176608;




