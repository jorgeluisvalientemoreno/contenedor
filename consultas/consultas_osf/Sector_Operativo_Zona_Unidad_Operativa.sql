-- ORCOR / ZONAS
SELECT /*+ ordered
           index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
           index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
           index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
           index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
 OOU.operating_unit_id || ' - ' || OOU.name unidad_operativa,
 GZC.ZONE_CLASSIF_ID || ' - ' || GZC.DESCRIPTION Clasificacion_Zona,
 OOS.OPERATING_SECTOR_ID || ' - ' || OOS.DESCRIPTION Sector_operativo
  FROM OPEN.GE_ZONE_CLASSIF      GZC,
       OPEN.OR_OPERATING_ZONE    OOZ,
       OPEN.OR_OPERATING_SECTOR  OOS,
       open.ge_sectorope_zona    GSZ,
       open.or_operating_unit    OOU,
       open.or_oper_unit_status  OOUS,
       open.or_ope_uni_task_type OOUTT
 WHERE OOUS.oper_unit_status_id = OOU.oper_unit_status_id
   AND OOU.operating_zone_id = GSZ.id_zona_operativa
   AND OOUTT.operating_unit_id = OOU.operating_unit_id
   and GSZ.id_zona_operativa = OOZ.operating_zone_id
   and GSZ.id_sector_operativo = OOS.OPERATING_SECTOR_ID
   and GZC.ZONE_CLASSIF_ID = OOZ.zone_classif_id
   AND OOU.operating_unit_id in (1530, 1529, 1531)
   AND OOS.OPERATING_SECTOR_ID = 756
 group by OOU.operating_unit_id || ' - ' || OOU.name,
          GZC.ZONE_CLASSIF_ID || ' - ' || GZC.DESCRIPTION,
          OOZ.operating_zone_id || ' - ' || OOZ.description,
          OOS.OPERATING_SECTOR_ID || ' - ' || OOS.DESCRIPTION;

SELECT /*+ ordered
           index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
           index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
           index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
           index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
 GE_ZONE_CLASSIF.ZONE_CLASSIF_ID || ' - ' || GE_ZONE_CLASSIF.DESCRIPTION Clasificacion_Zona,
 OR_OPERATING_ZONE.operating_zone_id || ' - ' ||
 OR_OPERATING_ZONE.description Zona,
 OR_OPERATING_SECTOR.OPERATING_SECTOR_ID || ' - ' ||
 OR_OPERATING_SECTOR.DESCRIPTION Sector_operativo
--OPEN.GE_ZONE_CLASSIF.*
  FROM OPEN.GE_ZONE_CLASSIF,
       OPEN.OR_OPERATING_ZONE,
       OPEN.OR_OPERATING_SECTOR,
       open.ge_sectorope_zona,
       open.or_operating_unit,
       open.or_oper_unit_status,
       open.or_ope_uni_task_type
 WHERE or_oper_unit_status.oper_unit_status_id =
       or_operating_unit.oper_unit_status_id
   AND or_operating_unit.operating_zone_id =
       ge_sectorope_zona.id_zona_operativa
   AND or_ope_uni_task_type.operating_unit_id =
       or_operating_unit.operating_unit_id
   and ge_sectorope_zona.id_zona_operativa =
       OR_OPERATING_ZONE.operating_zone_id
   and ge_sectorope_zona.id_sector_operativo =
       OR_OPERATING_SECTOR.OPERATING_SECTOR_ID
   and GE_ZONE_CLASSIF.ZONE_CLASSIF_ID = OR_OPERATING_ZONE.zone_classif_id
   AND or_operating_unit.operating_unit_id = 4442
--and OR_OPERATING_SECTOR.OPERATING_SECTOR_ID = 411
 group by GE_ZONE_CLASSIF.ZONE_CLASSIF_ID || ' - ' ||
          GE_ZONE_CLASSIF.DESCRIPTION,
          OR_OPERATING_ZONE.operating_zone_id || ' - ' ||
          OR_OPERATING_ZONE.description,
          OR_OPERATING_SECTOR.OPERATING_SECTOR_ID || ' - ' ||
          OR_OPERATING_SECTOR.DESCRIPTION;

SELECT /*+ ordered
         index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
         index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
         index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
         index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
 or_operating_unit.operating_unit_id || ' - ' || or_operating_unit.name unidad_operativa,
 open.ge_sectorope_zona.id_sectorope_zona
  FROM open.ge_sectorope_zona,
       open.or_operating_unit,
       open.or_oper_unit_status,
       open.or_ope_uni_task_type
/*+ OR_BCOperUnit_Admin.fsbValidOperUnitAssign SAO168500 */
 WHERE or_oper_unit_status.oper_unit_status_id =
       or_operating_unit.oper_unit_status_id
   AND or_operating_unit.operating_zone_id =
       ge_sectorope_zona.id_zona_operativa
   AND or_ope_uni_task_type.operating_unit_id =
       or_operating_unit.operating_unit_id
   AND or_operating_unit.operating_unit_id in (1530, 1529, 1531)
      --AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
   AND ge_sectorope_zona.id_sector_operativo = 756
--AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
--AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
/*AND or_operating_unit.assign_type not in
(or_bcorderoperatingunit.csbASSIGN_SCHED,
 or_bcorderoperatingunit.csbASSIGN_ROUTE)*/
--AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,inuOperUnitId) = or_boconstants.csbSI
;
