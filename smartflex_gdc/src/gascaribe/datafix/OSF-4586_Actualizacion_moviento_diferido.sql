column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia OSF-4586');

    update movidife set modicuap = 0 where modidife = 20873764 AND modisign = 'DB' and  modicuap = 36;
    update movidife set modicuap = 0 where modidife = 20873763 AND modisign = 'DB' and  modicuap = 36;

  dbms_output.put_line('Fin OSF-4586');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/