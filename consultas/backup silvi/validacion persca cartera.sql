SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
            FROM lectelme a
            inner join or_order_activity b
            on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
            WHERE LEEMSESU = 4300484
            AND LEEMCLEC = 'T'
            AND pkg_BCOrdenes.fnuObtieneTipoTrabajo( b.ORDER_ID) =
               (SELECT LPA.TASK_TYPE_ID
                  FROM LDC_PROCESO_ACTIVIDAD LPA
                 WHERE LPA.PROCESO_ID = 3
                   AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
           ORDER BY leemfele desc;
