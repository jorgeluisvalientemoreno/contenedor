select * from open.or_order o where o.order_id = 128616258;
select e.*, rowid
  from open.ldc_encuesta e
 where e.orden_id = 128616258
   and e.respuesta = '1045';
select a.*, rowid
  from open.ldc_log_encuesta a
 where a.inconveniente like '%Servicio LDC_BOVENTASFNB.PRTRAMITE100101%'
   and a.orden_id = 128616258
 order by a.fecha_registro desc
