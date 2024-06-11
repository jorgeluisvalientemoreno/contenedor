select id, description
from
(
SELECT /*+
    ordered USE_NL(OR_OPERATING_UNIT OR_OPER_UNIT_STATUS constante)
 */
  UNIQUE
  OR_OPERATING_UNIT.OPERATING_UNIT_ID id,
  OR_OPERATING_UNIT.NAME description
FROM
  OR_OPERATING_UNIT,
  OR_OPER_UNIT_STATUS,
  (SELECT
          ge_boconstants.GetYes  Y ,
            OR_BOORDEROPERATINGUNIT .fsbGETBASSIGN_SCHED Programacion,
           OR_BOORDEROPERATINGUNIT.fsbGETBASSIGN_ROUTE Ruta
  FROM dual ) constante
  /*+ <ORADI> lista de valores pesada unidades operativas SAO202132 */
WHERE
         OR_OPER_UNIT_STATUS.OPER_UNIT_STATUS_ID = OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID
AND OR_OPER_UNIT_STATUS.VALID_FOR_ASSIGN     = constante.Y
AND OR_OPERATING_UNIT.VALID_FOR_ASSIGN           = constante.Y
AND OR_OPERATING_UNIT.ASSIGN_TYPE  NOT IN (constante.Programacion,constante.Ruta)
AND OR_BCACTIVIDAD_UNITRAB.FSBISVALIDACTIVITY (100003165 ,--OR_BOFWORDERRELATED.fnuGETACTIVITYTORELATED, -->Actividad adicional
											   OR_OPERATING_UNIT.OPERATING_UNIT_ID ) = constante.Y
ORDER BY OR_OPERATING_UNIT.NAME
)
/*@ where @
@ id = :id @
@ description like :description @*/
;
----lista orpai
alter session set current_schema="OPEN";
SELECT /*+ ordered
                           index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                           index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                           index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                           index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                           index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                     distinct or_operating_unit.operating_unit_id id, or_operating_unit.name description
                FROM ge_sectorope_zona, or_zona_base_adm, or_operating_unit, or_oper_unit_status,
                     or_ope_uni_task_type
                 /*+ OR_BOFW_ListOfValues.OpUniByTasTypWithOutSchedule SAO194140 */
                WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
                  AND ge_sectorope_zona.id_zona_operativa = nvl(or_operating_unit.operating_zone_id, ge_sectorope_zona.id_zona_operativa)
                  AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
                  AND or_operating_unit.valid_for_assign = 'Y'
                  AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
                  AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
                  AND or_ope_uni_task_type.task_type_id = 12155
                  AND ge_sectorope_zona.id_sector_operativo = 368
                  AND or_oper_unit_status.valid_for_assign = 'Y'
                  AND or_operating_unit.assign_type not in ('S',--or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                            'R'--or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                            )
                   AND ( SELECT OR_BcActividad_Unitrab.fsbIsValidActOrder
                                (
                                    154530894, --nuOrder,
                                    or_operating_unit.operating_unit_id
                                )
                            FROM dual
                        ) = 'Y'
                        
