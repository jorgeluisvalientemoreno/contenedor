SELECT DISTINCT  O.ORDER_ID,  OPEN.OR_BcActividad_Unitrab.fsbIsValidActOrder(O.order_id,&UNIDAD)
FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A, /*OPEN.MO_PACKAGES P,*/ OPEN.ge_sectorope_zona Z
WHERE O.ORDER_ID=A.ORDER_ID
--  AND A.PACKAGE_ID=P.PACKAGE_ID
  AND O.TASK_TYPE_ID=12161
  AND O.ORDER_STATUS_ID=0
  AND O.operating_sector_id =Z.id_sector_operativo
  AND Z.id_zona_operativa=OPEN.daor_operating_unit.fnugetoperating_zone_id(&UNIDAD)
  AND EXISTS(SELECT *
            FROM   OPEN.ab_address 
            WHERE  ab_address.address_id(+) = O.external_address_id
             AND   OPEN.OR_BcActividad_Unitrab.fsbIsValidActOrder(O.order_id,&UNIDAD)  = 'Y');
             SELECT OPEN.daor_operating_unit.fnugetoperating_zone_id(3330) FROM DUAL;
             SELECT OPEN.daor_operating_zone.fsbGetManage_Route(171) FROM DUAL; 
             
 
