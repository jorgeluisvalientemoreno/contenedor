select *
  from dba_source a
 where upper(a.TEXT) like upper('%COD_DATOADICION_UNIDADOPER%');
