SELECT /*+ ordered
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                       index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
 or_boconstants.csbSI
  FROM ge_sectorope_zona,
       or_zona_base_adm,
       or_operating_unit,
       or_oper_unit_status,
       or_ope_uni_task_type
/*+ OR_BCOperUnit_Admin.fsbValidOperUnitAssign SAO168500 */
 WHERE or_oper_unit_status.oper_unit_status_id =
       or_operating_unit.oper_unit_status_id
   AND or_operating_unit.admin_base_id =
       or_zona_base_adm.id_base_administra
   AND or_zona_base_adm.operating_zone_id =
       ge_sectorope_zona.id_zona_operativa
   AND or_ope_uni_task_type.operating_unit_id =
       or_operating_unit.operating_unit_id
   AND or_operating_unit.operating_unit_id = inuOperUnitId
   AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
   AND ge_sectorope_zona.id_sector_operativo = ircOrder.operating_sector_id
   AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
   AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
   AND or_operating_unit.assign_type not in
       (or_bcorderoperatingunit.csbASSIGN_SCHED,
        or_bcorderoperatingunit.csbASSIGN_ROUTE)
   AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,
                                                 inuOperUnitId) =
       or_boconstants.csbSI;
