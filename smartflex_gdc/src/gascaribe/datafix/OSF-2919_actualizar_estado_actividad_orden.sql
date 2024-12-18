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

  update open.or_order_activity ooa
     set ooa.status = 'R'
   Where ooa.order_id = 330184691
     and ooa.order_activity_id = 323152744
     and ooa.status = 'F';

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

