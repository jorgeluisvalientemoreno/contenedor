select distinct a.name
  from dba_source a
 where upper(a.TEXT) like upper('%ORDEN GENERADA DESDE GOPC%');
