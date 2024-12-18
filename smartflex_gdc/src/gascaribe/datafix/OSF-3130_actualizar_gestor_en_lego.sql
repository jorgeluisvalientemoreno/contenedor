column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    update OPEN.LDC_ANEXOLEGALIZA a
      set a.agente_id = 228
    where a.order_id = 233619179;

    COMMIT;
    dbms_output.put_line('Se actualiza el agente 227 - ODONADO3 asociado a la orden 233619179 con el nuevo agente  228 - ODONADO4');

exception
  when others then
    ROLLBACK;
    dbms_output.put_line('Error - ' || sqlerrm);

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/