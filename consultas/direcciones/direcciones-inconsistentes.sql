select u.tag,
       di.address_id,
       di.address_parsed,
       di.geograp_location_id localidad_direccion, 
       (select description from open.ge_geogra_location lo where lo.geograp_location_id=di.geograp_location_id) desc_loca_direccion,
       os.operating_sector_id sector_direccion,
       os.description desc_sector,
       sec.geo_loca_father_id localidad_sector,
       (select description from open.ge_geogra_location lo where lo.geograp_location_id=sec.geo_loca_father_id) desc_loca_sector
from open.ab_address di
join open.ab_segments se on di.segment_id = se.segments_id
join open.or_operating_sector os on os.operating_sector_id = se.operating_sector_id
join open.ge_geogra_location sec on sec.geograp_location_id=os.operating_sector_id and  sec.geo_loca_father_id !=di.geograp_location_id
left join giscaribe.unidadpredial@db_giscar u on u.idaddress = di.address_id
