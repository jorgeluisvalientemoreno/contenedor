ALTER SESSION SET CURRENT_SCHEMA="OPEN";
WITH sector AS (
                SELECT operating_sector_id id FROM or_order WHERE order_id = 43411825
            )
            SELECT /*+ ordered
                       index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                       index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                       index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   ge_organizat_area.organizat_area_id OPERATING_UNIT_ID,
                   ge_organizat_area.name_ DESCRIPTION
              FROM ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
                   /*+ OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit SAO180890 */
             WHERE ge_organizat_area.geo_area_father_id = 766
               AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
               AND or_sched_available.date_ = TRUNC( UT_DATE.FDTSYSDATE )
               AND UT_DATE.FNUMINUTEOFDAY( UT_DATE.FDTSYSDATE ) between or_sched_available.hour_entrance AND or_sched_available.hour_exit
               AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
               AND ge_sectorope_zona.id_sector_operativo = sector.id
               AND OR_BCSched.fsbIsValidActOrder
                   ( or_sched_available.rol_exception_flag,
                     or_sched_available.sched_available_id,
                     43411825,
                     or_sched_available.operating_unit_id
                   ) = 'Y'
                   
                --AND ge_organizat_area.organizat_area_id =2938
                ;
                
SELECT *
FROM OPEN.or_sched_available
WHERE OPERATING_UNIT_ID=2938;
