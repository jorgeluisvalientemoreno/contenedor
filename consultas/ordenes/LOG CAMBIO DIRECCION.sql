with base as(select package_id, 
(select di.geograp_location_id from open.ab_address di where di.address_id=p.dir_instalacion_old) vieja,
(select da.geograp_location_id from open.ab_address da where da.address_id=p.dir_legalizada) nueva
from open.LDC_SOLICI_CAM_DAT_PRED p)

select base.package_id,
       base.vieja,
       (select description from open.ge_geogra_location lo where lo.geograp_location_id=base.vieja) desc_vieja,
       base.nueva,
       (select description from open.ge_geogra_location lo where lo.geograp_location_id=base.nueva) desc_nueva
from base

