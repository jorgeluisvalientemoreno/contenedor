select o.order_id,
             system,
             dataorder,
             initdate,
             finaldate,
             changedate,
             messagecode,
             messagetext,
             state,
             fecha_recepcion,
             fecha_procesado,
             fecha_notificado,
             veces_procesado,
             o.operating_unit_id
        from open.LDCI_ORDENESALEGALIZAR r, open.or_order o
       where /*r.fecha_recepcion>=trunc(sysdate)
       and system  in ('WS_LUDYREVP','WS_LUDYREPXREV')
       and*/ o.order_id=r.order_id
       --and o.task_type_id=10450
       --and r.dataorder like '%|3314|%'
       and o.order_id in (260635669)
