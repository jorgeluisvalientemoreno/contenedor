select *
  from open.homologacion_servicios a
 where upper(a.servicio_origen) like upper('%PR_BOPRODUCT%')
union
select *
  from open.homologacion_servicios a
 where upper(a.servicio_destino) like upper('%PR_BOPRODUCT%');
