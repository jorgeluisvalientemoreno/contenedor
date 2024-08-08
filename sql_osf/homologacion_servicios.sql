select *
  from homologacion_servicios a
 where upper(a.servicio_origen) like upper('%UPDPRODUCT_STATUS_ID%')
union
select *
  from homologacion_servicios a
 where upper(a.servicio_destino) like upper('%UPDPRODUCT_STATUS_ID%');
