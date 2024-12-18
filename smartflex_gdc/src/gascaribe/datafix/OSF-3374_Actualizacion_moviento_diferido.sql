column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia OSF-3374');

    update movidife set modicuap = 0 where modidife = 9481061 AND modisign = 'DB' and  modicuap = 24;
    update movidife set modicuap = 0 where modidife = 9481059 AND modisign = 'DB' and  modicuap = 24;
    update movidife set modicuap = 0 where modidife = 9481060 AND modisign = 'DB' and  modicuap = 24;

  dbms_output.put_line('Fin OSF-3374');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/