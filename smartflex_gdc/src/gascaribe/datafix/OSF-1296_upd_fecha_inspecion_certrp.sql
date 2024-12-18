column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia datafix OSF-1296');
  
  dbms_output.put_line('Actualizando la fecha 11/10/0222 10:05:00 a. m. por 11/10/2022 10:05:00 a. m. del contrato 67310298'); 
  
  update ldc_certificados_oia
  set fecha_inspeccion = '11/10/2022 10:05:00'
  where certificados_oia_id = 3821416;
  
  dbms_output.put_line('Actualizando la fecha 7/12/0202 por 7/12/2020 del contrato 67034404'); 
  
  update ldc_certificados_oia
  set fecha_inspeccion = '7/12/2020'
  where certificados_oia_id = 3246439;
  
  dbms_output.put_line('Actualizando la fecha 6/08/2012 por 6/08/2022 del contrato 67322989');
  
  update ldc_certificados_oia
  set fecha_inspeccion = '6/08/2022'
  where certificados_oia_id = 3801862;
  
  dbms_output.put_line('Actualizando la fecha 18/07/2009 por 18/09/2020 del contrato 6105009'); 
  
  update ldc_certificados_oia
  set fecha_inspeccion = '18/09/2020'
  where certificados_oia_id = 3133648;
  
  dbms_output.put_line('Actualizando la fecha 19/12/0202 por 19/12/2020 del contrato 67039024'); 
  
  update ldc_certificados_oia
  set fecha_inspeccion = '19/12/2020'
  where certificados_oia_id = 3258290;
  
  dbms_output.put_line('Actualizando la fecha 8/10/2015 por 8/10/2018 del contrato 66760976'); 
  
  update ldc_certificados_oia
  set fecha_inspeccion = '8/10/2018'
  where certificados_oia_id = 1856028;
  
  commit;
  
  dbms_output.put_line('Termina datafix OSF-1296');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/