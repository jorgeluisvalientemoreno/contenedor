--consulta ordenes Pendientes para el periodo de consumo especificado
SELECT a.product_id PRODUCTO,
       decode(a.subscription_id,
              null,
              OPEN.PKTBLSERVSUSC.FNUGETSESUSUSC(a.product_id),
              a.subscription_id) CONTRATO,
       a.order_id ORDEN,
       OPEN.DAOR_ORDER.FNUGETORDER_STATUS_ID(A.ORDER_ID) || '-' ||
       open.daor_order_status.fsbgetdescription(OPEN.DAOR_ORDER.FNUGETORDER_STATUS_ID(A.ORDER_ID)) ESTADO,
       a.task_type_id || '-' ||
       open.daor_task_type.fsbgetdescription(a.task_type_id) TIPO_TRABAJO,
       a.operating_sector_id || '-' ||
       open.daor_operating_sector.fsbgetdescription(a.operating_sector_id,
                                                    null) SECTOR_ORDEN,
       a.operating_unit_id || '-' ||
       open.daor_operating_unit.fsbgetname(a.operating_unit_id, null) UNIDAD_OPERATIVA,
       li.fecha_recepcion,
       decode(li.state,
              'P',
              'P -  Pendiente',
              'N',
              'N - Notificado',
              'EN',
              'EN - Notificado con Error',
              li.state) estado_integra,
       li.messagetext
  FROM open.or_order_activity a, open.ldci_ordenesalegalizar li
 WHERE a.order_id = li.order_id(+)
   AND a.order_activity_id in
       (select l.leemdocu
          from open.lectelme l
         where l.leemdocu = a.order_activity_id
           and l.leempecs = 101961)
   AND A.status = 'R'
   order by  li.fecha_recepcion Asc
