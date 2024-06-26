select a.*, rowid from ORDEN_UOBYSOL a 
--where a.order_id in (132597198)
;

SELECT lo.*, rowid
  FROM orden_uobysol LO
 WHERE LO.ASIGNADO = 'N'
   AND nvl(asignacion, 0) < &inuCantidadIntentosActualizar;
SELECT order_id,
       package_id,
       asignacion,
       asignado,
       (select oo.Operating_Sector_Id
          from or_order oo
         where oo.order_id = LO.ORDER_ID
           and rownum = 1) SECTOR_OPERATIVO_ORDEN,
       lo.ordeobse
  FROM orden_uobysol LO
 WHERE LO.ASIGNADO = 'N'
   AND nvl(asignacion, 0) < &inuCantidadIntentos
      -- CA200-398. Se agrega esta secci?n para poder reasignar individualmente una orden
   AND &inuOrden IS NULL
UNION ALL
SELECT order_id,
       (select nvl(lorder.package_id, 0)
          from orden_uobysol lorder
         where lorder.order_id = &inuOrden
           and rownum = 1) package_id,
       NULL asignacion,
       CASE order_status_id
         WHEN &nuEstadoAsignado THEN
          'S'
         ELSE
          'N'
       END asignado,
       or_order.Operating_Sector_Id SECTOR_OPERATIVO_ORDEN,
       null
  FROM or_order
 WHERE order_id = &inuOrden;
