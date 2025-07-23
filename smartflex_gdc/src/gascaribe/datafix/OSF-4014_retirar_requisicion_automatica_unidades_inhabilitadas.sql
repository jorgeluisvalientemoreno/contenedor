column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

  update or_operating_unit oou
     set oou.next_item_request = NULL, oou.item_req_frecuency = NULL
   where oou.next_item_request is not null
     and oou.oper_unit_status_id = 2;

  COMMIT;
  dbms_output.put_line('Se retiran requisicion automtica programada de unidades de trabajo inhabilitadas.');

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('Error no se puede retirar requisicion automtica programada de unidad de trabajo inhabilitadas. - ' ||
                         SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

