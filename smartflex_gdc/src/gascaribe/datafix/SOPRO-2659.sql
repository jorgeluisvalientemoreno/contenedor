column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


begin
  UPDATE "OPEN".mo_packages
        SET attention_date = null,motive_status_id = 13
        WHERE package_id in (10660465);
  UPDATE "OPEN".mo_component
        SET attention_date = null, motive_status_id = 15
        WHERE package_id in (10660465);
  UPDATE "OPEN".MO_MOTIVE
        SET attention_date = null, status_change_date = null, motive_status_id = 1
        WHERE package_id in (10660465);
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/