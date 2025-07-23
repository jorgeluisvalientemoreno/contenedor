column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  dbms_output.put_line('Inicia OSF-3946 !');

  update  cargos set cargpefa = 115291, cargpeco = 115246 where cargnuse = 52996371 and cargcuco = -1 ;
  update lectelme set leempefa = 115291 , leempecs = 115246  where leemsesu = 52996371 and leempefa = 115591 and leemclec= 'F';
  update conssesu set cosspefa = 115291 , cosspecs = 115246  where cosssesu  = 52996371 and cosspefa = 115591;

  commit;
  dbms_output.put_line('Fin OSF-3946 !');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/