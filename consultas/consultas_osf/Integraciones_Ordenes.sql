select r.*, rowid
  from open.LDCI_ORDENESALEGALIZAR r
 where system in ('WS_LUDYREVP', 'WS_LUDYREPXREV')
   and r.order_id = 275457678;
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
 where system in ('WS_LUDYREVP', 'WS_LUDYREPXREV')
   and o.order_id = r.order_id
   and o.task_type_id = 10795
   and o.order_status_id in (5)
---and o.causal_id = 9265
;
/*
Se requiere validar el siguiente error 
(Orden n° 246628469|3379|15902||238522491>0;;;;|||1277;Prueba suspensión por seguridad CM 
error: LA ORDEN NO SE LEGALIZO CORRECTAMENTE  >> Proceso termino con errores : 
No se ha digitado Lectura [1004641711]) 
generado desde la legalización de orden de trabajo n° 246628469 con el tt 12155 intentando legalizar con causal 
de incumplimiento 3379 se debe revisar si es correcto que el sistema solicite la lectura para este 
tipo de causales que estan configuradas como no obligatorias.
*/
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
 where --r.fecha_recepcion>=trunc(sysdate)
--and system  in ('WS_LUDYREVP','WS_LUDYREPXREV')
--and 
 o.order_id = r.order_id
--and o.task_type_id=10450
--and r.dataorder like '%|3314|%'
 and o.order_id in (287583099)

