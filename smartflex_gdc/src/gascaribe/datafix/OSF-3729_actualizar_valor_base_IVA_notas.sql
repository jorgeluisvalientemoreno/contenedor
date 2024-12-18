column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  UPDATE cargos SET cargvabl =  19140
  where cargcodo = 158321860 and cargcuco = 3067037088 and cargconc = 1022;

  UPDATE cargos SET cargvabl =  293989
  where cargcodo = 158321860 and cargcuco = 3067037088 and cargconc = 1035;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/