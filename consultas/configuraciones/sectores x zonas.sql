select *
from open.ge_sectorope_zona z
left join open.or_operating_zone zo on zo.operating_zone_id=z.id_zona_operativa
where z.id_sector_operativo=8824;
