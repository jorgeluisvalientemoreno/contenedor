column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  cursor cuInvalidos is
  select owner,object_type, object_name
    from dba_objects
  where status = 'INVALID'
  and owner in ('OPEN','PERSONALIZACIONES','ADM_PERSON');

  nuCantidad number;
begin
  select count(1)
    into nuCantidad
    from dba_objects
   where status = 'INVALID'
     and owner in ('OPEN','PERSONALIZACIONES','ADM_PERSON');
  dbms_output.put_line('Hay '||nuCantidad||' objetos invalidos.');

  if nuCantidad > 0 then
    dbms_output.put_line('OWNER|TIPO|NOMBRE');
    for reg in cuInvalidos loop 
      dbms_output.put_line(reg.owner||'|'||reg.object_type||'|'||reg.object_name);
    end loop;
  end if;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/