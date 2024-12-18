column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

 delete from open.cargos where cargcuco = 3066620279 and cargconc = 811; 
 update open.cuencobr set cucovato = 11009 - 285 where cucocodi = 3066620279; 
 delete from open.cargos where cargcuco = -1 and cargconc = 24 and cargcaca = 4;
 commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/