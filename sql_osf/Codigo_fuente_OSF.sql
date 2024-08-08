select s.name from dba_source s where upper(s.TEXT) like upper('%ldc_cotizacion_comercial%') group by s.name
