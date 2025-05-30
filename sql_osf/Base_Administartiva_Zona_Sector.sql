--(Base Administrativa)
select a.*, rowid
  from OPEN.GE_BASE_ADMINISTRA a
 where a.id_base_administra = 2;
--(Zonas por Bases Administrativas)
select a.*, rowid
  from OPEN.OR_ZONA_BASE_ADM a
 where a.id_base_administra = 2;
--(Zona Operativa)
select a.*, rowid
  from OPEN.OR_OPERATING_ZONE a
 where a.operating_zone_id in
       (select a1.operating_zone_id
          from OPEN.OR_ZONA_BASE_ADM a1
         where a1.id_base_administra = 2);
-- (Sector Operativo por Zona)
select a.*, rowid
  from OPEN.GE_SECTOROPE_ZONA a
 where a.id_zona_operativa in
       (select a2.operating_zone_id
          from OPEN.OR_OPERATING_ZONE a2
         where a2.operating_zone_id in
               (select a1.operating_zone_id
                  from OPEN.OR_ZONA_BASE_ADM a1
                 where a1.id_base_administra = 2));
--(Sector Operativo)                 
select a.*, rowid
  from OPEN.OR_OPERATING_SECTOR a
 where a.operating_sector_id in
       (select a3.id_sector_operativo
          from OPEN.GE_SECTOROPE_ZONA a3
         where a3.id_zona_operativa in
               (select a2.operating_zone_id
                  from OPEN.OR_OPERATING_ZONE a2
                 where a2.operating_zone_id in
                       (select a1.operating_zone_id
                          from OPEN.OR_ZONA_BASE_ADM a1
                         where a1.id_base_administra = 2)));
