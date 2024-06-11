SELECT O.order_id||'|'||9225||'|'||16141||'||'||A.order_activity_id ||'>0;COMMENT0>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||3;Se realiz� revision de la informaci�n del usuario en nuestros sistemas y se encontraron inconsistencias en la ruta con la cual se realiza la entrega de las facturas, lo cual puede ser la causa de que se presente la falta de entrega de la factura, por lo que se realiz� solicitud para corregir la infomraci�n y poder entregar la factura al usuario comocorresponde|'
FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
WHERE A.ORDER_ID=O.ORDER_ID
  AND O.ORDER_ID IN (67734310);




SELECT O.order_id||'|'||&causal||'|'||&persona||'|FECHA_REGISTRO_QUEJA='||OPEN.DAMO_PACKAGES.FDTGETREQUEST_DATE(a.package_id,null)||';AREA_REAL_CAUSANT='||O.OPERATING_UNIT_ID||';FECHA_REGISTRO_RECLAMO='||OPEN.DAMO_PACKAGES.FDTGETREQUEST_DATE(a.package_id,null)||'|'||A.order_activity_id ||'>1;COMMENT0>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||3;El cliente cuenta con una orden de verificacion fuera de ruta, cambio de ciclo el predio y/o cambio de direccion a suscriptores, con la cual se realizaran los ajustes necesarios para la entrega de la factura a conformidad, se legaliza el reclamo y se realizar� seguimiento a la legalizaci�n de la orden y al cambio realizado en nuestros sistemas al cliente.|'||CASE WHEN CREATED_DATE>='25/JAN/2016' THEN SYSDATE ELSE CREATED_DATE+15 END||';'||CASE WHEN CREATED_DATE>='25/JAN/2016' THEN SYSDATE ELSE CREATED_DATE+15 END
FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY A
WHERE A.ORDER_ID=O.ORDER_ID
  AND O.ORDER_ID IN (
SELECT c.ORDER_ID
FROM OPEN.OR_ORDER c
WHERE c.ORDER_ID IN (40720697
));
