insert into OR_ZONA_BASE_ADM
with base as (
select z.operating_zone_id zona, 25 base
from or_operating_zone z
where description like 'GDGU%'
  and not exists(select null from OR_ZONA_BASE_ADM ad where ad.operating_zone_id = z.operating_zone_id )
  )
  select seq_or_zona_base_adm.nextval, zona, base
  from base

