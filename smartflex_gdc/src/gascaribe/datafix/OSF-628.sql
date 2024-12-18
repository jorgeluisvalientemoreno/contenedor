column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update OPEN.CC_QUOTATION
     set CC_QUOTATION.end_date = to_date('21/10/2022', 'DD/MM/YYYY')
   where CC_QUOTATION.package_id = 191717815;

  update open.ldc_cotizacion_comercial
     set ldc_cotizacion_comercial.fecha_vigencia = to_date('21/10/2022',
                                                           'DD/MM/YYYY')
   where ldc_cotizacion_comercial.sol_cotizacion = 191717815;

  commit;
  dbms_output.put_line('Se pudo actualiza fecha de vencimiento a 21/10/2022 en la cotizacion 191717815');

exception
  when others then
    rollback;
    dbms_output.put_line('No se pudo actualiza fecha de vencimiento en la cotizacion 191717815');
       
end;
/
  

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/