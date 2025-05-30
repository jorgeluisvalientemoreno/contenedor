with objetos as
 (select distinct ds.nombreobjeto from objetos_accion ds)
select a.*
  from dba_source a, objetos
 where upper(a.TEXT) like '%' || upper(objetos.nombreobjeto) || '%';

/*with objetos as
 (select distinct ds.name
    from dba_source ds
   where upper(ds.TEXT) like upper('%OAL_%')
     and ds.owner = 'OPEN');

with objetos as
 (select distinct ds.nombreobjeto from objetos_accion ds)
select a.*
  from OPEN.LDC_PROCEDIMIENTO_OBJ a, objetos
 where upper(a.procedimiento) like
       '%' || upper(objetos.nombreobjeto) || '%';*/
--LDCPROCCREATRAMICERPRPTXML
--LDC_BOORDENES.PROINCUMPLENUEVAS
