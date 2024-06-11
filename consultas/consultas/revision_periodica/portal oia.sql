select *
from ldci_mesaenvws
where mesafech>='18/03/2018'
  and mesadefi in ('WS_TRASLADO_MATERIALES','WS_RESERVA_MATERIALES','WS_PEDIDO_MATERIALES');
  select *
  from or_ope_uni_task_type
  where operating_unit_id=2396
    and task_type_id=10747;
    
     SELECT s.procedimiento
         FROM ldci_infoadicionalot s
        WHERE s.sistema = 'WS_PORTALOIA'
          AND s.operacion = 'APROBACION_RP';
          
  
SELECT MENSAJE_ID,
             SISTEMA_ID,
             ORDER_ID,
             XML_SOLICITUD,
             ESTADO,
             OPERACION,
             proceso_externo_id ,
             fecha_recepcion ,
             fecha_procesado ,
             fecha_notificado ,
             cod_error_osf,
             msg_error_osf,
             ESTADO
        FROM LDCI_INFGESTOTMOV
     WHERE /*ESTADO in ('P' \*,'GE','EN'*\
           )
       AND */ SISTEMA_ID LIKE NVL('WS_PORTALOIA', '%')
         AND OPERACION LIKE NVL('APROBACION_RP', '%');
          
