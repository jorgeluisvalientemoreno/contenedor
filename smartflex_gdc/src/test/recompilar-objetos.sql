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
select owner,object_name, 'alter '||decode(object_type,'PACKAGE BODY','PACKAGE',object_type)|| ' ' || owner ||'.'||object_name || ' compile'||decode(object_type,'PACKAGE BODY',' BODY','') COMPILA_OBJETO
  from dba_objects
 where status = 'INVALID'
 and owner in ('OPEN','PERSONALIZACIONES','ADM_PERSON','MULTIEMPRESA','HOMOLOGACION','MIGRAGG');

  total_compilados NUMBER; 
  
begin
  for reg in cuInvalidos loop 
    begin
      
      execute immediate reg.COMPILA_OBJETO;

      dbms_output.put_line(reg.COMPILA_OBJETO);
    exception 
      when others then
        dbms_output.put_line(reg.owner||'.'||reg.object_name||': '||sqlerrm);
    end;
  end loop;
  DBMS_OUTPUT.PUT_LINE('Inicia funcion recompilar_sinonimos_invalidos ');
  total_compilados := sys.recompilar_sinonimos_invalidos;
  DBMS_OUTPUT.PUT_LINE('Total de sinónimos recompilados: ' || total_compilados);

  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/