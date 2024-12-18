column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  
 update cargos set cargvabl = 2505
 where cargcodo = 157768176 and cargconc = 1021 and cargcuco = 3067090031;
 
 update cargos set cargvabl = 2158
 where cargcodo = 157768179 and cargconc = 1021 and cargcuco = 3068824711;
 
  update cargos set cargvabl = 2302
  where cargcodo = 157768191 and cargconc = 1021 and cargcuco = 3070723510;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/