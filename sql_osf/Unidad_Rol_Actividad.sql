SELECT ORDER_id Orden,
       activity_id || ' - ' || ge_items.description Actividad,
       OR_order_activity.Task_Type_Id
  FROM OR_order_activity, GE_ITEMS
 WHERE ORDER_id in (333694171, 346837311, 348292429)
   AND OR_order_activity.Activity_Id = ge_items.items_id;

SELECT /*+ index(OR_ACTIVIDADES_ROL UX_OR_ACTIVIDADES_ROL01)
                                 index(OR_ROL_UNIDAD_TRAB IDX_OR_ROL_UNIDAD_TRAB_01) */
 OR_ACTIVIDADES_ROL.ID_ROL || ' - ' || SA_ROLE.DESCRIPTION "ROLE",
 OR_ACTIVIDADES_ROL.id_actividad || ' - ' || GE_ITEMS.DESCRIPTION "ACTIVIDAD",
 OR_ROL_UNIDAD_TRAB.ID_UNIDAD_OPERATIVA "UNIDAD OPERATIVA"
  FROM OR_ROL_UNIDAD_TRAB, OR_ACTIVIDADES_ROL, SA_ROLE, GE_ITEMS
/*+ OR_BCActividad_Unitrab.fsbIsValidActOrder SAO168500 */
 WHERE 1 = 1
   and OR_ROL_UNIDAD_TRAB.id_unidad_operativa = &inuOperUnitId
   AND OR_ACTIVIDADES_ROL.id_rol = OR_ROL_UNIDAD_TRAB.id_rol
   AND SA_ROLE.ROLE_ID = OR_ACTIVIDADES_ROL.id_rol
   AND GE_ITEMS.ITEMS_ID = OR_ACTIVIDADES_ROL.id_actividad;
SELECT /*+ use_nl(OR_EXCEP_ACT_UNITRAB)
           index(OR_EXCEP_ACT_UNITRAB IDX_OR_EXCEP_ACT_UNITRAB_01) */
 OR_EXCEP_ACT_UNITRAB.id_actividad
  FROM OR_EXCEP_ACT_UNITRAB
 WHERE OR_EXCEP_ACT_UNITRAB.id_unidad_operativa = &inuOperUnitId;
