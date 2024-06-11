SELECT *
FROM OPEN.GE_ITEMS
WHERE ITEMS_ID=4294464;
SELECT *
FROM OPEN.OR_ACTIVIDADES_ROL
WHERE ID_ACTIVIDAD=4294739;
SELECT *
FROM OPEN.OR_ROL_UNIDAD_TRAB
WHERE ID_ROL=243;


select *
from open.or_task_types_items ti, open.or_actividades_rol ro, open.sa_role r
where ti.items_id=ro.id_actividad
and ti.items_id=4000361
and r.role_id=ro.id_rol


SELECT A.ITEMS_ID, A.DESCRIPTION,U.OPERATING_UNIT_ID, U.NAME, R.ROLE_ID, R.NAME, u.operating_unit_id, u.name, u.operating_zone_id,u.admin_base_id, ti.task_type_id, open.daor_task_type.fsbgetdescription(ti.task_type_id, null) desc_titr
FROM OPEN.OR_ACTIVIDADES_ROL AR, OPEN.SA_ROLE R, OPEN.GE_ITEMS A,  OPEN.OR_ROL_UNIDAD_TRAB rolun, open.or_operating_unit u, open.or_task_types_items ti
WHERE ID_ACTIVIDAD=a.ITEMS_ID
  AND AR.ID_ROL=R.ROLE_ID
  and rolun.id_rol=r.role_id
  and u.operating_unit_id=rolun.id_unidad_operativa
  --and operating_unit_id=1886
  and ti.items_id=a.items_id 
  --and ti.task_type_id in (10169,10546,10547,10881,10882,10884,10917,10918,12521,12523,12524,12526,12528);
  and ti.items_id=100009085
  
  select *
  from open.or_ope_uni_task_type
  where operating_unit_id=3060
    and task_type_id=12150;
    
    
    
    
    WITH unit_exception AS(
SELECT   /*+  index(OR_EXCEP_ACT_UNITRAB IDX1_OR_EXCEP_ACT_UNITRAB_01)*/ 
         OR_EXCEP_ACT_UNITRAB.id_actividad
         FROM    OPEN.OR_EXCEP_ACT_UNITRAB
       WHERE OR_EXCEP_ACT_UNITRAB.id_unidad_operativa = &inuOperatingUnit)
       SELECT     /*+ index(OR_ACTIVIDADES_ROL UX_OR_ACTIVIDADES_ROL01)        index(OR_ROL_UNIDAD_TRAB IDX_OR_ROL_UNIDAD_TRAB_01)*/
       OR_ACTIVIDADES_ROL.id_actividad            
    FROM    OPEN.OR_ROL_UNIDAD_TRAB, OPEN.OR_ACTIVIDADES_ROL   /*+ OR_BcActividad_Unitrab.GetActivitiesByUnit SAO168500 */ 
    WHERE   OR_ROL_UNIDAD_TRAB.id_unidad_operativa = &inuOperatingUnit
      AND OR_ACTIVIDADES_ROL.id_rol = OR_ROL_UNIDAD_TRAB.id_rol
      AND OR_ACTIVIDADES_ROL.id_actividad not in (select id_actividad FROM unit_exception)
      AND ID_ACTIVIDAD=100005257;
      
      
      
SELECT unique activity_id FROM open.OR_order_activity WHERE ORDER_id = &inuOrderId
            minus (SELECT /*+ index(OR_ACTIVIDADES_ROL UX_OR_ACTIV+
1IDADES_ROL01) index(OR_ROL_UNIDAD_TRAB IDX_OR_ROL_UNIDAD_TRAB_01) */ OR_ACTIVIDADES_ROL.id_actividad
FROM    open.OR_ROL_UNIDAD_TRAB, open.OR_ACTIVIDADES_ROL /*+ OR_BCActividad_Unitrab.fsbIsValidActOrder SAO168500 */
WHERE   OR_ROL_UNIDAD_TRAB.id_unidad_operativa = &inuOperUnitId
AND OR_ACTIVIDADES_ROL.id_rol = OR_ROL_UNIDAD_TRAB.id_rol
AND not exists(SELECT   /*+ use_nl(OR_EXCEP_ACT_UNITRAB) index(OR_EXCEP_ACT_UNITRAB IDX_OR_EXCEP_ACT_UNITRAB_01) */
 OR_EXCEP_ACT_UNITRAB.id_actividad 
 FROM   open.OR_EXCEP_ACT_UNITRAB 
 WHERE OR_EXCEP_ACT_UNITRAB.id_unidad_operativa = &inuOperUnitId AND OR_EXCEP_ACT_UNITRAB.id_actividad = OR_ACTIVIDADES_ROL.id_actividad))
