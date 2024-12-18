column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuErrorCode      NUMBER;
  sbErrorMessage   VARCHAR2(4000);
  nuEjecucionFlujo NUMBER := 0;
BEGIN

  update open.LDC_PRODRERP p
     set p.prreobse = 'PROCESADO CON EXITO'
   Where p.prreprod in (51624538, 51645914)
     and p.prreobse = 'X';

  commit;
  dbms_output.put_line('Se actualizao observacion de forma exitosa');

exception
  when no_data_found then
    dbms_output.put_line('Error: ' || sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

