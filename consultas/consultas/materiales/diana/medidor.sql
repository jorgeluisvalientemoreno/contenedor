select *
from open.ge_items_seriado
where serie in ('R-72939-Y','O-21201538-12 ');
select *
from open.elemmedi
where elmecodi in ('R-72939-Y','O-21201538-12 ');
select *
from open.ge_items_tipo_at_val 
where id_items_seriado in (1979730,1199449);
select *
from open.elmesesu
where emsscoem in ('R-72939-Y','O-21201538-12 ');
select *
from open.suscripc
where suscclie=198452;
