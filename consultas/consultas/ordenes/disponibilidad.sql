select *
from open.OR_SCHED_AVAILABLE

where operating_unit_id=148
and date_>='01/02/2021';

select *
from open.or_operating_zone
where operating_zone_id=162;



alter session set current_schema=open;
--escalar
WITH father AS ( SELECT geo_area_father_id id FROM ge_organizat_area WHERE organizat_area_id = 766 ),
                 sector AS ( SELECT operating_sector_id id FROM or_order WHERE order_id = 198405096 )
SELECT /*+ ordered
                   index(ge_organizat_area PK_GE_ORGANIZAT_AREA)
                   index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                   index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   'X' existe
            FROM father, ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
               /*+ OR_BCOperatingUnit.fblExistReAssigOperUn <cuUpUnitsbyOrderUnit> SAO207207 */
            WHERE ge_organizat_area.organizat_area_id = father.id
            AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
         --   AND or_sched_available.date_ = TRUNC( sysdate )
            AND UT_DATE.FNUMINUTEOFDAY( UT_DATE.FDTSYSDATE ) between or_sched_available.hour_entrance AND or_sched_available.hour_exit
            AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND ge_sectorope_zona.id_sector_operativo = sector.id
            AND OR_BCSched.fsbIsValidActOrder
               ( or_sched_available.rol_exception_flag,
                 or_sched_available.sched_available_id,
                 198405096,
                 or_sched_available.operating_unit_id
               ) = 'Y'
;
--reasignar
WITH    father AS ( SELECT geo_area_father_id id FROM ge_organizat_area WHERE organizat_area_id = 766 ),
                    sector AS ( SELECT operating_sector_id id FROM or_order WHERE order_id = 198405096 )
            SELECT  /*+ ordered
                    index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                    index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                    index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                    'X' existe
            FROM father, ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
               /*+ OR_BCOperatingUnit.fblExistReAssigOperUn <cuParUnitsbyOrderUnit> SAO207207 */
            WHERE ge_organizat_area.geo_area_father_id = father.id
            AND ge_organizat_area.organizat_area_id <> 766
            AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
            AND or_sched_available.date_ = trunc(sysdate)
            AND UT_DATE.FNUMINUTEOFDAY( UT_DATE.FDTSYSDATE ) between or_sched_available.hour_entrance AND or_sched_available.hour_exit
            AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND ge_sectorope_zona.id_sector_operativo = sector.id
            AND OR_BCSched.fsbIsValidActOrder
               ( or_sched_available.rol_exception_flag,
                 or_sched_available.sched_available_id,
                 198405096,
                 or_sched_available.operating_unit_id
               ) = 'Y'
            AND rownum < 2;      
            
--delegar             
WITH sector AS ( SELECT operating_sector_id id FROM or_order WHERE order_id = 198405096 )
            SELECT /*+ ordered
                   index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                   index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                   index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   *
            FROM ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
               /*+ OR_BCOperatingUnit.fblExistReAssigOperUn <cuDwUnitsbyOrderUnit> SAO207207 */
            WHERE ge_organizat_area.geo_area_father_id = 766
            AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
            AND or_sched_available.date_ = trunc(sysdate)
         --   and ge_organizat_area.organizat_area_id=48
           AND  UT_DATE.FNUMINUTEOFDAY( UT_DATE.FDTSYSDATE ) between or_sched_available.hour_entrance AND or_sched_available.hour_exit
           AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND ge_sectorope_zona.id_sector_operativo = sector.id
            AND OR_BCSched.fsbIsValidActOrder
               ( or_sched_available.rol_exception_flag,
                 or_sched_available.sched_available_id,
                 198405096,
                 or_sched_available.operating_unit_id
               ) = 'Y'
         
; 
