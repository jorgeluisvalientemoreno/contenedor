            SELECT order_id,
                   package_id,
                   asignacion,
                   asignado,
                   (select oo.Operating_Sector_Id
                      from open.or_order oo
                     where oo.order_id = LO.ORDER_ID
                     and rownum = 1) SECTOR_OPERATIVO_ORDEN
            FROM   OPEN.LDC_ORDER LO
            WHERE  LO.ASIGNADO = 'N'
            AND    nvl(asignacion, 0) < &inuCantidadIntentos
                  -- CA200-398. Se agrega esta secci?n para poder reasignar individualmente una orden
            AND    &inuOrden IS NULL
            --and lo.order_id = 32903042 --caso 200-2067

            UNION ALL
            SELECT order_id,
                   NULL package_id,
                   NULL asignacion,
                   CASE order_status_id
                       WHEN dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT') THEN
                        'S'
                       ELSE
                        'N'
                   END asignado,
                   or_order.Operating_Sector_Id SECTOR_OPERATIVO_ORDEN
            FROM   or_order
            WHERE  order_id = &inuOrden;
