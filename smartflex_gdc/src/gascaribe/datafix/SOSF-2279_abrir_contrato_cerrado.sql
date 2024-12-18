column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

  update open.ge_contrato gc set gc.status = 'AB', gc.fecha_cierre = null  WHERE gc.id_contratista= 2989 and gc.id_contrato = 6181; 
  Commit;
  dbms_output.put_line('Actualiza estado de contrato 6181 de CE por AB');

exception
  when others then
  rollback;
  dbms_output.put_line('Error NO Actualiza estado de contrato 6181 de CE por AB - ' || SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/