SELECT l.*, o.task_type_id
FROM OPEN.LDCI_INFGESTOTMOV l, open.or_order o
WHERE UPPER(SISTEMA_ID) LIKE 'WS_LUDYREPXREV'
  and fecha_recepcion>='27/07/2018'
  and o.order_id=l.order_id
  and o.task_type_id=10450
